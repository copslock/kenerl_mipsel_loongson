Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA70HAQ17823
	for linux-mips-outgoing; Tue, 6 Nov 2001 16:17:10 -0800
Received: from i01sv4107.ids1.intelonline.com (i01sv4107-p.ids1.intelonline.com [147.208.166.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA70H8017820
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 16:17:08 -0800
Received: from i01sv0637 (unverified [10.81.26.22]) by i01sv4107.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B3007554463@i01sv4107.ids1.intelonline.com> for <linux-mips@oss.sgi.com>;
 Wed, 7 Nov 2001 00:17:00 +0000
Message-ID: <B3007554463@i01sv4107.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [203.14.96.34]
Date: Wed, 07 Nov 2001 10:17:00 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: DECStation framebuffer support
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I have just decided to try getting Linux running on my DECStation
5000/25 (currently running NetBSD). I succeeded in cross-compiling a
2.4.12 kernel from an i686 Linux box. My main aim is to get the
framebuffer working.

To test the kernel I dumped it on the NetBSD root and hit "boot
3/rz0/vmlinux".

This gets me to "This is a Personal DECStation 5000/xx" then stops.

Any suggestions as to what I should do next?
Framebuffer support for all the framebuffers has been compiled in. The
question is: To what extent does the kernel support console on
framebuffer?

Thanks,
Guo-Rong


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
