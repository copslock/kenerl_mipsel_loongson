Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f330Sdj13314
	for linux-mips-outgoing; Mon, 2 Apr 2001 17:28:39 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f330ScM13311
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 17:28:38 -0700
Received: from cotw.com (dsl19.cedar-rapids.net [208.242.241.211])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id TAA13454
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 19:28:15 -0500
Message-ID: <3AC90E16.AEF59359@cotw.com>
Date: Mon, 02 Apr 2001 18:41:10 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Binutils fixed to deal with 'insmod' issue and discussion...
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I would like to officially announce patches to binutils and
friends that fix the mismatch of symbols in kernel modules
compiled for MIPS architectures that produced messages like
these below:


dummy.o: local symbol gcc2_compiled. with index 10 exceeds local_symtab_size 10
dummy.o: local symbol __gnu_compiled_c with index 11 exceeds local_symtab_size
10
dummy.o: local symbol __module_kernel_version with index 12 exceeds
local_symtab_size 10

They are available at (ftp://ftp.cotw.com/pub/linux/nino/toolchain/)
and are made against the official binutils/gcc/glibc straight out
of CVS snapshots made on 03292001. The most important patch is of
course the one made to binutils. The patch to GCC fixes the error
that some people are seeing with a missing 'atexit' symbol when
cross compiling glibc. You must update to GCC out of CVS in order
to fix this issue AFAIK. The GCC patch was done by HJ Lu and not
myself. This patch has been tested for a 32-bit toolchain configured
for little-endian. It currently does not compile for big endian and
64-bit architectures. The reason for this is what I would like to
discuss with everyone.

Without the binutils patch, all binaries compiled for MIPS/Linux
will be IRIX flavored which was the whole problem. I would now
like to make 'elf[32|64]_trad[little|big]mips' be the official
targets instead of 'elf[32|64]_[little|big]mips' which is what
things currently are. This means changing of linker scripts in
GLIBC as well as the Linux kernel (as far as I can tell). I would
like to propose the any 'mips*-*-linux-gnu' and 'mips*el-*linux-gnu'
targets be pure traditional targets WITHOUT any emulated IRIX targets
which are the current 'elf[32|64]_[little|big]mips' targets. Please
provide feedback, comments, etc. with justification. Thanks.

-Steve

  I shall now put on asbestos armor and grab a LART.

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
