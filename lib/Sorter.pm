# implement this

# 2011 Hatena インターンシップ事前課題1(Sorter.pm)
# Author: hrk623

use strict;
use warnings;

package Sorter;

sub new {
		my $class = shift;
		my $list = [];
		return bless $list, $class;
}

# ミューテーター関数
# pre: 
# post: @lst has the same values as @_
sub set_values{
		my $list = shift;
		@{$list} = @_
}

# リストのアクセス関数
# pre: 
# post: returns @lst
sub get_values{
		my $list = shift;
		return @{$list};
}

# ソート関数
# pre: lst has +/- integers
# post: $lst[i] ≦ $lst[i+1] for all 0 ≦ i < @lst - 1
sub sort{
		my $list = shift;
		&quick_sort($list, 0, @{$list} - 1);
}

# トップダウン再帰なソート(クイックソート)
# T(n) ∈ O(nlogn) and Ω(n ** 2)
# input: $list, $lo, $hi
# pre: $hi, $lo, @list[i] ∈ Integer & 0 ≦ $lo ≦ i ≦ $hi < @list - 1, 
# post: $list[i] ≦ $list[i+1] ∀i: $lo ≦ i < $hi - 1
sub quick_sort {
		my ($list, $lo, $hi) = @_;
	
		if( $hi <= $lo ){	return;	}
		
		# Pick the value at the last of the list as a pivot
		my $pivot_value = $list->[$hi];

		my $smaller_pos = $lo;
		my $larger_pos = $hi - 1; # last one taken as a pivot
		
		while ($smaller_pos < $larger_pos){
				
				# check if the value should be swapped
				my $swap_left = $list->[$smaller_pos] >= $pivot_value? 1 : 0;	
				my $swap_right =  $list->[$larger_pos] < $pivot_value? 1 : 0;				
						

				# if we found two values to be swapped, swap them.
				if ($swap_left && $swap_right) {
						&swap($list, $smaller_pos, $larger_pos);
						$swap_left = $swap_right = 0;
				}

				# if the value needs not be swapped, we move on.
				$smaller_pos++ unless $swap_left;
				$larger_pos-- unless $swap_right;
		}

		# pivot needs to be inserted at the appropriate pos.
		if( $list->[$smaller_pos] < $pivot_value ){ $smaller_pos++; }
		&swap($list, $hi, $smaller_pos);

		# recursively apply quick_sort
		quick_sort($list, $lo, $smaller_pos - 1);
		quick_sort($list, $smaller_pos + 1, $hi);
}

# スワップ関数
# - $list[i] と $list[j] を入れ替える
# input: $i, $j
# pre: $i, $j ∈ integer and 0 ≦ $i, $j < @lst - 1, 
# post: $list[i] = $list[j] and $list[j] = $list[i]
sub swap{
		my ($list, $i, $j) = @_;
		my $temp = $list->[$i];
		$list->[$i] = $list->[$j];
		$list->[$j] = $temp;
}


package main;

sub isSorted{
		my @list = shift;
		
		my $prev = $list[0] if @list > 0;
		
		foreach  (@list){
				return 0 if $prev > $_; # false
		}
		return 1 # true
}

# Test 1: 入力サイズが１
my $sorter1 = Sorter->new();
$sorter1->set_values(0);
$sorter1->sort;
my $result = $sorter1->get_values;
print isSorted($result) ? "PASS Test 1\n": "Fail at Test 1\n";

# Test 1: 入力が全て正の整数
$sorter1 = Sorter->new();
$sorter1->set_values(23, 456, 87, 23, 56,, 8, 2, 145, 67, 944, 236, 687, 20, 30, 40, 10991);
$sorter1->sort;
 $result = $sorter1->get_values;
print isSorted($result) ? "PASS Test 2\n": "Fail at Test 2\n";

# Test 1: 入力サイズが整数
$sorter1 = Sorter->new();
$sorter1->set_values(-2, 4, 7, 2, -3, -5, 4, -9, -23, - 543, -123, -98, 23, 56, 12, 78, -3);
$sorter1->sort;
$result = $sorter1->get_values;
print isSorted($result) ? "PASS Test 3\n": "Fail at Test 3\n";
