Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEwT715124
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:58:29 -0700
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEwPV15121;
	Fri, 10 Aug 2001 07:58:25 -0700
Received: from zeus-fddi.americas.sgi.com (zeus-fddi.americas.sgi.com [128.162.8.103]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA00509; Fri, 10 Aug 2001 07:56:22 -0700 (PDT)
	mail_from (lord@sgi.com)
Received: from daisy-e185.americas.sgi.com (daisy.americas.sgi.com [128.162.185.214]) by zeus-fddi.americas.sgi.com (8.9.3/americas-smart-nospam1.1) with ESMTP id JAA2678389; Fri, 10 Aug 2001 09:57:08 -0500 (CDT)
Received: from jen.americas.sgi.com (IDENT:root@jen.americas.sgi.com [128.162.187.49]) by daisy-e185.americas.sgi.com (SGI-8.9.3/SGI-server-1.7) with ESMTP id JAA20365; Fri, 10 Aug 2001 09:57:08 -0500 (CDT)
Received: from jen.americas.sgi.com by jen.americas.sgi.com (8.11.2/SGI-client-1.7) via ESMTP id f7AEuMi07997; Fri, 10 Aug 2001 09:56:22 -0500
Message-Id: <200108101456.f7AEuMi07997@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Steve Lord <lord@sgi.com>, Seth Mos <knuffie@xs4all.nl>,
   Brandon Barker <bebarker@meginc.com>, linux-mips@oss.sgi.com,
   linux-xfs@oss.sgi.com
Subject: Re: XFS installer 
In-Reply-To: Message from Ralf Baechle <ralf@oss.sgi.com> 
   of "Fri, 10 Aug 2001 16:48:07 +0200." <20010810164807.A24889@bacchus.dhis.org> 
Date: Fri, 10 Aug 2001 09:56:22 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Fri, Aug 10, 2001 at 08:46:26AM -0500, Steve Lord wrote:
> 
> > The page size == block size will get fixed, we need to do that, but it
> > may take a while. Block size less than pagesize will come first, blocksize
> > greater than pagesize needs PAGE_CACHE_SIZE to be bumped, which appears to
> > be on the cards for 2.5.
> > 
> > V1 directories mostly work in Linux, but there are glibc getdents issues
> > with them. The glibc code which lseeks backwards in a directory is the issu
> e,
> > if you have control over your glibc it can be fixed by using the 64 bit
> > version of lseek in this code. This is all because the directory offset in
> > V1 is a 64 bit hash value, not a 32 bit signed number.
> 
> So in other words that means using kernel 2.4 / glibc 2.2 and for 32-bit
> systems building applications with the large file API.

No, it all depends on which version of the glibc getdents code you have,
there have been several, I cannot remember what it looks like now.
here is an old patch:

--- glibc-2.1.3/sysdeps/unix/sysv/linux/getdents.c.orig	Fri May  7 09:41:08 1999
+++ glibc-2.1.3/sysdeps/unix/sysv/linux/getdents.c	Thu Mar 23 11:49:11 2000
@@ -53,6 +53,9 @@
 #ifdef GETDENTS64
 # define __getdents __getdents64
 # define dirent dirent64
+# undef off_t
+# define off_t off64_t
+# define __lseek __lseek64
 #endif
 
 /* The problem here is that we cannot simply read the next NBYTES
@@ -107,6 +110,33 @@
 	}
 
       last_offset = kdp->d_off;
+
+#ifdef GETDENTS64
+	if (sizeof(__kernel_off_t) < sizeof(off64_t)) {
+	    /*
+	     * The kernel returns d_off as a 'cookie' that can be used
+	     * in an lseek() to re-position the directory stream.
+	     * "d_off" is signed by current definition of "__kernel_off_t",
+	     * which is consistent with lseek() "off_t" semantics.
+	     * Some file systems, most commonly NFS, may return "d_off"
+	     * 'cookies' that use all 32 bits, or more specifically the
+	     * sign bit.
+	     * This means we need to be careful how we save "last_offset"
+	     * in the case where "last_offset" is defined to be a larger
+	     * container than "__kernel_off_t", we want to prevent the sign
+	     * extension; it's only the lower 32 bits that we want to be
+	     * able to pass back in via lseek64().
+	     */
+	    switch(sizeof(__kernel_off_t)) {
+	    case 4:
+		{
+		    last_offset = (u_int32_t)kdp->d_off;
+
+		    break;
+		}
+	    }
+	}
+#endif
       dp->d_ino = kdp->d_ino;
       dp->d_off = kdp->d_off;
       dp->d_reclen = new_reclen;


I am pretty sure this patch is useless with a 2.2 glibc.

The issue is not so much the application interface as the fact that glibc has
the nasty habit of lseeking back in the directory because its dirent and
the kernels are not the same size. 

Steve
