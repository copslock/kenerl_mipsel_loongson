Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BD8Xb04188
	for linux-mips-outgoing; Fri, 11 May 2001 06:08:33 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BD8WF04185
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 06:08:32 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f4BD8CU31549;
	Fri, 11 May 2001 15:08:13 +0200
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14yCeF-0002Nq-00; Fri, 11 May 2001 15:07:59 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 2B40C1EA2E; Fri, 11 May 2001 15:07:57 +0200 (CEST)
Mail-Copies-To: never
To: sjhill@cotw.com
Cc: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: glibc MIPS patch to check for binutils version...
References: <3AFBD5DE.A0457C6F@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 11 May 2001 15:07:57 +0200
In-Reply-To: <3AFBD5DE.A0457C6F@cotw.com> ("Steven J. Hill"'s message of "Fri, 11 May 2001 07:06:54 -0500")
Message-ID: <u8wv7ohw42.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Greetings.
> 
> Please find attached a patch to GLIBC that is compatible with
> the new version of binutils (HJLu's and CVS at least). I have
> also added some cruft in 'configure.in' that will produce
> warning messages if a user attempt to use old binutils. Comments
> are welcome. I have gone out on a limb and also included a
> Changelog entry in case this patch actually gets accepted :).
> This patch will apply against the CVS version of GLIBC. Please
> regenerate 'configure'. Thanks.
> 
> -Steve
> 
> 
> ***** Changelog entry *****
>         * sysdeps/mips/rtld-ldscript.in: removed unneeded binary
>         output format directive

Ok.


>         * configure.in: added in checking for obsolete binutils
>         for MIPS targets which produces a warning message if
>         user attempts to use older tools.
> ***************************

Let's do this differently.  I'm appending a patch that does it more
the "glibc way".  I've committed everything to CVS including a patch
for the FAQ.  I hope I got the version numbers right.

Thanks,
Andreas

2001-05-11  Andreas Jaeger  <aj@suse.de>

	* sysdeps/unix/sysv/linux/configure.in: Check binutils version on
	MIPS.

============================================================
Index: sysdeps/unix/sysv/linux/configure.in
--- sysdeps/unix/sysv/linux/configure.in	2001/03/16 07:35:59	1.37
+++ sysdeps/unix/sysv/linux/configure.in	2001/05/11 12:58:25
@@ -191,3 +191,14 @@
     AC_MSG_RESULT(ok)
   fi
 fi
+
+case "$machine" in
+  mips*)
+	AC_CHECK_PROG_VER(AS, $AS, --version,
+	  [GNU assembler.* \([0-9]*\.[0-9.]*\(-ia64-[0-9]*\)*\)],
+	  [2.11.90.0.[5-9]* | 2.11.90.[1-9]* | 2.11.9[1-9]* | 2.11.[1-9]* | 2.1[2-9]*| 2.[2-9]*], 
+	AC_MSG_WARN([*** Your binutils versions are too old.  
+*** We strongly advise to update binutils.  For details check 
+*** the FAQ and INSTALL documents.]))
+	;;
+esac
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
