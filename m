Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0GdX29581
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:16:39 -0800
Received: from i01sv4132.ids1.intelonline.com (i01sv4132-p.ids1.intelonline.com [147.208.166.15])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAE0Gb029578
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 16:16:37 -0800
Received: from i01sv0648 (unverified [10.81.26.32]) by i01sv4132.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B1514136053@i01sv4132.ids1.intelonline.com> for <linux-mips@oss.sgi.com>;
 Wed, 14 Nov 2001 00:16:32 +0000
Message-ID: <B1514136053@i01sv4132.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [203.14.96.10]
Date: Wed, 14 Nov 2001 10:16:30 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: 2.4.13-pre5 problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I decided to give up on framebuffer support for now. 
Anyway, what's the current suggested kernel for a DECStation 5000/25?
My cross-compiled 2.4.13-pre5 kernel stops after calibrating the delay
loop. Is this kernel revision buggy or is there something else I need
to know? (It seems to die somewhere in mem_init).

Thanks,
Guo-Rong


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
