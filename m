Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DEJS909340
	for linux-mips-outgoing; Mon, 13 Aug 2001 07:19:28 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DEJNj09334
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 07:19:23 -0700
Received: (qmail 23285 invoked from network); 13 Aug 2001 14:19:18 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 13 Aug 2001 14:19:18 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] modutils 2.4.6: Make __dbe_table available to modules 
In-reply-to: Your message of "Mon, 13 Aug 2001 15:43:56 +0200."
             <Pine.GSO.3.96.1010813153841.18279H-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Aug 2001 00:19:17 +1000
Message-ID: <15497.997712357@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001 15:43:56 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> The following patch is needed for modutils to initialize __dbe_table
>table pointers appropriately for modules that want to handle bus error
>exceptions on MIPS.  A separate patch is needed for the kernel.
>
>modutils-2.4.6-mips-dbe.patch
>diff -up --recursive --new-file modutils-2.4.6.macro/include/module.h modutils-2.4.6/include/module.h
>--- modutils-2.4.6.macro/include/module.h	Fri Jan  5 01:45:19 2001
>+++ modutils-2.4.6/include/module.h	Sun Aug 12 13:16:13 2001
>@@ -153,6 +153,10 @@ struct module
>   unsigned tgt_long cleanup;
>   unsigned tgt_long ex_table_start;
>   unsigned tgt_long ex_table_end;
>+#ifdef __mips__
>+  unsigned tgt_long dbe_table_start;
>+  unsigned tgt_long dbe_table_end;
>+#endif
> #ifdef __alpha__
>   unsigned tgt_long gp;
> #endif

Checking dbe table is fine but where you placed the table in struct
modules is wrong.  You must not insert fields in the middle of struct
module, it introduces version skew between kernel and user space.  At
the very least you have moved the can_unload which will break IPv6 plus
a few other modules.

I understand why you placed it before gp, it looks like the place for
arch dependent code.  The alpha specific data is a hangover that should
never have been there.  modutils 2.3.16 added the archdata_start and
archdata_end fields specifically so each architecture did not have to
keep adding fields and causing size mismatch between kernel and
modutils.  IA64 uses those fields for its unwind data, MIPS can use
archdata for whatever it needs in a module.

In modutils, there is an arch_archdata routine for each architecture.
Most just return but obj/obj_ia64.c::arch_archdata actually does
something.  Copy that routine and create a structure containing two
fields, the start and end of the dbe table.  insmod then sets
archdata_start and archdata_end to point to the structure that points
to the dbe table.  Do not put the dbe table directly in
archdata_{start,end} in case you want to add more mips data later.

In the kernel, module.c verifies that archdata_{start,end} are valid,
if present.  It later calls module_arch_init to handle archdata.
include/asm-$(ARCH)/module.h defines macros module_map, module_unmap
and module_arch_init.  MIPS needs to define the last two.
module_arch_init is passed the struct module so it can find the arch
specific data, decode it and do what it likes with the contents.
module_unmap does any arch specific cleanup, such as removing extra
tables.

For dbe tables, define a mips module_arch_init that validates the
format of the arch specific data.  Probably all you need to do is check
that dbe start and end are inside the module.  Unless you copy the dbe
data elsewhere, module_unmap can be left as vfree.

When you want to verify the dbe table, you run the module list.  If
archdata_end >= archdata_start+2*sizeof(struct exception_table_entry *)
then archdata contains the dbe data.  If dbe_table_end > dbe_table_start
then run the table.  Checking > ignores NULL pointers.

The only other change you have to make is to init_modules().  For mips
you create pointers to the kernel dbe tables and fill in archdata start
and end in kernel_module.  Since init_module is called before kmalloc
is ready, make the kernel dbe table a static variable.
