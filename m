Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MGXdc15072
	for linux-mips-outgoing; Fri, 22 Feb 2002 08:33:39 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MGXc915069
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 08:33:38 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA17995;
	Fri, 22 Feb 2002 07:33:29 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA21494;
	Fri, 22 Feb 2002 07:33:28 -0800 (PST)
Message-ID: <002e01c1bbb6$d436d5d0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Venkatesh M R" <venkatesh@multitech.co.in>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
References: <3C763244.5030206@multitech.co.in>
Subject: Re: How To Remove Write Protection
Date: Fri, 22 Feb 2002 16:37:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>    I am presently porting RTLinux to MIPS Atlas board ( with 4Kc core ).
> Can you please tell me how to remove the write protection of the Linux 
> kernel (2.4.3) .
> Because I am getting the page fault when i am trying to insert the 
> Rtlinux module.

I rather doubt that write protection has anything to do with
what you are seeing.  It is far more likely that you are making
the kernel dereference an uninitialized pointer.

            Kevin K.
