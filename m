Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CCxNRw024815
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 05:59:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CCxNEp024814
	for linux-mips-outgoing; Fri, 12 Jul 2002 05:59:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CCxKRw024805
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 05:59:20 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6CD3pXb016106
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 06:03:51 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA07976
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 06:03:51 -0700 (PDT)
Message-ID: <00ce01c229a4$a7d4ed40$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>
Subject: Mipsel libc with LL/SC online anywhere?
Date: Fri, 12 Jul 2002 15:04:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm benchmarking some code that does lots of
semaphores, and with the libc from the "standard"
MIPS/SGI RH 7.1 distribution, those are done using
sysmips, in the interest of universality.  Regardles of
whether and how the ongoing argument of How Things
Should Be is settled, is there a copy of an up-to-date
glibc package built to use ll/sc out there on anyone's
FTP or web server?  I suppose I could extract and
replace the necessary routines by hand, but that would
be slow and fraught with the risk of error...

            Regards,

            Kevin K.
