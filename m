Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3N2NtX32502
	for linux-mips-outgoing; Sun, 22 Apr 2001 19:23:55 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3N2NrM32497
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 19:23:53 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14rVxB-0002QF-00; Sun, 22 Apr 2001 22:19:53 -0400
Date: Sun, 22 Apr 2001 22:19:53 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
Message-ID: <20010422221953.A9097@nevyn.them.org>
References: <20010418141959.A24473@nevyn.them.org> <3ADDFD6A.AD0DDE4A@cotw.com> <20010418163727.A29531@nevyn.them.org> <20010422180718.A6180@foobazco.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010422180718.A6180@foobazco.org>; from wesolows@foobazco.org on Sun, Apr 22, 2001 at 06:07:18PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 22, 2001 at 06:07:18PM -0700, Keith M Wesolowski wrote:
> On Wed, Apr 18, 2001 at 04:37:27PM -0400, Daniel Jacobowitz wrote:
> 
> > If you're referring to libc-mips-04052001.patch.bz2, that's what I
> > started with.  I needed two changes on top of it.  I'll post them in a
> > bit.
> 
> Have you or anyone else made further progress on this?  One of the
> additional patches is obvious; the glibc stuff is not so obvious.

I have them working in the case I care about - no backwards
compatibility at all.  We (Monta Vista) can get away with this :)
I've attached the patches.

I can not do a more general fix for supporting both kinds of
executables unless someone with a better understanding of ELF than I is
willing to answer the questions I believe I sent to this list a few
days ago.

The only way I can see to get at the DT_MIPS(BASE_ADDRESS) or whatever it
was called early enough to use it requires some extra disk activity; it
shouldn't be too harmful, but I'd rather not impose that much of a
speed penalty for every open of a shared object.  Perhaps it could be
done efficiently with mremap()...

I still don't see why BASE_ADDRESS is necessary, but I'm sure there was
a good reason it was added.  I've never seen a shared object with the
virtual address of the first LOAD not equal to the base address...

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="glibc-mips-abi.patch"

diff -urN libc-04052001/sysdeps/mips/mipsel/rtld-parms libc-04052001-patched/sysdeps/mips/mipsel/rtld-parms
--- libc-04052001/sysdeps/mips/mipsel/rtld-parms	Sat Jul 12 18:26:15 1997
+++ libc-04052001-patched/sysdeps/mips/mipsel/rtld-parms	Fri Apr  6 09:23:27 2001
@@ -1,3 +1,3 @@
 ifndef rtld-oformat
-rtld-oformat = elf32-littlemips
+rtld-oformat = elf32-tradlittlemips
 endif
--- glibc-2.2.3/sysdeps/mips/rtld-parms.orig	Wed Apr 11 16:12:56 2001
+++ glibc-2.2.3/sysdeps/mips/rtld-parms	Wed Apr 11 16:13:03 2001
@@ -2,7 +2,7 @@
 rtld-wordsize = 32
 endif
 ifndef rtld-oformat
-rtld-oformat = elf$(rtld-wordsize)-bigmips
+rtld-oformat = elf$(rtld-wordsize)-tradbigmips
 endif
 ifndef rtld-arch
 rtld-arch = mips
--- glibc-2.2.3/sysdeps/mips/dl-machine.h.orig	Wed Apr 18 14:20:17 2001
+++ glibc-2.2.3/sysdeps/mips/dl-machine.h	Wed Apr 18 14:21:15 2001
@@ -61,6 +61,9 @@
    in l_info array.  */
 #define DT_MIPS(x) (DT_MIPS_##x - DT_LOPROC + DT_NUM)
 
+#if 0
+/* mvista: This is no longer needed, or safe, after the tradlittlemips patch. */
+
 /*
  * MIPS libraries are usually linked to a non-zero base address.  We
  * subtract the base address from the address where we map the object
@@ -76,6 +79,7 @@
 			  (l)->l_info[DT_MIPS(BASE_ADDRESS)]->d_un.d_ptr : 0)
 #else
 #define MAP_BASE_ADDR(l) 0x5ffe0000
+#endif
 #endif
 
 /* If there is a DT_MIPS_RLD_MAP entry in the dynamic section, fill it in

--SLDf9lqlvOQaIe6s--
