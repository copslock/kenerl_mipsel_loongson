Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARJGWp28992
	for linux-mips-outgoing; Tue, 27 Nov 2001 11:16:32 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARJGOo28958
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 11:16:24 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CF519125C8; Tue, 27 Nov 2001 10:16:22 -0800 (PST)
Date: Tue, 27 Nov 2001 10:16:22 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com
Subject: PATCH: Fix ELF (Re: The Linux binutils 2.11.92.0.12 is released.)
Message-ID: <20011127101622.A30458@lucon.org>
References: <20011126212859.A17557@lucon.org> <20011127180022.A6897@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127180022.A6897@convergence.de>; from js@convergence.de on Tue, Nov 27, 2001 at 06:00:22PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 06:00:22PM +0100, Johannes Stezenbach wrote:
> Hi,
> 
> On Mon, Nov 26, 2001 at 09:28:59PM -0800, H . J . Lu wrote:
> > Please report any bugs related to binutils 2.11.92.0.12 to hjl@lucon.org.
> 
> I tried to use binutils-2.11.92.0.12 with gcc-3.0.2 to compile
> the linux kernel from linux-mips.sourceforge.net for a VR4121 CPU
> (littel endian, target mipsel-linux).
> 
> a) The linker chrashes trying to create the object file for the
>    embedded initrd ramdisk:
> 
> make CFLAGS="-I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe " -C  arch/mips/ramdisk
> make[1]: Entering directory `/home/js/MIPS/kernel/build/linux-2.4.14-mips/arch/mips/ramdisk'
> echo "O_FORMAT:  " elf32-tradlittlemips
> O_FORMAT:   elf32-tradlittlemips
> mipsel-linux-ld -G 0 -T ld.script -b binary --oformat elf32-tradlittlemips -o ramdisk.o ramdisk.gz
> make[1]: *** [ramdisk.o] Segmentation fault
> make[1]: *** Deleting file `ramdisk.o'
> 
>   The same ramdisk.gz worked with binutils-2.11.92.0.10. The ld.script is:
> OUTPUT_ARCH(mips)
> SECTIONS
> {
>   .initrd :
>   {
>        *(.data)
>   }
> }
> 
> 

I am going to check in this patch to fix it.


H.J.
----
2001-11-27  H.J. Lu <hjl@gnu.org>

	* elflink.h (elf_bfd_discard_info): Skip if the input bfd isn't
	ELF.

Index: elflink.h
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elflink.h,v
retrieving revision 1.96.2.1
diff -u -p -r1.96.2.1 elflink.h
--- elflink.h	2001/11/25 19:55:57	1.96.2.1
+++ elflink.h	2001/11/27 18:14:32
@@ -8079,6 +8079,9 @@ elf_bfd_discard_info (info)
     return false;
   for (abfd = info->input_bfds; abfd != NULL; abfd = abfd->link_next)
     {
+      if (bfd_get_flavour (abfd) != bfd_target_elf_flavour)
+	continue;
+
       bed = get_elf_backend_data (abfd);
 
       if ((abfd->flags & DYNAMIC) != 0)
