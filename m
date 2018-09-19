From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Wed, 19 Sep 2018 13:29:27 +0300
Subject: [PATCH] of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config
 option
Message-ID: <20180919102927.4yYBpfor-mqEk-1ItME1Q7TfaqlArGZqs7gSR7XVjbQ@z>

The removal of HAVE_MEMBLOCK configuration option, mistakenly dropped the
wrong #endif. This patch restores that #endif and removes the part that
should have been actually removed, starting from #else and up to the
correct #endif

Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 48314e9..bb532aa 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1119,6 +1119,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 #endif
 #ifndef MAX_MEMBLOCK_ADDR
 #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
+#endif
 
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
@@ -1175,26 +1176,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 	return memblock_reserve(base, size);
 }
 
-#else
-void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	WARN_ON(1);
-}
-
-int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
-{
-	return -ENOSYS;
-}
-
-int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
-					phys_addr_t size, bool nomap)
-{
-	pr_err("Reserved memory not supported, ignoring range %pa - %pa%s\n",
-		  &base, &size, nomap ? " (nomap)" : "");
-	return -ENOSYS;
-}
-#endif
-
 static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 {
 	return memblock_alloc(size, align);
-- 
2.7.4

 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 76c83c1..bd841bb 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1115,13 +1115,11 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  	return 1;
> >  }
> >  
> > -#ifdef CONFIG_HAVE_MEMBLOCK
> >  #ifndef MIN_MEMBLOCK_ADDR
> >  #define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
> >  #endif
> >  #ifndef MAX_MEMBLOCK_ADDR
> >  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> > -#endif
> 
> This isn't the right #endif. It is matching with the #ifndef MAX_MEMBLOCK_ADDR
> not the intented #ifdef CONFIG_HAVE_MEMBLOCK.
> 
> Now I haven't chased through the exact reason this is causing my acpi
> arm64 system not to boot on the basis it is obviously miss-matched anyway
> and I'm inherently lazy.  It's resulting in stubs replacing the following weak
> functions.
> 
> early_init_dt_add_memory_arch
> (this is defined elsewhere for some architectures but not arm)
> 
> early_init_dt_mark_hotplug_memory_arch
> (there is only one definition of this in the kernel so it doesn't
>  need to be weak or in the header etc).
> 
> early_init_dt_reserve_memory_arch
> (defined on mips but nothing else)
> 
> Taking out the right endif also lets you drop an #else removing some stub
> functions further down in here.
> 
> Nice cleanup in general btw.
> 
> Thanks,
> 
> Jonathan
> >  
> >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> >  {
> 

-- 
Sincerely yours,
Mike.
