Received:  by oss.sgi.com id <S42278AbQGaAia>;
	Sun, 30 Jul 2000 17:38:30 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39295 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42277AbQGaAiS>; Sun, 30 Jul 2000 17:38:18 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA09957
	for <linux-mips@oss.sgi.com>; Sun, 30 Jul 2000 17:44:09 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA26055
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jul 2000 17:38:01 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-101.karlsruhe.ipdial.viaginterkom.de (u-101.karlsruhe.ipdial.viaginterkom.de [62.180.19.101]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA02770
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jul 2000 17:37:57 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868888AbQG1VqE>;
        Fri, 28 Jul 2000 23:46:04 +0200
Date:   Fri, 28 Jul 2000 23:46:04 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>,
        Keith M Wesolowski <wesolows@chem.unr.edu>,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000728234604.A8874@bacchus.dhis.org>
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com> <20000728021137.B1328@bacchus.dhis.org> <3980EC1C.AEF173D2@mvista.com> <20000728042109.C1981@bacchus.dhis.org> <20000728135139.A4903@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000728135139.A4903@cistron.nl>; from wichert@cistron.nl on Fri, Jul 28, 2000 at 01:51:39PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 28, 2000 at 01:51:39PM +0200, Wichert Akkerman wrote:

> Previously Ralf Baechle wrote:
> > Looks like strace is still tryping to copy mmap_arg_struct like on Intel
> > but on MIPS we don't use that?
> 
> Could be, I think MIPS and i386 use the same codepath there. Patches
> are appreciated so I can include them in strace 4.3 (eta 3 weeks from
> now)

Here's the second strace patch, please apply.

I noticed that process.c:change_syscall() can't work as is - the all kernels
would change the v0 register - and happily use the old value that is take
the wrong syscall.  A kernel buglet which also hits the usermode kernel
and which I'll fix asap.

  Ralf

--- strace/process.c.orig	Fri Jul 28 23:37:14 2000
+++ strace/process.c	Fri Jul 28 23:33:43 2000
@@ -502,6 +502,24 @@
 		if (errno)
 			return -1;
 	}
+#elif defined(MIPS)
+	{
+		errno = 0;
+		if (argnum < 4)
+			ptrace(PTRACE_POKEUSER, tcp->pid,
+			       (char*)(REG_A0 + argnum), tcp->u_arg[argnum]);
+		else {
+			unsigned long *sp;
+
+			if (upeek(tcp->pid, REG_SP, (long *) &sp) , 0)
+				return -1;
+
+			ptrace(PTRACE_POKEDATA, tcp->pid,
+			       (char*)(sp + argnum - 4), tcp->u_arg[argnum]);
+		}
+		if (errno)
+			return -1;
+	}
 #else
 # warning Sorry, setargs not implemented for this architecture.
 #endif
