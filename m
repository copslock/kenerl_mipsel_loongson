Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA852BC22913
	for linux-mips-outgoing; Wed, 7 Nov 2001 21:02:11 -0800
Received: from i01sv4107.ids1.intelonline.com (i01sv4107-p.ids1.intelonline.com [147.208.166.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8528022910
	for <linux-mips@oss.sgi.com>; Wed, 7 Nov 2001 21:02:08 -0800
Received: from i01sv0648 (unverified [10.81.26.32]) by i01sv4107.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B3007593198@i01sv4107.ids1.intelonline.com> for <linux-mips@oss.sgi.com>;
 Thu, 8 Nov 2001 05:02:02 +0000
Message-ID: <B3007593198@i01sv4107.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [203.14.96.10]
Date: Thu, 08 Nov 2001 15:02:01 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: Re: DECStation framebuffer support
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>The kernel should support console on framebuffer, it once did. With
the
>on-board video the kernel needed 'video=maxinefb:on' as a kernel
option,
>dunno if that's still the case. You only have the on-board video, no
>second video controller?
>
>Greetings,
>Richard

I've also got a PMAGB-B installed in the system. Since system detects
and uses that as default, I'm guessing the kernel option will be
'video=pmagb-b-fb:on' right?

BTW, thanks for responding, none of this documented anywhere.

Guo-Rong


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
