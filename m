Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 15:49:53 +0100 (CET)
Received: from real.realitydiluted.com ([208.242.241.164]:1175 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1122121AbSKDOtx>; Mon, 4 Nov 2002 15:49:53 +0100
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 188iXw-0004Q2-00; Mon, 04 Nov 2002 08:49:44 -0600
Message-ID: <3DC68907.30708@realitydiluted.com>
Date: Mon, 04 Nov 2002 08:49:43 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>>>Is every object or library mentioned on that line already marked as
>>>MIPS-2 by readelf?  Even crt*, libc*?
>>>
>>
>>I knew I was being stupid, crt* and libc* are mips1 *sigh*. Looks
>>like I have more work to do for my build system. Below is the verbose
>>output, but I think that's the problem for sure.
> 
> 
>  Hmm, that's strange as a single mips2 object among mips1 ones should make
> an executable/shared library be marked as mips2 and not mips1.  I wouldn't
> worry in the long run, though, as I think this should be fixed in the
> trunk as Richard Sandiford was working in these areas recently.  You might
> want to do a verification to be sure, though. 
> 
I tried the trunk and got the same thing. I have made some additional
progress. First, I used H.J.Lu's patch for the most part:

    http://sources.redhat.com/ml/binutils/2001-10/msg00526.html

Specifically the part:

-  elf_elfheader (abfd)->e_flags &= ~(EF_MIPS_ARCH | EF_MIPS_MACH);
-  elf_elfheader (abfd)->e_flags |= val;
+  if (isa != 0 && (elf_elfheader (abfd)->e_flags & EF_MIPS_ARCH) == 0)
+    {
+      elf_elfheader (abfd)->e_flags &= ~EF_MIPS_ARCH;
+      elf_elfheader (abfd)->e_flags |= isa;
+    }
+
+  if (cpu != 0)
+    {
+      elf_elfheader (abfd)->e_flags &= ~EF_MIPS_MACH;
+      elf_elfheader (abfd)->e_flags |= cpu;
+    }

So, now when I am building 'zlib', the object files get built with:

   mipsel-linux-gcc -march=r6000 -fPIC -O3 -DHAVE_UNISTD_H -DUSE_MMAP

and then shared object creation uses:

   mipsel-linux-gcc -shared -Wl,-A,r6000,-v,-soname,libz.so.1 \
     -march=r6000 -o libz.so.1.1.4 adler32.o compress.o crc32.o gzio.o \
     compr.o deflate.o trees.o zutil.o inflate.o infblock.o inftrees.o \
     infcodes.o infutil.o inffast.o

with the verbose output of:

collect2 version 3.2 (MIPSel GNU/Linux with ELF)
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/bin/ld 
--eh-frame-hdr -EL -shared -o libz.so.1.1.4 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib/crti.o 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/crtbeginS.o 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib 
-L/opt/toolchains/uclibc-crosstools-1.0.0/lib/gcc-lib/mipsel-linux/3.2 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib 
-L/opt/toolchains/uclibc-crosstools-1.0.0/lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../.. -A 
r6000 -v -soname libz.so.1 adler32.o compress.o crc32.o gzio.o uncompr.o 
deflate.o trees.o zutil.o inflate.o infblock.o inftrees.o infcodes.o 
infutil.o inffast.o -lgcc -lc -lgcc 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/crtendS.o 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib/crtn.o

The 'crt*' files and my C runtime are compiled with 'mips1', but as
Maciej correctly states in his reply, the output binary should be
the highest ISA value when mixing differing ISA objects.

I'm convinced the linker completely ignores '-A' for MIPS. In the 
'_bfd_mips_elf_final_write_processing' function in 'bfd/elfxx-mips.c'
If I print out the EF_MIPS_ARCH flags for the input BFD descriptor. It
is properly set to 'MIPS2', but when the case statement in 
'_bfd_mips_elf_final_write_processing' is traversed, it
uses the R3000/default case which means that the target CPU architecture
didn't get put into the BFD descriptor. So, I instead changed the ISA
if statement above to be:

   if (((elf_elfheader (abfd)->e_flags & EF_MIPS_ARCH) != isa) && (isa 
!= 0))
     {
       elf_elfheader (abfd)->e_flags &= ~EF_MIPS_ARCH;
       elf_elfheader (abfd)->e_flags |= isa;
     }

which then properly sets the ISA in the ELF header. My gut feeling
though is that we shouldn't have to do this as the target CPU
architecture should have been set properly for the incoming BFD.
Comments and suggestions welcome. Thanks.

-Steve
