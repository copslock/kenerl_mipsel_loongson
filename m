Received:  by oss.sgi.com id <S554083AbRBAJmo>;
	Thu, 1 Feb 2001 01:42:44 -0800
Received: from fte036.mc2.chalmers.se ([129.16.41.199]:10256 "EHLO
        fte036.mc2.chalmers.se") by oss.sgi.com with ESMTP
	id <S554078AbRBAJmP>; Thu, 1 Feb 2001 01:42:15 -0800
Received: from fte004 (fte004.mc2.chalmers.se [129.16.41.163])
	by fte036.mc2.chalmers.se (8.9.3 (PHNE_18979)/8.9.3) with ESMTP id KAA06565
	for <linux-mips@oss.sgi.com>; Thu, 1 Feb 2001 10:52:36 +0100 (MET)
Message-ID: <004b01c08c33$e7b42ee0$a3291081@mc2.chalmers.se>
From:   "Erik Aderstedt" <erik@ic.chalmers.se>
To:     <linux-mips@oss.sgi.com>
Subject: OSLoadOptions
Date:   Thu, 1 Feb 2001 10:46:51 +0100
Organization: Solid State Electronics Laboratory
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi!

I'm using kernel 2.4.0-test3 from the SimpleLinux dist on an
Indy w/ R4400SC, booting using DHCP on an x86 RedHat 6.1
box. Right now the boot is completely unattended, I just turn on the Indy
and a few seconds later I'm at the single user bash prompt. To get further
than this, I would like to pass command line options to the kernel at boot,
and have tried setting the OSLoadOptions PROM variable.

The problem is that the kernel seems to be passed the string
'OSLoadOptions=<my kernel boot options>', instead of just the
boot options. At least that is what is indicated by the line

Kernel command line: OSLoadOptions=init=/sbin/simpleinit

during boot. At the end of this mail is a clunky patch that fixes this, but
I'm not sure if this is the right way to go about it.

/Erik
erik@ic.chalmers.se

Patch to linux/arch/mips/arc/cmdline.c of 2.4.0

37c37
<       int actr, i;
---
>       int actr, i, offset;
48a49
>           offset = (!strncmp(prom_argv[actr], "OSLoadOptions=",14)?14:0;
50,51c51,52
<               strcpy(cp, prom_argv[actr]);
<               cp += strlen(prom_argv[actr]);
---
>               strcpy(cp, prom_argv[actr] + offset);
>               cp += strlen(prom_argv[actr] + offset);
