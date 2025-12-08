-- Blind 75 Problems Seed Data
-- Each problem uses stdin/stdout format for test cases
-- Test cases: at least 2 visible + 1 hidden per problem

DO $$
DECLARE
    pid UUID;
BEGIN

-- ============================================================
-- ARRAY PROBLEMS
-- ============================================================

-- 1. Two Sum (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Two Sum', 'two-sum',
E'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.\n\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.\n\nReturn the answer sorted in ascending order.\n\nInput format: First line contains space-separated array elements. Second line contains the target.\nOutput format: Two space-separated indices.',
'EASY', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        // Write your solution here\n        return new int[]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        int target = Integer.parseInt(sc.nextLine().trim());\n        int[] r = new Solution().twoSum(nums, target);\n        Arrays.sort(r);\n        System.out.println(r[0] + " " + r[1]);\n    }\n}',
E'def two_sum(nums, target):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\ntarget = int(input())\nr = two_sum(nums, target)\nr.sort()\nprint(r[0], r[1])',
E'function twoSum(nums, target) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = lines[0].split(" ").map(Number);\nconst target = Number(lines[1]);\nconst r = twoSum(nums, target).sort((a,b)=>a-b);\nconsole.log(r[0] + " " + r[1]);')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'2 7 11 15\n9', '0 1', false),
(gen_random_uuid(), pid, E'3 2 4\n6', '1 2', false),
(gen_random_uuid(), pid, E'3 3\n6', '0 1', true);

-- 2. Best Time to Buy and Sell Stock (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Best Time to Buy and Sell Stock', 'best-time-to-buy-and-sell-stock',
E'You are given an array prices where prices[i] is the price of a given stock on the ith day.\n\nYou want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.\n\nReturn the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.\n\nInput: space-separated prices\nOutput: maximum profit',
'EASY', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int maxProfit(int[] prices) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] prices = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) prices[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().maxProfit(prices));\n    }\n}',
E'def max_profit(prices):\n    # Write your solution here\n    pass\n\nprices = list(map(int, input().split()))\nprint(max_profit(prices))',
E'function maxProfit(prices) {\n    // Write your solution here\n}\n\nconst prices = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(maxProfit(prices));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '7 1 5 3 6 4', '5', false),
(gen_random_uuid(), pid, '7 6 4 3 1', '0', false),
(gen_random_uuid(), pid, '2 4 1', '2', true);

-- 3. Contains Duplicate (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Contains Duplicate', 'contains-duplicate',
E'Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.\n\nInput: space-separated integers\nOutput: true or false',
'EASY', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public boolean containsDuplicate(int[] nums) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().containsDuplicate(nums));\n    }\n}',
E'def contains_duplicate(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(str(contains_duplicate(nums)).lower())',
E'function containsDuplicate(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(containsDuplicate(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 1', 'true', false),
(gen_random_uuid(), pid, '1 2 3 4', 'false', false),
(gen_random_uuid(), pid, '1 1 1 3 3 4 3 2 4 2', 'true', true);

-- 4. Product of Array Except Self (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Product of Array Except Self', 'product-of-array-except-self',
E'Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].\n\nYou must write an algorithm that runs in O(n) time and without using the division operation.\n\nInput: space-separated integers\nOutput: space-separated products',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int[] productExceptSelf(int[] nums) {\n        // Write your solution here\n        return new int[]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        int[] r = new Solution().productExceptSelf(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < r.length; i++) { if (i > 0) sb.append(" "); sb.append(r[i]); }\n        System.out.println(sb);\n    }\n}',
E'def product_except_self(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(" ".join(map(str, product_except_self(nums))))',
E'function productExceptSelf(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(productExceptSelf(nums).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 4', '24 12 8 6', false),
(gen_random_uuid(), pid, '-1 1 0 -3 3', '0 0 9 0 0', false),
(gen_random_uuid(), pid, '2 3 5', '15 10 6', true);

-- 5. Maximum Subarray (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Maximum Subarray', 'maximum-subarray',
E'Given an integer array nums, find the subarray with the largest sum, and return its sum.\n\nInput: space-separated integers\nOutput: maximum subarray sum',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int maxSubArray(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().maxSubArray(nums));\n    }\n}',
E'def max_sub_array(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(max_sub_array(nums))',
E'function maxSubArray(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(maxSubArray(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '-2 1 -3 4 -1 2 1 -5 4', '6', false),
(gen_random_uuid(), pid, '1', '1', false),
(gen_random_uuid(), pid, '5 4 -1 7 8', '23', true);

-- 6. Maximum Product Subarray (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Maximum Product Subarray', 'maximum-product-subarray',
E'Given an integer array nums, find a subarray that has the largest product, and return the product.\n\nInput: space-separated integers\nOutput: maximum product',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int maxProduct(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().maxProduct(nums));\n    }\n}',
E'def max_product(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(max_product(nums))',
E'function maxProduct(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(maxProduct(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2 3 -2 4', '6', false),
(gen_random_uuid(), pid, '-2 0 -1', '0', false),
(gen_random_uuid(), pid, '-2 3 -4', '24', true);

-- 7. Find Minimum in Rotated Sorted Array (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Find Minimum in Rotated Sorted Array', 'find-minimum-in-rotated-sorted-array',
E'Given a sorted rotated array of unique elements, return the minimum element. You must write an algorithm that runs in O(log n) time.\n\nInput: space-separated integers\nOutput: minimum element',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int findMin(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().findMin(nums));\n    }\n}',
E'def find_min(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(find_min(nums))',
E'function findMin(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(findMin(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '3 4 5 1 2', '1', false),
(gen_random_uuid(), pid, '4 5 6 7 0 1 2', '0', false),
(gen_random_uuid(), pid, '11 13 15 17', '11', true);

-- 8. Search in Rotated Sorted Array (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Search in Rotated Sorted Array', 'search-in-rotated-sorted-array',
E'Given a sorted rotated array of distinct integers and a target value, return the index if found, or -1 if not. You must write an algorithm with O(log n) runtime.\n\nInput: First line: space-separated array. Second line: target.\nOutput: index or -1',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int search(int[] nums, int target) {\n        // Write your solution here\n        return -1;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        int target = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().search(nums, target));\n    }\n}',
E'def search(nums, target):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\ntarget = int(input())\nprint(search(nums, target))',
E'function search(nums, target) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = lines[0].split(" ").map(Number);\nconst target = Number(lines[1]);\nconsole.log(search(nums, target));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4 5 6 7 0 1 2\n0', '4', false),
(gen_random_uuid(), pid, E'4 5 6 7 0 1 2\n3', '-1', false),
(gen_random_uuid(), pid, E'1\n0', '-1', true);

-- 9. 3Sum (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), '3Sum', 'three-sum',
E'Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.\n\nThe solution set must not contain duplicate triplets. Output each triplet sorted, one per line, triplets in lexicographic order.\n\nInput: space-separated integers\nOutput: each triplet on a line, space-separated, sorted',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public List<List<Integer>> threeSum(int[] nums) {\n        // Write your solution here\n        return new ArrayList<>();\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        List<List<Integer>> r = new Solution().threeSum(nums);\n        r.sort((a,b) -> { for(int i=0;i<3;i++){int c=a.get(i)-b.get(i);if(c!=0)return c;} return 0; });\n        for (List<Integer> t : r) System.out.println(t.get(0) + " " + t.get(1) + " " + t.get(2));\n    }\n}',
E'def three_sum(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nresult = three_sum(nums)\nresult.sort()\nfor t in result:\n    print(t[0], t[1], t[2])',
E'function threeSum(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconst r = threeSum(nums).sort((a,b)=>a[0]-b[0]||a[1]-b[1]||a[2]-b[2]);\nr.forEach(t=>console.log(t.join(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '-1 0 1 2 -1 -4', E'-1 -1 2\n-1 0 1', false),
(gen_random_uuid(), pid, '0 0 0', '0 0 0', false),
(gen_random_uuid(), pid, '0 1 1', '', true);

-- 10. Container With Most Water (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Container With Most Water', 'container-with-most-water',
E'You are given an integer array height of length n. There are n vertical lines drawn. Find two lines that together with the x-axis form a container that holds the most water. Return the maximum amount of water a container can store.\n\nInput: space-separated heights\nOutput: maximum area',
'MEDIUM', 'Array',
E'import java.util.*;\n\npublic class Solution {\n    public int maxArea(int[] height) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] h = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) h[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().maxArea(h));\n    }\n}',
E'def max_area(height):\n    # Write your solution here\n    pass\n\nheight = list(map(int, input().split()))\nprint(max_area(height))',
E'function maxArea(height) {\n    // Write your solution here\n}\n\nconst h = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(maxArea(h));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 8 6 2 5 4 8 3 7', '49', false),
(gen_random_uuid(), pid, '1 1', '1', false),
(gen_random_uuid(), pid, '4 3 2 1 4', '16', true);

-- ============================================================
-- BINARY PROBLEMS
-- ============================================================

-- 11. Sum of Two Integers (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Sum of Two Integers', 'sum-of-two-integers',
E'Given two integers a and b, return the sum of the two integers without using the operators + and -.\n\nInput: two space-separated integers\nOutput: their sum',
'MEDIUM', 'Binary',
E'import java.util.*;\n\npublic class Solution {\n    public int getSum(int a, int b) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        System.out.println(new Solution().getSum(Integer.parseInt(parts[0]), Integer.parseInt(parts[1])));\n    }\n}',
E'def get_sum(a, b):\n    # Write your solution here\n    pass\n\na, b = map(int, input().split())\nprint(get_sum(a, b))',
E'function getSum(a, b) {\n    // Write your solution here\n}\n\nconst [a, b] = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(getSum(a, b));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2', '3', false),
(gen_random_uuid(), pid, '2 3', '5', false),
(gen_random_uuid(), pid, '-1 1', '0', true);

-- 12. Number of 1 Bits (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Number of 1 Bits', 'number-of-1-bits',
E'Write a function that takes the binary representation of a positive integer and returns the number of set bits (1s).\n\nInput: a non-negative integer\nOutput: number of 1 bits',
'EASY', 'Binary',
E'import java.util.*;\n\npublic class Solution {\n    public int hammingWeight(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().hammingWeight(n));\n    }\n}',
E'def hamming_weight(n):\n    # Write your solution here\n    pass\n\nn = int(input())\nprint(hamming_weight(n))',
E'function hammingWeight(n) {\n    // Write your solution here\n}\n\nconst n = Number(require("fs").readFileSync("/dev/stdin","utf8").trim());\nconsole.log(hammingWeight(n));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '11', '3', false),
(gen_random_uuid(), pid, '128', '1', false),
(gen_random_uuid(), pid, '255', '8', true);

-- 13. Counting Bits (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Counting Bits', 'counting-bits',
E'Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1s in the binary representation of i.\n\nInput: integer n\nOutput: space-separated counts for 0 to n',
'EASY', 'Binary',
E'import java.util.*;\n\npublic class Solution {\n    public int[] countBits(int n) {\n        // Write your solution here\n        return new int[]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[] r = new Solution().countBits(n);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < r.length; i++) { if (i > 0) sb.append(" "); sb.append(r[i]); }\n        System.out.println(sb);\n    }\n}',
E'def count_bits(n):\n    # Write your solution here\n    pass\n\nn = int(input())\nprint(" ".join(map(str, count_bits(n))))',
E'function countBits(n) {\n    // Write your solution here\n}\n\nconst n = Number(require("fs").readFileSync("/dev/stdin","utf8").trim());\nconsole.log(countBits(n).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2', '0 1 1', false),
(gen_random_uuid(), pid, '5', '0 1 1 2 1 2', false),
(gen_random_uuid(), pid, '0', '0', true);

-- 14. Missing Number (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Missing Number', 'missing-number',
E'Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.\n\nInput: space-separated integers\nOutput: the missing number',
'EASY', 'Binary',
E'import java.util.*;\n\npublic class Solution {\n    public int missingNumber(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().missingNumber(nums));\n    }\n}',
E'def missing_number(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(missing_number(nums))',
E'function missingNumber(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(missingNumber(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '3 0 1', '2', false),
(gen_random_uuid(), pid, '0 1', '2', false),
(gen_random_uuid(), pid, '9 6 4 2 3 5 7 0 1', '8', true);

-- 15. Reverse Bits (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Reverse Bits', 'reverse-bits',
E'Reverse bits of a given 32 bits unsigned integer.\n\nInput: an unsigned integer\nOutput: the reversed bits integer (as unsigned)',
'EASY', 'Binary',
E'import java.util.*;\n\npublic class Solution {\n    public long reverseBits(long n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        long n = Long.parseLong(sc.nextLine().trim());\n        System.out.println(new Solution().reverseBits(n));\n    }\n}',
E'def reverse_bits(n):\n    # Write your solution here\n    pass\n\nn = int(input())\nprint(reverse_bits(n))',
E'function reverseBits(n) {\n    // Write your solution here\n}\n\nconst n = Number(require("fs").readFileSync("/dev/stdin","utf8").trim());\nconsole.log(reverseBits(n));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '43261596', '964176192', false),
(gen_random_uuid(), pid, '4294967293', '3221225471', false),
(gen_random_uuid(), pid, '0', '0', true);

-- ============================================================
-- DYNAMIC PROGRAMMING PROBLEMS
-- ============================================================

-- 16. Climbing Stairs (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Climbing Stairs', 'climbing-stairs',
E'You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?\n\nInput: integer n\nOutput: number of ways',
'EASY', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int climbStairs(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().climbStairs(n));\n    }\n}',
E'def climb_stairs(n):\n    # Write your solution here\n    pass\n\nn = int(input())\nprint(climb_stairs(n))',
E'function climbStairs(n) {\n    // Write your solution here\n}\n\nconst n = Number(require("fs").readFileSync("/dev/stdin","utf8").trim());\nconsole.log(climbStairs(n));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2', '2', false),
(gen_random_uuid(), pid, '3', '3', false),
(gen_random_uuid(), pid, '5', '8', true);

-- 17. Coin Change (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Coin Change', 'coin-change',
E'You are given coins of different denominations and a total amount. Return the fewest number of coins needed to make up that amount. If not possible, return -1.\n\nInput: First line: space-separated coin values. Second line: amount.\nOutput: minimum coins or -1',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int coinChange(int[] coins, int amount) {\n        // Write your solution here\n        return -1;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] coins = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) coins[i] = Integer.parseInt(parts[i]);\n        int amount = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().coinChange(coins, amount));\n    }\n}',
E'def coin_change(coins, amount):\n    # Write your solution here\n    pass\n\ncoins = list(map(int, input().split()))\namount = int(input())\nprint(coin_change(coins, amount))',
E'function coinChange(coins, amount) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst coins = lines[0].split(" ").map(Number);\nconst amount = Number(lines[1]);\nconsole.log(coinChange(coins, amount));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 5 10\n11', '2', false),
(gen_random_uuid(), pid, E'2\n3', '-1', false),
(gen_random_uuid(), pid, E'1\n0', '0', true);

-- 18. Longest Increasing Subsequence (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Increasing Subsequence', 'longest-increasing-subsequence',
E'Given an integer array nums, return the length of the longest strictly increasing subsequence.\n\nInput: space-separated integers\nOutput: length of LIS',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int lengthOfLIS(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().lengthOfLIS(nums));\n    }\n}',
E'def length_of_lis(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(length_of_lis(nums))',
E'function lengthOfLIS(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(lengthOfLIS(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '10 9 2 5 3 7 101 18', '4', false),
(gen_random_uuid(), pid, '0 1 0 3 2 3', '4', false),
(gen_random_uuid(), pid, '7 7 7 7 7 7 7', '1', true);

-- 19. Longest Common Subsequence (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Common Subsequence', 'longest-common-subsequence',
E'Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.\n\nInput: First line: text1. Second line: text2.\nOutput: length of LCS',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int longestCommonSubsequence(String text1, String text2) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String t1 = sc.nextLine().trim();\n        String t2 = sc.nextLine().trim();\n        System.out.println(new Solution().longestCommonSubsequence(t1, t2));\n    }\n}',
E'def longest_common_subsequence(text1, text2):\n    # Write your solution here\n    pass\n\nt1 = input().strip()\nt2 = input().strip()\nprint(longest_common_subsequence(t1, t2))',
E'function longestCommonSubsequence(text1, text2) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(longestCommonSubsequence(lines[0], lines[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'abcde\nace', '3', false),
(gen_random_uuid(), pid, E'abc\nabc', '3', false),
(gen_random_uuid(), pid, E'abc\ndef', '0', true);

-- 20. Word Break (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Word Break', 'word-break',
E'Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.\n\nInput: First line: string s. Second line: space-separated dictionary words.\nOutput: true or false',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public boolean wordBreak(String s, List<String> wordDict) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String s = sc.nextLine().trim();\n        String[] words = sc.nextLine().trim().split(" ");\n        System.out.println(new Solution().wordBreak(s, Arrays.asList(words)));\n    }\n}',
E'def word_break(s, word_dict):\n    # Write your solution here\n    pass\n\ns = input().strip()\nwords = input().strip().split()\nprint(str(word_break(s, words)).lower())',
E'function wordBreak(s, wordDict) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(wordBreak(lines[0], lines[1].split(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'leetcode\nleet code', 'true', false),
(gen_random_uuid(), pid, E'applepenapple\napple pen', 'true', false),
(gen_random_uuid(), pid, E'catsandog\ncats dog sand and cat', 'false', true);

-- 21. Combination Sum IV (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Combination Sum IV', 'combination-sum-iv',
E'Given an array of distinct integers nums and a target integer target, return the number of possible combinations that add up to target.\n\nInput: First line: space-separated nums. Second line: target.\nOutput: number of combinations',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int combinationSum4(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        int target = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().combinationSum4(nums, target));\n    }\n}',
E'def combination_sum4(nums, target):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\ntarget = int(input())\nprint(combination_sum4(nums, target))',
E'function combinationSum4(nums, target) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = lines[0].split(" ").map(Number);\nconsole.log(combinationSum4(nums, Number(lines[1])));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 2 3\n4', '7', false),
(gen_random_uuid(), pid, E'9\n3', '0', false),
(gen_random_uuid(), pid, E'1 2\n3', '3', true);

-- 22. House Robber (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'House Robber', 'house-robber',
E'You are a robber planning to rob houses along a street. Each house has a certain amount of money. Adjacent houses have security systems connected - if two adjacent houses are broken into, the police will be contacted. Return the maximum amount you can rob without alerting the police.\n\nInput: space-separated amounts\nOutput: maximum amount',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int rob(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().rob(nums));\n    }\n}',
E'def rob(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(rob(nums))',
E'function rob(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(rob(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 1', '4', false),
(gen_random_uuid(), pid, '2 7 9 3 1', '12', false),
(gen_random_uuid(), pid, '2 1 1 2', '4', true);

-- 23. House Robber II (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'House Robber II', 'house-robber-ii',
E'Houses are arranged in a circle. Adjacent houses cannot both be robbed. Return the maximum amount you can rob.\n\nInput: space-separated amounts\nOutput: maximum amount',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int rob(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().rob(nums));\n    }\n}',
E'def rob(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(rob(nums))',
E'function rob(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(rob(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2 3 2', '3', false),
(gen_random_uuid(), pid, '1 2 3 1', '4', false),
(gen_random_uuid(), pid, '1 2 3', '3', true);

-- 24. Decode Ways (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Decode Ways', 'decode-ways',
E'A message containing letters A-Z can be encoded to numbers using A=1, B=2, ..., Z=26. Given a string s containing only digits, return the number of ways to decode it.\n\nInput: string of digits\nOutput: number of ways to decode',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int numDecodings(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().numDecodings(sc.nextLine().trim()));\n    }\n}',
E'def num_decodings(s):\n    # Write your solution here\n    pass\n\nprint(num_decodings(input().strip()))',
E'function numDecodings(s) {\n    // Write your solution here\n}\n\nconst s = require("fs").readFileSync("/dev/stdin","utf8").trim();\nconsole.log(numDecodings(s));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '12', '2', false),
(gen_random_uuid(), pid, '226', '3', false),
(gen_random_uuid(), pid, '06', '0', true);

-- 25. Unique Paths (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Unique Paths', 'unique-paths',
E'A robot is located at the top-left corner of an m x n grid. It can only move right or down. How many unique paths are there to reach the bottom-right corner?\n\nInput: two space-separated integers m and n\nOutput: number of unique paths',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public int uniquePaths(int m, int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        System.out.println(new Solution().uniquePaths(Integer.parseInt(parts[0]), Integer.parseInt(parts[1])));\n    }\n}',
E'def unique_paths(m, n):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\nprint(unique_paths(m, n))',
E'function uniquePaths(m, n) {\n    // Write your solution here\n}\n\nconst [m, n] = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(uniquePaths(m, n));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '3 7', '28', false),
(gen_random_uuid(), pid, '3 2', '3', false),
(gen_random_uuid(), pid, '7 3', '28', true);

-- 26. Jump Game (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Jump Game', 'jump-game',
E'You are given an integer array nums. You are initially positioned at the first index. Each element represents your maximum jump length from that position. Return true if you can reach the last index, false otherwise.\n\nInput: space-separated integers\nOutput: true or false',
'MEDIUM', 'Dynamic Programming',
E'import java.util.*;\n\npublic class Solution {\n    public boolean canJump(int[] nums) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().canJump(nums));\n    }\n}',
E'def can_jump(nums):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nprint(str(can_jump(nums)).lower())',
E'function canJump(nums) {\n    // Write your solution here\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(canJump(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2 3 1 1 4', 'true', false),
(gen_random_uuid(), pid, '3 2 1 0 4', 'false', false),
(gen_random_uuid(), pid, '0', 'true', true);

-- ============================================================
-- GRAPH PROBLEMS
-- ============================================================

-- 27. Clone Graph (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Clone Graph', 'clone-graph',
E'Given a reference of a node in a connected undirected graph, return a deep copy. The graph is represented as adjacency list. First line: number of nodes n. Next n lines: neighbors of node i (1-indexed), space-separated. Output the same adjacency list format.\n\nInput: First line: n. Next n lines: neighbors of each node.\nOutput: Same adjacency list format.',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        List<List<Integer>> adj = new ArrayList<>();\n        for (int i = 0; i < n; i++) {\n            String line = sc.nextLine().trim();\n            List<Integer> neighbors = new ArrayList<>();\n            if (!line.isEmpty()) for (String s : line.split(" ")) neighbors.add(Integer.parseInt(s));\n            adj.add(neighbors);\n        }\n        // Clone the graph (deep copy)\n        List<List<Integer>> clone = new ArrayList<>();\n        for (List<Integer> nb : adj) clone.add(new ArrayList<>(nb));\n        for (List<Integer> nb : clone) {\n            StringBuilder sb = new StringBuilder();\n            for (int i = 0; i < nb.size(); i++) { if (i > 0) sb.append(" "); sb.append(nb.get(i)); }\n            System.out.println(sb);\n        }\n    }\n}',
E'def clone_graph(adj):\n    # Write your solution here - return deep copy of adjacency list\n    return [list(nb) for nb in adj]\n\nn = int(input())\nadj = []\nfor _ in range(n):\n    line = input().strip()\n    adj.append(list(map(int, line.split())) if line else [])\nresult = clone_graph(adj)\nfor nb in result:\n    print(" ".join(map(str, nb)))',
E'function cloneGraph(adj) {\n    // Write your solution here\n    return adj.map(nb => [...nb]);\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst adj = [];\nfor (let i = 1; i <= n; i++) adj.push(lines[i].trim() ? lines[i].trim().split(" ").map(Number) : []);\ncloneGraph(adj).forEach(nb => console.log(nb.join(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4\n2 4\n1 3\n2 4\n1 3', E'2 4\n1 3\n2 4\n1 3', false),
(gen_random_uuid(), pid, E'1\n', '', false),
(gen_random_uuid(), pid, E'2\n2\n1', E'2\n1', true);

-- 28. Course Schedule (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Course Schedule', 'course-schedule',
E'There are numCourses courses labeled 0 to numCourses-1. You are given prerequisites pairs where [a,b] means you must take b before a. Return true if you can finish all courses.\n\nInput: First line: numCourses. Second line: number of prerequisites p. Next p lines: a b (must take b before a).\nOutput: true or false',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public boolean canFinish(int numCourses, int[][] prerequisites) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int p = Integer.parseInt(sc.nextLine().trim());\n        int[][] prereqs = new int[p][2];\n        for (int i = 0; i < p; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            prereqs[i][0] = Integer.parseInt(parts[0]);\n            prereqs[i][1] = Integer.parseInt(parts[1]);\n        }\n        System.out.println(new Solution().canFinish(n, prereqs));\n    }\n}',
E'def can_finish(num_courses, prerequisites):\n    # Write your solution here\n    pass\n\nn = int(input())\np = int(input())\nprereqs = []\nfor _ in range(p):\n    a, b = map(int, input().split())\n    prereqs.append([a, b])\nprint(str(can_finish(n, prereqs)).lower())',
E'function canFinish(numCourses, prerequisites) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst p = Number(lines[1]);\nconst prereqs = [];\nfor (let i = 2; i < 2 + p; i++) { const [a,b] = lines[i].split(" ").map(Number); prereqs.push([a,b]); }\nconsole.log(canFinish(n, prereqs));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'2\n1\n1 0', 'true', false),
(gen_random_uuid(), pid, E'2\n2\n1 0\n0 1', 'false', false),
(gen_random_uuid(), pid, E'3\n2\n1 0\n2 1', 'true', true);

-- 29. Pacific Atlantic Water Flow (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Pacific Atlantic Water Flow', 'pacific-atlantic-water-flow',
E'Given an m x n matrix of heights, water can flow to adjacent cells (up/down/left/right) if the adjacent cell height is less than or equal. The Pacific ocean touches the left and top edges. The Atlantic ocean touches the right and bottom edges. Return coordinates where water can flow to both oceans, sorted by row then column.\n\nInput: First line: m n. Next m lines: space-separated heights.\nOutput: coordinates (row col) one per line, sorted.',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public List<int[]> pacificAtlantic(int[][] heights) {\n        // Write your solution here\n        return new ArrayList<>();\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        int[][] h = new int[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) h[i][j] = Integer.parseInt(parts[j]);\n        }\n        List<int[]> r = new Solution().pacificAtlantic(h);\n        r.sort((a,b) -> a[0]!=b[0] ? a[0]-b[0] : a[1]-b[1]);\n        for (int[] c : r) System.out.println(c[0] + " " + c[1]);\n    }\n}',
E'def pacific_atlantic(heights):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\nheights = [list(map(int, input().split())) for _ in range(m)]\nresult = pacific_atlantic(heights)\nresult.sort()\nfor r, c in result:\n    print(r, c)',
E'function pacificAtlantic(heights) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst h = [];\nfor (let i = 1; i <= m; i++) h.push(lines[i].split(" ").map(Number));\nconst r = pacificAtlantic(h).sort((a,b)=>a[0]-b[0]||a[1]-b[1]);\nr.forEach(c=>console.log(c[0]+" "+c[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 1\n1', '0 0', false),
(gen_random_uuid(), pid, E'2 2\n1 2\n3 4', E'0 1\n1 0\n1 1', false),
(gen_random_uuid(), pid, E'1 3\n1 2 3', E'0 0\n0 1\n0 2', true);

-- 30. Number of Islands (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Number of Islands', 'number-of-islands',
E'Given an m x n 2D binary grid which represents a map of 1s (land) and 0s (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.\n\nInput: First line: m n. Next m lines: space-separated 0s and 1s.\nOutput: number of islands',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public int numIslands(char[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        char[][] grid = new char[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) grid[i][j] = parts[j].charAt(0);\n        }\n        System.out.println(new Solution().numIslands(grid));\n    }\n}',
E'def num_islands(grid):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\ngrid = [input().split() for _ in range(m)]\nprint(num_islands(grid))',
E'function numIslands(grid) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst grid = [];\nfor (let i = 1; i <= m; i++) grid.push(lines[i].split(" "));\nconsole.log(numIslands(grid));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4 5\n1 1 1 1 0\n1 1 0 1 0\n1 1 0 0 0\n0 0 0 0 0', '1', false),
(gen_random_uuid(), pid, E'4 5\n1 1 0 0 0\n1 1 0 0 0\n0 0 1 0 0\n0 0 0 1 1', '3', false),
(gen_random_uuid(), pid, E'1 1\n1', '1', true);

-- 31. Longest Consecutive Sequence (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Consecutive Sequence', 'longest-consecutive-sequence',
E'Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence. You must write an O(n) algorithm.\n\nInput: space-separated integers\nOutput: length of longest consecutive sequence',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public int longestConsecutive(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String line = sc.nextLine().trim();\n        if (line.isEmpty()) { System.out.println(0); return; }\n        String[] parts = line.split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        System.out.println(new Solution().longestConsecutive(nums));\n    }\n}',
E'def longest_consecutive(nums):\n    # Write your solution here\n    pass\n\nline = input().strip()\nnums = list(map(int, line.split())) if line else []\nprint(longest_consecutive(nums))',
E'function longestConsecutive(nums) {\n    // Write your solution here\n}\n\nconst line = require("fs").readFileSync("/dev/stdin","utf8").trim();\nconst nums = line ? line.split(" ").map(Number) : [];\nconsole.log(longestConsecutive(nums));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '100 4 200 1 3 2', '4', false),
(gen_random_uuid(), pid, '0 3 7 2 5 8 4 6 0 1', '9', false),
(gen_random_uuid(), pid, '1', '1', true);

-- 32. Alien Dictionary (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Alien Dictionary', 'alien-dictionary',
E'There is a new alien language that uses the English alphabet but in a different order. Given a list of words sorted lexicographically by this new language rules, derive the order of letters. If invalid, return empty string.\n\nInput: words, one per line\nOutput: letters in order as a single string',
'HARD', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public String alienOrder(String[] words) {\n        // Write your solution here\n        return "";\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        List<String> list = new ArrayList<>();\n        while (sc.hasNextLine()) {\n            String line = sc.nextLine().trim();\n            if (!line.isEmpty()) list.add(line);\n        }\n        System.out.println(new Solution().alienOrder(list.toArray(new String[0])));\n    }\n}',
E'def alien_order(words):\n    # Write your solution here\n    pass\n\nimport sys\nwords = [line.strip() for line in sys.stdin if line.strip()]\nprint(alien_order(words))',
E'function alienOrder(words) {\n    // Write your solution here\n}\n\nconst words = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n").filter(w=>w.trim());\nconsole.log(alienOrder(words));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'wrt\nwrf\ner\nett\nrftt', 'wertf', false),
(gen_random_uuid(), pid, E'z\nx', 'zx', false),
(gen_random_uuid(), pid, E'z\nx\nz', '', true);

-- 33. Graph Valid Tree (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Graph Valid Tree', 'graph-valid-tree',
E'Given n nodes labeled from 0 to n-1 and a list of undirected edges, check whether these edges make up a valid tree.\n\nInput: First line: n and number of edges e. Next e lines: u v edges.\nOutput: true or false',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public boolean validTree(int n, int[][] edges) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] first = sc.nextLine().trim().split(" ");\n        int n = Integer.parseInt(first[0]), e = Integer.parseInt(first[1]);\n        int[][] edges = new int[e][2];\n        for (int i = 0; i < e; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            edges[i][0] = Integer.parseInt(parts[0]);\n            edges[i][1] = Integer.parseInt(parts[1]);\n        }\n        System.out.println(new Solution().validTree(n, edges));\n    }\n}',
E'def valid_tree(n, edges):\n    # Write your solution here\n    pass\n\nfirst = input().split()\nn, e = int(first[0]), int(first[1])\nedges = [list(map(int, input().split())) for _ in range(e)]\nprint(str(valid_tree(n, edges)).lower())',
E'function validTree(n, edges) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [n,e] = lines[0].split(" ").map(Number);\nconst edges = [];\nfor (let i = 1; i <= e; i++) edges.push(lines[i].split(" ").map(Number));\nconsole.log(validTree(n, edges));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'5 4\n0 1\n0 2\n0 3\n1 4', 'true', false),
(gen_random_uuid(), pid, E'5 5\n0 1\n1 2\n2 3\n1 3\n1 4', 'false', false),
(gen_random_uuid(), pid, E'1 0', 'true', true);

-- 34. Number of Connected Components (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Number of Connected Components in an Undirected Graph', 'number-of-connected-components',
E'Given n nodes labeled from 0 to n-1 and a list of undirected edges, find the number of connected components in the graph.\n\nInput: First line: n and number of edges e. Next e lines: u v.\nOutput: number of connected components',
'MEDIUM', 'Graph',
E'import java.util.*;\n\npublic class Solution {\n    public int countComponents(int n, int[][] edges) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] first = sc.nextLine().trim().split(" ");\n        int n = Integer.parseInt(first[0]), e = Integer.parseInt(first[1]);\n        int[][] edges = new int[e][2];\n        for (int i = 0; i < e; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            edges[i][0] = Integer.parseInt(parts[0]);\n            edges[i][1] = Integer.parseInt(parts[1]);\n        }\n        System.out.println(new Solution().countComponents(n, edges));\n    }\n}',
E'def count_components(n, edges):\n    # Write your solution here\n    pass\n\nfirst = input().split()\nn, e = int(first[0]), int(first[1])\nedges = [list(map(int, input().split())) for _ in range(e)]\nprint(count_components(n, edges))',
E'function countComponents(n, edges) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [n,e] = lines[0].split(" ").map(Number);\nconst edges = [];\nfor (let i = 1; i <= e; i++) edges.push(lines[i].split(" ").map(Number));\nconsole.log(countComponents(n, edges));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'5 3\n0 1\n1 2\n3 4', '2', false),
(gen_random_uuid(), pid, E'5 4\n0 1\n1 2\n2 3\n3 4', '1', false),
(gen_random_uuid(), pid, E'3 0', '3', true);

-- ============================================================
-- INTERVAL PROBLEMS
-- ============================================================

-- 35. Insert Interval (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Insert Interval', 'insert-interval',
E'You are given a sorted array of non-overlapping intervals and a new interval. Insert the new interval and merge if necessary. Return the resulting intervals.\n\nInput: First line: number of intervals n. Next n lines: start end. Last line: new interval start end.\nOutput: merged intervals, one per line.',
'MEDIUM', 'Interval',
E'import java.util.*;\n\npublic class Solution {\n    public int[][] insert(int[][] intervals, int[] newInterval) {\n        // Write your solution here\n        return new int[][]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] intervals = new int[n][2];\n        for (int i = 0; i < n; i++) {\n            String[] p = sc.nextLine().trim().split(" ");\n            intervals[i] = new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1])};\n        }\n        String[] np = sc.nextLine().trim().split(" ");\n        int[] ni = {Integer.parseInt(np[0]), Integer.parseInt(np[1])};\n        int[][] r = new Solution().insert(intervals, ni);\n        for (int[] iv : r) System.out.println(iv[0] + " " + iv[1]);\n    }\n}',
E'def insert(intervals, new_interval):\n    # Write your solution here\n    pass\n\nn = int(input())\nintervals = [list(map(int, input().split())) for _ in range(n)]\nnew_interval = list(map(int, input().split()))\nfor iv in insert(intervals, new_interval):\n    print(iv[0], iv[1])',
E'function insert(intervals, newInterval) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst intervals = [];\nfor (let i = 1; i <= n; i++) intervals.push(lines[i].split(" ").map(Number));\nconst ni = lines[n+1].split(" ").map(Number);\ninsert(intervals, ni).forEach(iv=>console.log(iv[0]+" "+iv[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\n1 3\n6 9\n11 15\n2 5', E'1 5\n6 9\n11 15', false),
(gen_random_uuid(), pid, E'5\n1 2\n3 5\n6 7\n8 10\n12 16\n4 8', E'1 2\n3 10\n12 16', false),
(gen_random_uuid(), pid, E'0\n5 7', '5 7', true);

-- 36. Merge Intervals (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Merge Intervals', 'merge-intervals',
E'Given an array of intervals where intervals[i] = [start, end], merge all overlapping intervals.\n\nInput: First line: n. Next n lines: start end.\nOutput: merged intervals, one per line, sorted by start.',
'MEDIUM', 'Interval',
E'import java.util.*;\n\npublic class Solution {\n    public int[][] merge(int[][] intervals) {\n        // Write your solution here\n        return new int[][]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] intervals = new int[n][2];\n        for (int i = 0; i < n; i++) {\n            String[] p = sc.nextLine().trim().split(" ");\n            intervals[i] = new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1])};\n        }\n        int[][] r = new Solution().merge(intervals);\n        for (int[] iv : r) System.out.println(iv[0] + " " + iv[1]);\n    }\n}',
E'def merge(intervals):\n    # Write your solution here\n    pass\n\nn = int(input())\nintervals = [list(map(int, input().split())) for _ in range(n)]\nfor iv in merge(intervals):\n    print(iv[0], iv[1])',
E'function merge(intervals) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst intervals = [];\nfor (let i = 1; i <= n; i++) intervals.push(lines[i].split(" ").map(Number));\nmerge(intervals).forEach(iv=>console.log(iv[0]+" "+iv[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4\n1 3\n2 6\n8 10\n15 18', E'1 6\n8 10\n15 18', false),
(gen_random_uuid(), pid, E'2\n1 4\n4 5', '1 5', false),
(gen_random_uuid(), pid, E'1\n1 1', '1 1', true);

-- 37. Non-overlapping Intervals (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Non-overlapping Intervals', 'non-overlapping-intervals',
E'Given an array of intervals, return the minimum number of intervals you need to remove to make the rest non-overlapping.\n\nInput: First line: n. Next n lines: start end.\nOutput: minimum removals',
'MEDIUM', 'Interval',
E'import java.util.*;\n\npublic class Solution {\n    public int eraseOverlapIntervals(int[][] intervals) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] intervals = new int[n][2];\n        for (int i = 0; i < n; i++) {\n            String[] p = sc.nextLine().trim().split(" ");\n            intervals[i] = new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1])};\n        }\n        System.out.println(new Solution().eraseOverlapIntervals(intervals));\n    }\n}',
E'def erase_overlap_intervals(intervals):\n    # Write your solution here\n    pass\n\nn = int(input())\nintervals = [list(map(int, input().split())) for _ in range(n)]\nprint(erase_overlap_intervals(intervals))',
E'function eraseOverlapIntervals(intervals) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst intervals = [];\nfor (let i = 1; i <= n; i++) intervals.push(lines[i].split(" ").map(Number));\nconsole.log(eraseOverlapIntervals(intervals));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4\n1 2\n2 3\n3 4\n1 3', '1', false),
(gen_random_uuid(), pid, E'3\n1 2\n1 2\n1 2', '2', false),
(gen_random_uuid(), pid, E'2\n1 2\n2 3', '0', true);

-- 38. Meeting Rooms (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Meeting Rooms', 'meeting-rooms',
E'Given an array of meeting time intervals consisting of start and end times, determine if a person could attend all meetings.\n\nInput: First line: n. Next n lines: start end.\nOutput: true or false',
'EASY', 'Interval',
E'import java.util.*;\n\npublic class Solution {\n    public boolean canAttendMeetings(int[][] intervals) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] intervals = new int[n][2];\n        for (int i = 0; i < n; i++) {\n            String[] p = sc.nextLine().trim().split(" ");\n            intervals[i] = new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1])};\n        }\n        System.out.println(new Solution().canAttendMeetings(intervals));\n    }\n}',
E'def can_attend_meetings(intervals):\n    # Write your solution here\n    pass\n\nn = int(input())\nintervals = [list(map(int, input().split())) for _ in range(n)]\nprint(str(can_attend_meetings(intervals)).lower())',
E'function canAttendMeetings(intervals) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst intervals = [];\nfor (let i = 1; i <= n; i++) intervals.push(lines[i].split(" ").map(Number));\nconsole.log(canAttendMeetings(intervals));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\n0 30\n5 10\n15 20', 'false', false),
(gen_random_uuid(), pid, E'2\n7 10\n2 4', 'true', false),
(gen_random_uuid(), pid, E'0', 'true', true);

-- 39. Meeting Rooms II (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Meeting Rooms II', 'meeting-rooms-ii',
E'Given an array of meeting time intervals, find the minimum number of conference rooms required.\n\nInput: First line: n. Next n lines: start end.\nOutput: minimum rooms needed',
'MEDIUM', 'Interval',
E'import java.util.*;\n\npublic class Solution {\n    public int minMeetingRooms(int[][] intervals) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] intervals = new int[n][2];\n        for (int i = 0; i < n; i++) {\n            String[] p = sc.nextLine().trim().split(" ");\n            intervals[i] = new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1])};\n        }\n        System.out.println(new Solution().minMeetingRooms(intervals));\n    }\n}',
E'def min_meeting_rooms(intervals):\n    # Write your solution here\n    pass\n\nn = int(input())\nintervals = [list(map(int, input().split())) for _ in range(n)]\nprint(min_meeting_rooms(intervals))',
E'function minMeetingRooms(intervals) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst intervals = [];\nfor (let i = 1; i <= n; i++) intervals.push(lines[i].split(" ").map(Number));\nconsole.log(minMeetingRooms(intervals));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\n0 30\n5 10\n15 20', '2', false),
(gen_random_uuid(), pid, E'2\n7 10\n2 4', '1', false),
(gen_random_uuid(), pid, E'4\n1 5\n2 6\n3 7\n4 8', '4', true);

-- ============================================================
-- LINKED LIST PROBLEMS
-- ============================================================

-- 40. Reverse a Linked List (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Reverse a Linked List', 'reverse-linked-list',
E'Given the head of a singly linked list, reverse the list and return the reversed list.\n\nInput: space-separated values of the linked list\nOutput: space-separated values of reversed list',
'EASY', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        List<Integer> list = new ArrayList<>();\n        for (String p : parts) list.add(Integer.parseInt(p));\n        Collections.reverse(list);\n        // Replace above with your linked list reversal logic\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < list.size(); i++) { if (i > 0) sb.append(" "); sb.append(list.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'def reverse_list(nums):\n    # Write your solution here\n    return nums[::-1]\n\nnums = list(map(int, input().split()))\nprint(" ".join(map(str, reverse_list(nums))))',
E'function reverseList(nums) {\n    // Write your solution here\n    return nums.reverse();\n}\n\nconst nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconsole.log(reverseList(nums).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 4 5', '5 4 3 2 1', false),
(gen_random_uuid(), pid, '1 2', '2 1', false),
(gen_random_uuid(), pid, '1', '1', true);

-- 41. Detect Cycle in a Linked List (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Detect Cycle in a Linked List', 'linked-list-cycle',
E'Given a linked list, determine if it has a cycle. Input represents the list values and the index where the tail connects to (-1 for no cycle).\n\nInput: First line: space-separated values. Second line: cycle index (-1 if no cycle).\nOutput: true or false',
'EASY', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int cycleIdx = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(cycleIdx >= 0 ? "true" : "false");\n    }\n}',
E'nums = list(map(int, input().split()))\ncycle_idx = int(input())\nprint("true" if cycle_idx >= 0 else "false")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst cycleIdx = Number(lines[1]);\nconsole.log(cycleIdx >= 0 ? "true" : "false");')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 2 0 -4\n1', 'true', false),
(gen_random_uuid(), pid, E'1 2\n-1', 'false', false),
(gen_random_uuid(), pid, E'1\n-1', 'false', true);

-- 42. Merge Two Sorted Lists (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Merge Two Sorted Lists', 'merge-two-sorted-lists',
E'Merge two sorted linked lists and return it as a sorted list.\n\nInput: First line: space-separated list1. Second line: space-separated list2.\nOutput: space-separated merged list',
'EASY', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String l1 = sc.nextLine().trim();\n        String l2 = sc.nextLine().trim();\n        List<Integer> merged = new ArrayList<>();\n        if (!l1.isEmpty()) for (String s : l1.split(" ")) merged.add(Integer.parseInt(s));\n        if (!l2.isEmpty()) for (String s : l2.split(" ")) merged.add(Integer.parseInt(s));\n        Collections.sort(merged);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < merged.size(); i++) { if (i > 0) sb.append(" "); sb.append(merged.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'l1 = input().strip()\nl2 = input().strip()\na = list(map(int, l1.split())) if l1 else []\nb = list(map(int, l2.split())) if l2 else []\nmerged = sorted(a + b)\nprint(" ".join(map(str, merged)))',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst a = lines[0].trim() ? lines[0].trim().split(" ").map(Number) : [];\nconst b = lines[1].trim() ? lines[1].trim().split(" ").map(Number) : [];\nconsole.log([...a,...b].sort((x,y)=>x-y).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 2 4\n1 3 4', '1 1 2 3 4 4', false),
(gen_random_uuid(), pid, E'\n', '', false),
(gen_random_uuid(), pid, E'\n0', '0', true);

-- 43. Merge K Sorted Lists (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Merge K Sorted Lists', 'merge-k-sorted-lists',
E'Merge k sorted linked lists and return it as one sorted list.\n\nInput: First line: k. Next k lines: space-separated sorted list (or empty for empty list).\nOutput: space-separated merged list',
'HARD', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int k = Integer.parseInt(sc.nextLine().trim());\n        List<Integer> all = new ArrayList<>();\n        for (int i = 0; i < k; i++) {\n            String line = sc.nextLine().trim();\n            if (!line.isEmpty()) for (String s : line.split(" ")) all.add(Integer.parseInt(s));\n        }\n        Collections.sort(all);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < all.size(); i++) { if (i > 0) sb.append(" "); sb.append(all.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'k = int(input())\nall_nums = []\nfor _ in range(k):\n    line = input().strip()\n    if line:\n        all_nums.extend(map(int, line.split()))\nall_nums.sort()\nprint(" ".join(map(str, all_nums)))',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst k = Number(lines[0]);\nconst all = [];\nfor (let i = 1; i <= k; i++) if (lines[i] && lines[i].trim()) lines[i].trim().split(" ").forEach(n=>all.push(Number(n)));\nconsole.log(all.sort((a,b)=>a-b).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\n1 4 5\n1 3 4\n2 6', '1 1 2 3 4 4 5 6', false),
(gen_random_uuid(), pid, E'1\n', '', false),
(gen_random_uuid(), pid, E'2\n1\n2', '1 2', true);

-- 44. Remove Nth Node From End of List (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Remove Nth Node From End of List', 'remove-nth-node-from-end',
E'Given the head of a linked list, remove the nth node from the end of the list and return its head.\n\nInput: First line: space-separated list values. Second line: n.\nOutput: space-separated remaining list',
'MEDIUM', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int n = Integer.parseInt(sc.nextLine().trim());\n        List<Integer> list = new ArrayList<>();\n        for (String p : parts) list.add(Integer.parseInt(p));\n        list.remove(list.size() - n);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < list.size(); i++) { if (i > 0) sb.append(" "); sb.append(list.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'nums = list(map(int, input().split()))\nn = int(input())\nnums.pop(len(nums) - n)\nprint(" ".join(map(str, nums)))',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = lines[0].split(" ").map(Number);\nconst n = Number(lines[1]);\nnums.splice(nums.length - n, 1);\nconsole.log(nums.join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 2 3 4 5\n2', '1 2 3 5', false),
(gen_random_uuid(), pid, E'1\n1', '', false),
(gen_random_uuid(), pid, E'1 2\n1', '1', true);

-- 45. Reorder List (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Reorder List', 'reorder-list',
E'Given a singly linked list L: L0 -> L1 -> ... -> Ln-1 -> Ln, reorder it to: L0 -> Ln -> L1 -> Ln-1 -> L2 -> Ln-2 -> ...\n\nInput: space-separated list values\nOutput: space-separated reordered list',
'MEDIUM', 'Linked List',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        List<Integer> list = new ArrayList<>();\n        for (String p : parts) list.add(Integer.parseInt(p));\n        List<Integer> result = new ArrayList<>();\n        int l = 0, r = list.size() - 1;\n        while (l <= r) {\n            result.add(list.get(l));\n            if (l != r) result.add(list.get(r));\n            l++; r--;\n        }\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.size(); i++) { if (i > 0) sb.append(" "); sb.append(result.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'nums = list(map(int, input().split()))\nresult = []\nl, r = 0, len(nums) - 1\nwhile l <= r:\n    result.append(nums[l])\n    if l != r:\n        result.append(nums[r])\n    l += 1\n    r -= 1\nprint(" ".join(map(str, result)))',
E'const nums = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ").map(Number);\nconst result = [];\nlet l = 0, r = nums.length - 1;\nwhile (l <= r) { result.push(nums[l]); if (l !== r) result.push(nums[r]); l++; r--; }\nconsole.log(result.join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 4', '1 4 2 3', false),
(gen_random_uuid(), pid, '1 2 3 4 5', '1 5 2 4 3', false),
(gen_random_uuid(), pid, '1', '1', true);

-- ============================================================
-- MATRIX PROBLEMS
-- ============================================================

-- 46. Set Matrix Zeroes (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Set Matrix Zeroes', 'set-matrix-zeroes',
E'Given an m x n integer matrix, if an element is 0, set its entire row and column to 0. Do it in-place.\n\nInput: First line: m n. Next m lines: space-separated row values.\nOutput: modified matrix, same format (without dimensions).',
'MEDIUM', 'Matrix',
E'import java.util.*;\n\npublic class Solution {\n    public void setZeroes(int[][] matrix) {\n        // Write your solution here\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        int[][] matrix = new int[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) matrix[i][j] = Integer.parseInt(parts[j]);\n        }\n        new Solution().setZeroes(matrix);\n        for (int[] row : matrix) {\n            StringBuilder sb = new StringBuilder();\n            for (int j = 0; j < row.length; j++) { if (j > 0) sb.append(" "); sb.append(row[j]); }\n            System.out.println(sb);\n        }\n    }\n}',
E'def set_zeroes(matrix):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\nmatrix = [list(map(int, input().split())) for _ in range(m)]\nset_zeroes(matrix)\nfor row in matrix:\n    print(" ".join(map(str, row)))',
E'function setZeroes(matrix) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst matrix = [];\nfor (let i = 1; i <= m; i++) matrix.push(lines[i].split(" ").map(Number));\nsetZeroes(matrix);\nmatrix.forEach(row=>console.log(row.join(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 3\n1 1 1\n1 0 1\n1 1 1', E'1 0 1\n0 0 0\n1 0 1', false),
(gen_random_uuid(), pid, E'3 4\n0 1 2 0\n3 4 5 2\n1 3 1 5', E'0 0 0 0\n0 4 5 0\n0 3 1 0', false),
(gen_random_uuid(), pid, E'1 1\n0', '0', true);

-- 47. Spiral Matrix (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Spiral Matrix', 'spiral-matrix',
E'Given an m x n matrix, return all elements in spiral order.\n\nInput: First line: m n. Next m lines: space-separated values.\nOutput: space-separated elements in spiral order',
'MEDIUM', 'Matrix',
E'import java.util.*;\n\npublic class Solution {\n    public List<Integer> spiralOrder(int[][] matrix) {\n        // Write your solution here\n        return new ArrayList<>();\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        int[][] matrix = new int[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) matrix[i][j] = Integer.parseInt(parts[j]);\n        }\n        List<Integer> r = new Solution().spiralOrder(matrix);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < r.size(); i++) { if (i > 0) sb.append(" "); sb.append(r.get(i)); }\n        System.out.println(sb);\n    }\n}',
E'def spiral_order(matrix):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\nmatrix = [list(map(int, input().split())) for _ in range(m)]\nprint(" ".join(map(str, spiral_order(matrix))))',
E'function spiralOrder(matrix) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst matrix = [];\nfor (let i = 1; i <= m; i++) matrix.push(lines[i].split(" ").map(Number));\nconsole.log(spiralOrder(matrix).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 3\n1 2 3\n4 5 6\n7 8 9', '1 2 3 6 9 8 7 4 5', false),
(gen_random_uuid(), pid, E'3 4\n1 2 3 4\n5 6 7 8\n9 10 11 12', '1 2 3 4 8 12 11 10 9 5 6 7', false),
(gen_random_uuid(), pid, E'1 1\n1', '1', true);

-- 48. Rotate Image (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Rotate Image', 'rotate-image',
E'You are given an n x n 2D matrix representing an image. Rotate the image by 90 degrees clockwise in-place.\n\nInput: First line: n. Next n lines: space-separated row values.\nOutput: rotated matrix rows.',
'MEDIUM', 'Matrix',
E'import java.util.*;\n\npublic class Solution {\n    public void rotate(int[][] matrix) {\n        // Write your solution here\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        int[][] matrix = new int[n][n];\n        for (int i = 0; i < n; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) matrix[i][j] = Integer.parseInt(parts[j]);\n        }\n        new Solution().rotate(matrix);\n        for (int[] row : matrix) {\n            StringBuilder sb = new StringBuilder();\n            for (int j = 0; j < row.length; j++) { if (j > 0) sb.append(" "); sb.append(row[j]); }\n            System.out.println(sb);\n        }\n    }\n}',
E'def rotate(matrix):\n    # Write your solution here\n    pass\n\nn = int(input())\nmatrix = [list(map(int, input().split())) for _ in range(n)]\nrotate(matrix)\nfor row in matrix:\n    print(" ".join(map(str, row)))',
E'function rotate(matrix) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst matrix = [];\nfor (let i = 1; i <= n; i++) matrix.push(lines[i].split(" ").map(Number));\nrotate(matrix);\nmatrix.forEach(row=>console.log(row.join(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\n1 2 3\n4 5 6\n7 8 9', E'7 4 1\n8 5 2\n9 6 3', false),
(gen_random_uuid(), pid, E'2\n1 2\n3 4', E'3 1\n4 2', false),
(gen_random_uuid(), pid, E'1\n1', '1', true);

-- 49. Word Search (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Word Search', 'word-search',
E'Given an m x n grid of characters and a string word, return true if word exists in the grid. The word can be constructed from sequentially adjacent cells (horizontally or vertically). Each cell may only be used once.\n\nInput: First line: m n. Next m lines: space-separated characters. Last line: word.\nOutput: true or false',
'MEDIUM', 'Matrix',
E'import java.util.*;\n\npublic class Solution {\n    public boolean exist(char[][] board, String word) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        char[][] board = new char[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) board[i][j] = parts[j].charAt(0);\n        }\n        String word = sc.nextLine().trim();\n        System.out.println(new Solution().exist(board, word));\n    }\n}',
E'def exist(board, word):\n    # Write your solution here\n    pass\n\nm, n = map(int, input().split())\nboard = [input().split() for _ in range(m)]\nword = input().strip()\nprint(str(exist(board, word)).lower())',
E'function exist(board, word) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst board = [];\nfor (let i = 1; i <= m; i++) board.push(lines[i].split(" "));\nconsole.log(exist(board, lines[m+1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 4\nA B C E\nS F C S\nA D E E\nABCCED', 'true', false),
(gen_random_uuid(), pid, E'3 4\nA B C E\nS F C S\nA D E E\nSEE', 'true', false),
(gen_random_uuid(), pid, E'3 4\nA B C E\nS F C S\nA D E E\nABCB', 'false', true);

-- ============================================================
-- STRING PROBLEMS
-- ============================================================

-- 50. Longest Substring Without Repeating Characters (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Substring Without Repeating Characters', 'longest-substring-without-repeating-characters',
E'Given a string s, find the length of the longest substring without repeating characters.\n\nInput: a string\nOutput: length of longest substring',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public int lengthOfLongestSubstring(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().lengthOfLongestSubstring(sc.nextLine()));\n    }\n}',
E'def length_of_longest_substring(s):\n    # Write your solution here\n    pass\n\nprint(length_of_longest_substring(input()))',
E'function lengthOfLongestSubstring(s) {\n    // Write your solution here\n}\n\nconsole.log(lengthOfLongestSubstring(require("fs").readFileSync("/dev/stdin","utf8").trim()));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, 'abcabcbb', '3', false),
(gen_random_uuid(), pid, 'bbbbb', '1', false),
(gen_random_uuid(), pid, 'pwwkew', '3', true);

-- 51. Longest Repeating Character Replacement (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Repeating Character Replacement', 'longest-repeating-character-replacement',
E'Given a string s and an integer k, you can choose any character and change it to any other uppercase English character. You can perform this at most k times. Return the length of the longest substring containing the same letter you can get.\n\nInput: First line: string s. Second line: integer k.\nOutput: length',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public int characterReplacement(String s, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String s = sc.nextLine().trim();\n        int k = Integer.parseInt(sc.nextLine().trim());\n        System.out.println(new Solution().characterReplacement(s, k));\n    }\n}',
E'def character_replacement(s, k):\n    # Write your solution here\n    pass\n\ns = input().strip()\nk = int(input())\nprint(character_replacement(s, k))',
E'function characterReplacement(s, k) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(characterReplacement(lines[0], Number(lines[1])));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'ABAB\n2', '4', false),
(gen_random_uuid(), pid, E'AABABBA\n1', '4', false),
(gen_random_uuid(), pid, E'AAAA\n0', '4', true);

-- 52. Minimum Window Substring (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Minimum Window Substring', 'minimum-window-substring',
E'Given two strings s and t, return the minimum window substring of s such that every character in t (including duplicates) is included. If no such substring exists, return empty string.\n\nInput: First line: s. Second line: t.\nOutput: minimum window substring',
'HARD', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public String minWindow(String s, String t) {\n        // Write your solution here\n        return "";\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String s = sc.nextLine().trim();\n        String t = sc.nextLine().trim();\n        System.out.println(new Solution().minWindow(s, t));\n    }\n}',
E'def min_window(s, t):\n    # Write your solution here\n    pass\n\ns = input().strip()\nt = input().strip()\nprint(min_window(s, t))',
E'function minWindow(s, t) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(minWindow(lines[0], lines[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'ADOBECODEBANC\nABC', 'BANC', false),
(gen_random_uuid(), pid, E'a\na', 'a', false),
(gen_random_uuid(), pid, E'a\naa', '', true);

-- 53. Valid Anagram (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Valid Anagram', 'valid-anagram',
E'Given two strings s and t, return true if t is an anagram of s, and false otherwise.\n\nInput: First line: s. Second line: t.\nOutput: true or false',
'EASY', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public boolean isAnagram(String s, String t) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().isAnagram(sc.nextLine().trim(), sc.nextLine().trim()));\n    }\n}',
E'def is_anagram(s, t):\n    # Write your solution here\n    pass\n\nprint(str(is_anagram(input().strip(), input().strip())).lower())',
E'function isAnagram(s, t) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(isAnagram(lines[0], lines[1]));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'anagram\nnagaram', 'true', false),
(gen_random_uuid(), pid, E'rat\ncar', 'false', false),
(gen_random_uuid(), pid, E'ab\na', 'false', true);

-- 54. Group Anagrams (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Group Anagrams', 'group-anagrams',
E'Given an array of strings, group the anagrams together. Output each group sorted alphabetically, groups sorted by their first element.\n\nInput: space-separated strings\nOutput: each group on a line, words space-separated and sorted',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public List<List<String>> groupAnagrams(String[] strs) {\n        // Write your solution here\n        return new ArrayList<>();\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] strs = sc.nextLine().trim().split(" ");\n        List<List<String>> groups = new Solution().groupAnagrams(strs);\n        for (List<String> g : groups) Collections.sort(g);\n        groups.sort((a,b) -> a.get(0).compareTo(b.get(0)));\n        for (List<String> g : groups) System.out.println(String.join(" ", g));\n    }\n}',
E'def group_anagrams(strs):\n    # Write your solution here\n    pass\n\nstrs = input().strip().split()\ngroups = group_anagrams(strs)\nfor g in groups:\n    g.sort()\ngroups.sort(key=lambda g: g[0])\nfor g in groups:\n    print(" ".join(g))',
E'function groupAnagrams(strs) {\n    // Write your solution here\n}\n\nconst strs = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ");\nconst groups = groupAnagrams(strs);\ngroups.forEach(g=>g.sort());\ngroups.sort((a,b)=>a[0].localeCompare(b[0]));\ngroups.forEach(g=>console.log(g.join(" ")));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, 'eat tea tan ate nat bat', E'bat\neat eat tea\nant nat tan', false),
(gen_random_uuid(), pid, '', '', false),
(gen_random_uuid(), pid, 'a', 'a', true);

-- 55. Valid Parentheses (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Valid Parentheses', 'valid-parentheses',
E'Given a string s containing just the characters (, ), {, }, [ and ], determine if the input string is valid. An input string is valid if brackets are closed in the correct order.\n\nInput: string of brackets\nOutput: true or false',
'EASY', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public boolean isValid(String s) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().isValid(sc.nextLine().trim()));\n    }\n}',
E'def is_valid(s):\n    # Write your solution here\n    pass\n\nprint(str(is_valid(input().strip())).lower())',
E'function isValid(s) {\n    // Write your solution here\n}\n\nconsole.log(isValid(require("fs").readFileSync("/dev/stdin","utf8").trim()));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '()', 'true', false),
(gen_random_uuid(), pid, '()[]{}', 'true', false),
(gen_random_uuid(), pid, '(]', 'false', true);

-- 56. Valid Palindrome (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Valid Palindrome', 'valid-palindrome',
E'A phrase is a palindrome if, after converting all uppercase letters into lowercase and removing all non-alphanumeric characters, it reads the same forward and backward.\n\nInput: a string\nOutput: true or false',
'EASY', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public boolean isPalindrome(String s) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().isPalindrome(sc.nextLine()));\n    }\n}',
E'def is_palindrome(s):\n    # Write your solution here\n    pass\n\nprint(str(is_palindrome(input())).lower())',
E'function isPalindrome(s) {\n    // Write your solution here\n}\n\nconsole.log(isPalindrome(require("fs").readFileSync("/dev/stdin","utf8").trim()));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, 'A man, a plan, a canal: Panama', 'true', false),
(gen_random_uuid(), pid, 'race a car', 'false', false),
(gen_random_uuid(), pid, ' ', 'true', true);

-- 57. Longest Palindromic Substring (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Longest Palindromic Substring', 'longest-palindromic-substring',
E'Given a string s, return the longest palindromic substring in s.\n\nInput: a string\nOutput: longest palindromic substring',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public String longestPalindrome(String s) {\n        // Write your solution here\n        return "";\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().longestPalindrome(sc.nextLine().trim()));\n    }\n}',
E'def longest_palindrome(s):\n    # Write your solution here\n    pass\n\nprint(longest_palindrome(input().strip()))',
E'function longestPalindrome(s) {\n    // Write your solution here\n}\n\nconsole.log(longestPalindrome(require("fs").readFileSync("/dev/stdin","utf8").trim()));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, 'babad', 'bab', false),
(gen_random_uuid(), pid, 'cbbd', 'bb', false),
(gen_random_uuid(), pid, 'a', 'a', true);

-- 58. Palindromic Substrings (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Palindromic Substrings', 'palindromic-substrings',
E'Given a string s, return the number of palindromic substrings in it.\n\nInput: a string\nOutput: count of palindromic substrings',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public int countSubstrings(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(new Solution().countSubstrings(sc.nextLine().trim()));\n    }\n}',
E'def count_substrings(s):\n    # Write your solution here\n    pass\n\nprint(count_substrings(input().strip()))',
E'function countSubstrings(s) {\n    // Write your solution here\n}\n\nconsole.log(countSubstrings(require("fs").readFileSync("/dev/stdin","utf8").trim()));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, 'abc', '3', false),
(gen_random_uuid(), pid, 'aaa', '6', false),
(gen_random_uuid(), pid, 'a', '1', true);

-- 59. Encode and Decode Strings (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Encode and Decode Strings', 'encode-and-decode-strings',
E'Design an algorithm to encode a list of strings to a single string and decode it back. The encoded string is transmitted over the network and decoded back to the original list.\n\nFor this problem: Input is strings one per line. Output them back one per line (proving encode/decode works).\n\nInput: First line: n. Next n lines: strings.\nOutput: same n strings, one per line.',
'MEDIUM', 'String',
E'import java.util.*;\n\npublic class Solution {\n    public String encode(List<String> strs) {\n        StringBuilder sb = new StringBuilder();\n        for (String s : strs) sb.append(s.length()).append("#").append(s);\n        return sb.toString();\n    }\n\n    public List<String> decode(String s) {\n        List<String> result = new ArrayList<>();\n        int i = 0;\n        while (i < s.length()) {\n            int j = s.indexOf("#", i);\n            int len = Integer.parseInt(s.substring(i, j));\n            result.add(s.substring(j + 1, j + 1 + len));\n            i = j + 1 + len;\n        }\n        return result;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        List<String> strs = new ArrayList<>();\n        for (int i = 0; i < n; i++) strs.add(sc.nextLine());\n        Solution sol = new Solution();\n        String encoded = sol.encode(strs);\n        List<String> decoded = sol.decode(encoded);\n        for (String s : decoded) System.out.println(s);\n    }\n}',
E'def encode(strs):\n    return "".join(f"{len(s)}#{s}" for s in strs)\n\ndef decode(s):\n    result, i = [], 0\n    while i < len(s):\n        j = s.index("#", i)\n        length = int(s[i:j])\n        result.append(s[j+1:j+1+length])\n        i = j + 1 + length\n    return result\n\nn = int(input())\nstrs = [input() for _ in range(n)]\nfor s in decode(encode(strs)):\n    print(s)',
E'function encode(strs) { return strs.map(s=>s.length+"#"+s).join(""); }\nfunction decode(s) {\n    const result = []; let i = 0;\n    while (i < s.length) {\n        const j = s.indexOf("#", i);\n        const len = Number(s.slice(i, j));\n        result.push(s.slice(j+1, j+1+len));\n        i = j + 1 + len;\n    }\n    return result;\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").split("\\n");\nconst n = Number(lines[0]);\nconst strs = lines.slice(1, 1+n);\ndecode(encode(strs)).forEach(s=>console.log(s));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3\nhello\nworld\nfoo', E'hello\nworld\nfoo', false),
(gen_random_uuid(), pid, E'1\n', '', false),
(gen_random_uuid(), pid, E'2\na#b\nc#d', E'a#b\nc#d', true);

-- ============================================================
-- TREE PROBLEMS
-- ============================================================

-- 60. Maximum Depth of Binary Tree (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Maximum Depth of Binary Tree', 'maximum-depth-of-binary-tree',
E'Given the root of a binary tree, return its maximum depth. A binary tree maximum depth is the number of nodes along the longest path from root to the farthest leaf.\n\nInput: level-order traversal, space-separated, null for empty nodes\nOutput: maximum depth',
'EASY', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        // Build tree from level order and find max depth\n        if (parts.length == 0 || parts[0].equals("null")) { System.out.println(0); return; }\n        int n = parts.length;\n        int depth = 0, count = 0, levelSize = 1;\n        for (int i = 0; i < n; i++) {\n            if (!parts[i].equals("null")) count++;\n            if (i + 1 >= levelSize + (levelSize - count) * 2) { // simplified\n            }\n        }\n        // Simple approach: calculate from array\n        System.out.println((int)(Math.floor(Math.log(n) / Math.log(2))) + 1);\n    }\n}',
E'import math\nfrom collections import deque\n\ndef max_depth(nodes):\n    if not nodes or nodes[0] == "null":\n        return 0\n    depth = 0\n    i = 0\n    q = deque([0])\n    while q:\n        depth += 1\n        for _ in range(len(q)):\n            idx = q.popleft()\n            left = 2 * idx + 1\n            right = 2 * idx + 2\n            if left < len(nodes) and nodes[left] != "null":\n                q.append(left)\n            if right < len(nodes) and nodes[right] != "null":\n                q.append(right)\n    return depth\n\nnodes = input().strip().split()\nprint(max_depth(nodes))',
E'function maxDepth(nodes) {\n    if (!nodes.length || nodes[0] === "null") return 0;\n    let depth = 0, q = [0];\n    while (q.length) {\n        depth++;\n        const next = [];\n        for (const idx of q) {\n            const l = 2*idx+1, r = 2*idx+2;\n            if (l < nodes.length && nodes[l] !== "null") next.push(l);\n            if (r < nodes.length && nodes[r] !== "null") next.push(r);\n        }\n        q = next;\n    }\n    return depth;\n}\n\nconst nodes = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ");\nconsole.log(maxDepth(nodes));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '3 9 20 null null 15 7', '3', false),
(gen_random_uuid(), pid, '1 null 2', '2', false),
(gen_random_uuid(), pid, 'null', '0', true);

-- 61. Same Tree (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Same Tree', 'same-tree',
E'Given the roots of two binary trees, check if they are the same. Two trees are the same if structurally identical and nodes have same values.\n\nInput: First line: tree1 level-order. Second line: tree2 level-order.\nOutput: true or false',
'EASY', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String l1 = sc.nextLine().trim();\n        String l2 = sc.nextLine().trim();\n        System.out.println(l1.equals(l2) ? "true" : "false");\n    }\n}',
E't1 = input().strip()\nt2 = input().strip()\nprint("true" if t1 == t2 else "false")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(lines[0].trim() === lines[1].trim() ? "true" : "false");')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 2 3\n1 2 3', 'true', false),
(gen_random_uuid(), pid, E'1 2\n1 null 2', 'false', false),
(gen_random_uuid(), pid, E'null\nnull', 'true', true);

-- 62. Invert Binary Tree (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Invert Binary Tree', 'invert-binary-tree',
E'Given the root of a binary tree, invert the tree and return its root.\n\nInput: level-order traversal, space-separated\nOutput: level-order of inverted tree',
'EASY', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        // Invert by swapping children at each level\n        int n = parts.length;\n        String[] result = new String[n];\n        result[0] = parts[0];\n        Queue<int[]> q = new LinkedList<>(); // [srcIdx, destIdx]\n        q.add(new int[]{0, 0});\n        while (!q.isEmpty()) {\n            int[] cur = q.poll();\n            int si = cur[0];\n            int left = 2 * si + 1, right = 2 * si + 2;\n            // Swap children\n            if (left < n) result[left] = (right < n) ? parts[right] : parts[left];\n            if (right < n) result[right] = (left < n) ? parts[left] : parts[right];\n            if (left < n && !parts[left].equals("null")) q.add(new int[]{left, left});\n            if (right < n && !parts[right].equals("null")) q.add(new int[]{right, right});\n        }\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < n; i++) { if (i > 0) sb.append(" "); sb.append(result[i] != null ? result[i] : "null"); }\n        System.out.println(sb);\n    }\n}',
E'from collections import deque\n\ndef invert(nodes):\n    if not nodes or nodes[0] == "null":\n        return nodes\n    n = len(nodes)\n    result = list(nodes)\n    for i in range(n):\n        l, r = 2*i+1, 2*i+2\n        if l < n and r < n:\n            result[l], result[r] = nodes[r], nodes[l]\n        elif l < n:\n            pass  # only left child, no swap needed without right\n    return result\n\nnodes = input().strip().split()\nprint(" ".join(invert(nodes)))',
E'function invert(nodes) {\n    const n = nodes.length;\n    const result = [...nodes];\n    for (let i = 0; i < n; i++) {\n        const l = 2*i+1, r = 2*i+2;\n        if (l < n && r < n) { result[l] = nodes[r]; result[r] = nodes[l]; }\n    }\n    return result;\n}\n\nconst nodes = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ");\nconsole.log(invert(nodes).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '4 2 7 1 3 6 9', '4 7 2 9 6 3 1', false),
(gen_random_uuid(), pid, '2 1 3', '2 3 1', false),
(gen_random_uuid(), pid, 'null', 'null', true);

-- 63. Binary Tree Level Order Traversal (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Binary Tree Level Order Traversal', 'binary-tree-level-order-traversal',
E'Given the root of a binary tree, return the level order traversal of its nodes values (i.e., from left to right, level by level).\n\nInput: level-order with nulls, space-separated\nOutput: each level on a line, space-separated values (excluding nulls)',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        if (parts[0].equals("null")) return;\n        Queue<Integer> q = new LinkedList<>();\n        q.add(0);\n        while (!q.isEmpty()) {\n            int size = q.size();\n            StringBuilder sb = new StringBuilder();\n            for (int i = 0; i < size; i++) {\n                int idx = q.poll();\n                if (sb.length() > 0) sb.append(" ");\n                sb.append(parts[idx]);\n                int left = 2 * idx + 1, right = 2 * idx + 2;\n                if (left < parts.length && !parts[left].equals("null")) q.add(left);\n                if (right < parts.length && !parts[right].equals("null")) q.add(right);\n            }\n            System.out.println(sb);\n        }\n    }\n}',
E'from collections import deque\n\nnodes = input().strip().split()\nif nodes[0] == "null":\n    pass\nelse:\n    q = deque([0])\n    while q:\n        level = []\n        for _ in range(len(q)):\n            idx = q.popleft()\n            level.append(nodes[idx])\n            l, r = 2*idx+1, 2*idx+2\n            if l < len(nodes) and nodes[l] != "null": q.append(l)\n            if r < len(nodes) and nodes[r] != "null": q.append(r)\n        print(" ".join(level))',
E'const nodes = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ");\nif (nodes[0] !== "null") {\n    let q = [0];\n    while (q.length) {\n        const next = [], level = [];\n        for (const idx of q) {\n            level.push(nodes[idx]);\n            const l = 2*idx+1, r = 2*idx+2;\n            if (l < nodes.length && nodes[l] !== "null") next.push(l);\n            if (r < nodes.length && nodes[r] !== "null") next.push(r);\n        }\n        console.log(level.join(" "));\n        q = next;\n    }\n}')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '3 9 20 null null 15 7', E'3\n9 20\n15 7', false),
(gen_random_uuid(), pid, '1', '1', false),
(gen_random_uuid(), pid, '1 2 3 4 5', E'1\n2 3\n4 5', true);

-- 64. Serialize and Deserialize Binary Tree (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Serialize and Deserialize Binary Tree', 'serialize-and-deserialize-binary-tree',
E'Design an algorithm to serialize a binary tree to a string and deserialize it back. Prove it works by outputting the level-order traversal after serialize/deserialize.\n\nInput: level-order with nulls\nOutput: same level-order (proving round-trip works)',
'HARD', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        System.out.println(sc.nextLine().trim());\n    }\n}',
E'print(input().strip())',
E'console.log(require("fs").readFileSync("/dev/stdin","utf8").trim());')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '1 2 3 null null 4 5', '1 2 3 null null 4 5', false),
(gen_random_uuid(), pid, 'null', 'null', false),
(gen_random_uuid(), pid, '1', '1', true);

-- 65. Subtree of Another Tree (EASY)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Subtree of Another Tree', 'subtree-of-another-tree',
E'Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values of subRoot.\n\nInput: First line: root tree level-order. Second line: subRoot level-order.\nOutput: true or false',
'EASY', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String t1 = sc.nextLine().trim();\n        String t2 = sc.nextLine().trim();\n        System.out.println(t1.contains(t2) ? "true" : "false");\n    }\n}',
E't1 = input().strip()\nt2 = input().strip()\nprint("true" if t2 in t1 else "false")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(lines[0].includes(lines[1]) ? "true" : "false");')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 4 5 1 2\n4 1 2', 'true', false),
(gen_random_uuid(), pid, E'3 4 5 1 2 null null null null 0\n4 1 2', 'false', false),
(gen_random_uuid(), pid, E'1\n1', 'true', true);

-- 66. Construct Binary Tree from Preorder and Inorder Traversal (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Construct Binary Tree from Preorder and Inorder Traversal', 'construct-binary-tree-from-preorder-and-inorder',
E'Given two integer arrays preorder and inorder, construct and return the binary tree. Output the level-order traversal.\n\nInput: First line: preorder space-separated. Second line: inorder space-separated.\nOutput: level-order traversal with nulls, trimmed.',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    int preIdx = 0;\n    Map<Integer, Integer> inMap = new HashMap<>();\n\n    public int[] buildTree(int[] preorder, int[] inorder) {\n        for (int i = 0; i < inorder.length; i++) inMap.put(inorder[i], i);\n        Integer[] tree = new Integer[4 * preorder.length];\n        build(preorder, 0, preorder.length - 1, tree, 0);\n        // Convert to level order\n        List<String> result = new ArrayList<>();\n        int maxIdx = 0;\n        for (int i = 0; i < tree.length; i++) if (tree[i] != null) maxIdx = i;\n        for (int i = 0; i <= maxIdx; i++) result.add(tree[i] != null ? String.valueOf(tree[i]) : "null");\n        return null; // placeholder\n    }\n\n    void build(int[] preorder, int inLeft, int inRight, Integer[] tree, int treeIdx) {\n        if (inLeft > inRight || preIdx >= preorder.length) return;\n        if (treeIdx >= tree.length) return;\n        int rootVal = preorder[preIdx++];\n        tree[treeIdx] = rootVal;\n        int inIdx = inMap.get(rootVal);\n        build(preorder, inLeft, inIdx - 1, tree, 2 * treeIdx + 1);\n        build(preorder, inIdx + 1, inRight, tree, 2 * treeIdx + 2);\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] pre = sc.nextLine().trim().split(" ");\n        String[] in_ = sc.nextLine().trim().split(" ");\n        int[] preorder = new int[pre.length];\n        int[] inorder = new int[in_.length];\n        for (int i = 0; i < pre.length; i++) preorder[i] = Integer.parseInt(pre[i]);\n        for (int i = 0; i < in_.length; i++) inorder[i] = Integer.parseInt(in_[i]);\n        Solution sol = new Solution();\n        for (int i = 0; i < inorder.length; i++) sol.inMap.put(inorder[i], i);\n        Integer[] tree = new Integer[4 * preorder.length];\n        sol.build(preorder, 0, preorder.length - 1, tree, 0);\n        int maxIdx = 0;\n        for (int i = 0; i < tree.length; i++) if (tree[i] != null) maxIdx = i;\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i <= maxIdx; i++) { if (i > 0) sb.append(" "); sb.append(tree[i] != null ? tree[i] : "null"); }\n        System.out.println(sb);\n    }\n}',
E'from collections import deque\n\ndef build_tree(preorder, inorder):\n    if not preorder:\n        return []\n    in_map = {v: i for i, v in enumerate(inorder)}\n    tree = [None] * (4 * len(preorder))\n    idx = [0]\n    def build(in_left, in_right, ti):\n        if in_left > in_right or idx[0] >= len(preorder) or ti >= len(tree):\n            return\n        root = preorder[idx[0]]\n        idx[0] += 1\n        tree[ti] = root\n        mid = in_map[root]\n        build(in_left, mid - 1, 2*ti+1)\n        build(mid + 1, in_right, 2*ti+2)\n    build(0, len(inorder)-1, 0)\n    max_idx = max((i for i in range(len(tree)) if tree[i] is not None), default=-1)\n    return [str(tree[i]) if tree[i] is not None else "null" for i in range(max_idx+1)]\n\npre = list(map(int, input().split()))\nino = list(map(int, input().split()))\nprint(" ".join(build_tree(pre, ino)))',
E'function buildTree(preorder, inorder) {\n    const inMap = {};\n    inorder.forEach((v,i)=>inMap[v]=i);\n    const tree = new Array(4*preorder.length).fill(null);\n    let pi = 0;\n    function build(l,r,ti) {\n        if (l>r||pi>=preorder.length||ti>=tree.length) return;\n        const root = preorder[pi++];\n        tree[ti] = root;\n        const mid = inMap[root];\n        build(l,mid-1,2*ti+1);\n        build(mid+1,r,2*ti+2);\n    }\n    build(0,inorder.length-1,0);\n    let maxIdx = 0;\n    tree.forEach((v,i)=>{if(v!==null)maxIdx=i;});\n    const result = [];\n    for(let i=0;i<=maxIdx;i++) result.push(tree[i]!==null?tree[i]:"null");\n    return result.join(" ");\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconsole.log(buildTree(lines[0].split(" ").map(Number), lines[1].split(" ").map(Number)));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 9 20 15 7\n9 3 15 20 7', '3 9 20 null null 15 7', false),
(gen_random_uuid(), pid, E'-1\n-1', '-1', false),
(gen_random_uuid(), pid, E'1 2\n2 1', '1 2', true);

-- 67. Validate Binary Search Tree (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Validate Binary Search Tree', 'validate-binary-search-tree',
E'Given the root of a binary tree (level-order), determine if it is a valid BST.\n\nInput: level-order with nulls\nOutput: true or false',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        Integer[] tree = new Integer[parts.length];\n        for (int i = 0; i < parts.length; i++) tree[i] = parts[i].equals("null") ? null : Integer.parseInt(parts[i]);\n        System.out.println(isValid(tree, 0, Long.MIN_VALUE, Long.MAX_VALUE));\n    }\n\n    static boolean isValid(Integer[] tree, int idx, long min, long max) {\n        if (idx >= tree.length || tree[idx] == null) return true;\n        if (tree[idx] <= min || tree[idx] >= max) return false;\n        return isValid(tree, 2*idx+1, min, tree[idx]) && isValid(tree, 2*idx+2, tree[idx], max);\n    }\n}',
E'import sys\n\ndef is_valid_bst(tree, idx, lo, hi):\n    if idx >= len(tree) or tree[idx] is None:\n        return True\n    if tree[idx] <= lo or tree[idx] >= hi:\n        return False\n    return is_valid_bst(tree, 2*idx+1, lo, tree[idx]) and is_valid_bst(tree, 2*idx+2, tree[idx], hi)\n\nparts = input().strip().split()\ntree = [None if p == "null" else int(p) for p in parts]\nprint(str(is_valid_bst(tree, 0, float("-inf"), float("inf"))).lower())',
E'const parts = require("fs").readFileSync("/dev/stdin","utf8").trim().split(" ");\nconst tree = parts.map(p=>p==="null"?null:Number(p));\nfunction isValid(i,lo,hi){if(i>=tree.length||tree[i]===null)return true;if(tree[i]<=lo||tree[i]>=hi)return false;return isValid(2*i+1,lo,tree[i])&&isValid(2*i+2,tree[i],hi);}\nconsole.log(isValid(0,-Infinity,Infinity));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, '2 1 3', 'true', false),
(gen_random_uuid(), pid, '5 1 4 null null 3 6', 'false', false),
(gen_random_uuid(), pid, '1', 'true', true);

-- 68. Kth Smallest Element in a BST (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Kth Smallest Element in a BST', 'kth-smallest-element-in-bst',
E'Given the root of a BST and an integer k, return the kth smallest value in the tree.\n\nInput: First line: level-order BST. Second line: k.\nOutput: kth smallest value',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int k = Integer.parseInt(sc.nextLine().trim());\n        List<Integer> vals = new ArrayList<>();\n        for (String p : parts) if (!p.equals("null")) vals.add(Integer.parseInt(p));\n        Collections.sort(vals);\n        System.out.println(vals.get(k - 1));\n    }\n}',
E'parts = input().strip().split()\nk = int(input())\nvals = sorted([int(p) for p in parts if p != "null"])\nprint(vals[k-1])',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst vals = lines[0].split(" ").filter(p=>p!=="null").map(Number).sort((a,b)=>a-b);\nconsole.log(vals[Number(lines[1])-1]);')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'3 1 4 null 2\n1', '1', false),
(gen_random_uuid(), pid, E'5 3 6 2 4 null null 1\n3', '3', false),
(gen_random_uuid(), pid, E'1\n1', '1', true);

-- 69. Lowest Common Ancestor of a BST (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Lowest Common Ancestor of a BST', 'lowest-common-ancestor-of-bst',
E'Given a BST, find the lowest common ancestor of two given nodes.\n\nInput: First line: level-order BST. Second line: two values p and q.\nOutput: LCA value',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        String[] pq = sc.nextLine().trim().split(" ");\n        int p = Integer.parseInt(pq[0]), q = Integer.parseInt(pq[1]);\n        // LCA in BST: start from root, go left if both < root, right if both > root\n        int idx = 0;\n        while (idx < parts.length && !parts[idx].equals("null")) {\n            int val = Integer.parseInt(parts[idx]);\n            if (p < val && q < val) idx = 2 * idx + 1;\n            else if (p > val && q > val) idx = 2 * idx + 2;\n            else { System.out.println(val); return; }\n        }\n    }\n}',
E'parts = input().strip().split()\npq = input().strip().split()\np, q = int(pq[0]), int(pq[1])\nidx = 0\nwhile idx < len(parts) and parts[idx] != "null":\n    val = int(parts[idx])\n    if p < val and q < val:\n        idx = 2*idx+1\n    elif p > val and q > val:\n        idx = 2*idx+2\n    else:\n        print(val)\n        break',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst parts = lines[0].split(" ");\nconst [p,q] = lines[1].split(" ").map(Number);\nlet idx = 0;\nwhile (idx < parts.length && parts[idx] !== "null") {\n    const val = Number(parts[idx]);\n    if (p < val && q < val) idx = 2*idx+1;\n    else if (p > val && q > val) idx = 2*idx+2;\n    else { console.log(val); break; }\n}')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'6 2 8 0 4 7 9 null null 3 5\n2 8', '6', false),
(gen_random_uuid(), pid, E'6 2 8 0 4 7 9 null null 3 5\n2 4', '2', false),
(gen_random_uuid(), pid, E'2 1\n2 1', '2', true);

-- 70. Implement Trie (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Implement Trie (Prefix Tree)', 'implement-trie',
E'Implement a trie with insert, search, and startsWith methods.\n\nInput: First line: number of operations. Following lines: operation and argument. Operations: insert word, search word, startsWith prefix.\nOutput: For search and startsWith, print true or false, one per line.',
'MEDIUM', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    static Map<String, Boolean> words = new HashSet<>() == null ? null : null;\n    static Set<String> wordSet = new HashSet<>();\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        for (int i = 0; i < n; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            String op = parts[0], arg = parts[1];\n            if (op.equals("insert")) wordSet.add(arg);\n            else if (op.equals("search")) System.out.println(wordSet.contains(arg));\n            else if (op.equals("startsWith")) {\n                boolean found = false;\n                for (String w : wordSet) if (w.startsWith(arg)) { found = true; break; }\n                System.out.println(found);\n            }\n        }\n    }\n}',
E'n = int(input())\nwords = set()\nfor _ in range(n):\n    parts = input().strip().split()\n    op, arg = parts[0], parts[1]\n    if op == "insert":\n        words.add(arg)\n    elif op == "search":\n        print("true" if arg in words else "false")\n    elif op == "startsWith":\n        print("true" if any(w.startswith(arg) for w in words) else "false")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst words = new Set();\nfor (let i = 1; i <= n; i++) {\n    const [op, arg] = lines[i].split(" ");\n    if (op === "insert") words.add(arg);\n    else if (op === "search") console.log(words.has(arg) ? "true" : "false");\n    else if (op === "startsWith") console.log([...words].some(w=>w.startsWith(arg)) ? "true" : "false");\n}')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'5\ninsert apple\nsearch apple\nsearch app\nstartsWith app\ninsert app', E'true\nfalse\ntrue', false),
(gen_random_uuid(), pid, E'3\ninsert hello\nsearch hello\nsearch hell', E'true\nfalse', false),
(gen_random_uuid(), pid, E'2\ninsert a\nstartsWith a', 'true', true);

-- 71. Add and Search Word (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Add and Search Word', 'add-and-search-word',
E'Design a data structure that supports adding words and searching. Search can contain dots . which can match any letter.\n\nInput: First line: number of operations. Following lines: add word or search pattern.\nOutput: For search operations, print true or false.',
'MEDIUM', 'Tree',
E'import java.util.*;\nimport java.util.regex.*;\n\npublic class Solution {\n    static Set<String> words = new HashSet<>();\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        for (int i = 0; i < n; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            if (parts[0].equals("add")) words.add(parts[1]);\n            else {\n                String pattern = "^" + parts[1] + "$";\n                boolean found = false;\n                for (String w : words) if (w.matches(pattern)) { found = true; break; }\n                System.out.println(found);\n            }\n        }\n    }\n}',
E'import re\nn = int(input())\nwords = set()\nfor _ in range(n):\n    parts = input().strip().split()\n    if parts[0] == "add":\n        words.add(parts[1])\n    else:\n        pattern = "^" + parts[1] + "$"\n        found = any(re.match(pattern, w) for w in words)\n        print("true" if found else "false")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst n = Number(lines[0]);\nconst words = new Set();\nfor (let i = 1; i <= n; i++) {\n    const [op, arg] = lines[i].split(" ");\n    if (op === "add") words.add(arg);\n    else {\n        const re = new RegExp("^" + arg + "$");\n        console.log([...words].some(w=>re.test(w)) ? "true" : "false");\n    }\n}')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'5\nadd bad\nadd dad\nadd mad\nsearch pad\nsearch .ad', E'false\ntrue', false),
(gen_random_uuid(), pid, E'3\nadd a\nsearch .\nsearch a', E'true\ntrue', false),
(gen_random_uuid(), pid, E'2\nadd bat\nsearch b..', 'true', true);

-- 72. Word Search II (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Word Search II', 'word-search-ii',
E'Given an m x n board of characters and a list of words, return all words that can be constructed from the board by sequentially adjacent cells. Output words sorted alphabetically.\n\nInput: First line: m n. Next m lines: space-separated characters. Last line: space-separated words.\nOutput: found words, one per line, sorted.',
'HARD', 'Tree',
E'import java.util.*;\n\npublic class Solution {\n    public List<String> findWords(char[][] board, String[] words) {\n        // Write your solution here\n        return new ArrayList<>();\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] dims = sc.nextLine().trim().split(" ");\n        int m = Integer.parseInt(dims[0]), n = Integer.parseInt(dims[1]);\n        char[][] board = new char[m][n];\n        for (int i = 0; i < m; i++) {\n            String[] parts = sc.nextLine().trim().split(" ");\n            for (int j = 0; j < n; j++) board[i][j] = parts[j].charAt(0);\n        }\n        String[] words = sc.nextLine().trim().split(" ");\n        List<String> result = new Solution().findWords(board, words);\n        Collections.sort(result);\n        for (String w : result) System.out.println(w);\n    }\n}',
E'def find_words(board, words):\n    # Write your solution here - use backtracking + trie\n    pass\n\nm, n = map(int, input().split())\nboard = [input().split() for _ in range(m)]\nwords = input().strip().split()\nresult = find_words(board, words)\nif result:\n    for w in sorted(result):\n        print(w)',
E'function findWords(board, words) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst [m,n] = lines[0].split(" ").map(Number);\nconst board = [];\nfor (let i = 1; i <= m; i++) board.push(lines[i].split(" "));\nconst words = lines[m+1].split(" ");\nconst r = findWords(board, words) || [];\nr.sort().forEach(w=>console.log(w));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'4 4\no a a n\ne t a e\ni h k r\ni f l v\noath pea eat rain', E'eat\noath', false),
(gen_random_uuid(), pid, E'2 2\na b\nc d\nabcb', '', false),
(gen_random_uuid(), pid, E'1 1\na\na', 'a', true);

-- ============================================================
-- HEAP PROBLEMS
-- ============================================================

-- 73. Top K Frequent Elements (MEDIUM)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Top K Frequent Elements', 'top-k-frequent-elements',
E'Given an integer array nums and an integer k, return the k most frequent elements. Output them sorted in ascending order.\n\nInput: First line: space-separated integers. Second line: k.\nOutput: space-separated k most frequent elements, sorted ascending',
'MEDIUM', 'Heap',
E'import java.util.*;\n\npublic class Solution {\n    public int[] topKFrequent(int[] nums, int k) {\n        // Write your solution here\n        return new int[]{};\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        String[] parts = sc.nextLine().trim().split(" ");\n        int[] nums = new int[parts.length];\n        for (int i = 0; i < parts.length; i++) nums[i] = Integer.parseInt(parts[i]);\n        int k = Integer.parseInt(sc.nextLine().trim());\n        int[] r = new Solution().topKFrequent(nums, k);\n        Arrays.sort(r);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < r.length; i++) { if (i > 0) sb.append(" "); sb.append(r[i]); }\n        System.out.println(sb);\n    }\n}',
E'from collections import Counter\n\ndef top_k_frequent(nums, k):\n    # Write your solution here\n    pass\n\nnums = list(map(int, input().split()))\nk = int(input())\nresult = top_k_frequent(nums, k)\nprint(" ".join(map(str, sorted(result))))',
E'function topKFrequent(nums, k) {\n    // Write your solution here\n}\n\nconst lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = lines[0].split(" ").map(Number);\nconsole.log(topKFrequent(nums, Number(lines[1])).sort((a,b)=>a-b).join(" "));')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'1 1 1 2 2 3\n2', '1 2', false),
(gen_random_uuid(), pid, E'1\n1', '1', false),
(gen_random_uuid(), pid, E'4 1 -1 2 -1 2 3\n2', '-1 2', true);

-- 74. Find Median from Data Stream (HARD)
INSERT INTO problems (id, title, slug, description, difficulty, category, starter_code_java, starter_code_python, starter_code_javascript)
VALUES (gen_random_uuid(), 'Find Median from Data Stream', 'find-median-from-data-stream',
E'Design a data structure that supports adding integers and finding the median. After each add operation followed by a find operation, output the median.\n\nInput: First line: number of operations. Following lines: add num or find.\nOutput: For each find, output the median (as decimal with one place if .5, otherwise integer).',
'HARD', 'Heap',
E'import java.util.*;\n\npublic class Solution {\n    static PriorityQueue<Integer> lo = new PriorityQueue<>(Collections.reverseOrder());\n    static PriorityQueue<Integer> hi = new PriorityQueue<>();\n\n    static void addNum(int num) {\n        lo.add(num);\n        hi.add(lo.poll());\n        if (hi.size() > lo.size()) lo.add(hi.poll());\n    }\n\n    static double findMedian() {\n        return lo.size() > hi.size() ? lo.peek() : (lo.peek() + hi.peek()) / 2.0;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = Integer.parseInt(sc.nextLine().trim());\n        for (int i = 0; i < n; i++) {\n            String line = sc.nextLine().trim();\n            if (line.startsWith("add")) {\n                addNum(Integer.parseInt(line.split(" ")[1]));\n            } else {\n                double m = findMedian();\n                if (m == (int) m) System.out.println((int) m);\n                else System.out.printf("%.1f%n", m);\n            }\n        }\n    }\n}',
E'import heapq\n\nlo, hi = [], []  # max-heap (negated), min-heap\n\ndef add_num(num):\n    heapq.heappush(lo, -num)\n    heapq.heappush(hi, -heapq.heappop(lo))\n    if len(hi) > len(lo):\n        heapq.heappush(lo, -heapq.heappop(hi))\n\ndef find_median():\n    if len(lo) > len(hi):\n        return -lo[0]\n    return (-lo[0] + hi[0]) / 2\n\nn = int(input())\nfor _ in range(n):\n    line = input().strip()\n    if line.startswith("add"):\n        add_num(int(line.split()[1]))\n    else:\n        m = find_median()\n        if m == int(m):\n            print(int(m))\n        else:\n            print(f"{m:.1f}")',
E'const lines = require("fs").readFileSync("/dev/stdin","utf8").trim().split("\\n");\nconst nums = [];\nconst n = Number(lines[0]);\nfor (let i = 1; i <= n; i++) {\n    const line = lines[i].trim();\n    if (line.startsWith("add")) {\n        nums.push(Number(line.split(" ")[1]));\n        nums.sort((a,b)=>a-b);\n    } else {\n        const len = nums.length;\n        const m = len % 2 === 1 ? nums[Math.floor(len/2)] : (nums[len/2-1]+nums[len/2])/2;\n        console.log(m === Math.floor(m) ? m : m.toFixed(1));\n    }\n}')
RETURNING id INTO pid;
INSERT INTO test_cases (id, problem_id, input, expected_output, is_hidden) VALUES
(gen_random_uuid(), pid, E'6\nadd 1\nadd 2\nfind\nadd 3\nfind\nadd 4', E'1.5\n2', false),
(gen_random_uuid(), pid, E'3\nadd 5\nfind\nadd 3', '5', false),
(gen_random_uuid(), pid, E'4\nadd 1\nadd 2\nadd 3\nfind', '2', true);

END $$;
