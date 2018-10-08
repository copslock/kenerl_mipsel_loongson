From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 8 Oct 2018 11:22:10 +0300
Subject: [PATCH] memblock: warn if zero alignment was requested
Message-ID: <20181008082210.xxrOukjQ5icUGQYPPLuRCCEgPymupW4YXwM4Bm6Ylag@z>

After update of all memblock users to explicitly specify SMP_CACHE_BYTES
alignment rather than use 0, it is still possible that uncovered users
may sneak in. Add a WARN_ON_ONCE for such cases.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/memblock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0bbae56..5fefc70 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1298,6 +1298,9 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 {
 	phys_addr_t found;
 
+	if (WARN_ON_ONCE(!align))
+		align = SMP_CACHE_BYTES;
+
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
 	if (found && !memblock_reserve(found, size)) {
@@ -1420,6 +1423,9 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
 
+	if (WARN_ON_ONCE(!align))
+		align = SMP_CACHE_BYTES;
+
 	if (max_addr > memblock.current_limit)
 		max_addr = memblock.current_limit;
 again:
-- 
2.7.4


-- 
Sincerely yours,
Mike.
