Received:  by oss.sgi.com id <S553848AbRADVfZ>;
	Thu, 4 Jan 2001 13:35:25 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42930 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553719AbRADVfD>;
	Thu, 4 Jan 2001 13:35:03 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA23098;
	Thu, 4 Jan 2001 22:34:40 +0100 (MET)
Date:   Thu, 4 Jan 2001 22:34:40 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Christoph Martin <martin@uni-mainz.de>
cc:     ralf@oss.sgi.com, Christoph.Martin@uni-mainz.de,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        debian-mips@lists.debian.org, Andreas Jaeger <aj@suse.de>
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <14932.57412.617757.439688@arthur.zdv.Uni-Mainz.DE>
Message-ID: <Pine.GSO.3.96.1010104222312.17873C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, Christoph Martin wrote:

> I just tried to build glibc-2.2 (CVS-2000-12-28) for debian-mips and
> it still has the "Bus Error" problem. We are currently using binutils
> 2.10.1.0.2 and gcc 2.95.2 + CVS from 2.95 branch. 
> 
> Can you please post both patches, so that we can verify which one is
> missing in our build.

 The 2.2 release of glibc needs no patches.  The current CVS version is
even better as a few unrelated fixes has been applied meanwhile.

 For binutils 2.10.1 the following fix makes binaries be built as ld.so
expects.  Other fixes might be needed for 2.10.1 to work at all -- they
are all available from: 
ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/binutils-2.10.1-3.src.rpm (or use
a mirror at: ftp://ftp.rfc822.org/pub/mirror/ftp.ds2.pg.gda.pl/...).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

binutils-2.10-mips-dyn-addend.patch
diff -up --recursive --new-file binutils-2.10.macro/bfd/elf32-mips.c binutils-2.10/bfd/elf32-mips.c
--- binutils-2.10.macro/bfd/elf32-mips.c	Sat Mar 11 02:23:10 2000
+++ binutils-2.10/bfd/elf32-mips.c	Sat Oct 28 17:19:52 2000
@@ -5675,15 +5675,16 @@ mips_elf_create_dynamic_relocation (outp
 	  /* The relocation we're building is section-relative.
 	     Therefore, the original addend must be adjusted by the
 	     section offset.  */
-	  *addendp += symbol - sec->output_section->vma;
+	  *addendp += section_offset;
 	  /* Now, the relocation is just against the section.  */
 	  symbol = sec->output_section->vma;
 	}
       
-      /* If the relocation was previously an absolute relocation, we
-	 must adjust it by the value we give it in the dynamic symbol
-	 table.  */
-      if (r_type != R_MIPS_REL32)
+      /* If the relocation was previously an absolute relocation and
+	 this symbol will not be referred to by the relocation, we must
+	 adjust it by the value we give it in the dynamic symbol table.
+	 Otherwise leave the job up to the dynamic linker.  */
+      if (!indx && r_type != R_MIPS_REL32)
 	*addendp += symbol;
 
       /* The relocation is always an REL32 relocation because we don't
