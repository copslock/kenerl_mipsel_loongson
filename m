Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8N7vR17790
	for linux-mips-outgoing; Thu, 8 Nov 2001 15:07:57 -0800
Received: from i01sv4107.ids1.intelonline.com (i01sv4107-p.ids1.intelonline.com [147.208.166.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8N7s017787
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 15:07:54 -0800
Received: from i01sv0637 (unverified [10.81.26.22]) by i01sv4107.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B3007611160@i01sv4107.ids1.intelonline.com>;
 Thu, 8 Nov 2001 23:07:45 +0000
Message-ID: <B3007611160@i01sv4107.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "R.vandenBerg@inter.NL.net" <R.vandenBerg@inter.NL.net>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [203.14.96.34]
Date: Fri, 09 Nov 2001 9:07:45 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: Re: DECStation framebuffer support
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I couldn't get it to work either. My problem is that my monitor is
fixed sync to support the PMAGB-B card. It can't do the signal from
the maxinefb. I also tried an option "video=maxinefb:off" so it
wouldn't probe the card that was a no go either.

Unless I get a monitor that supports it, I may _have_ to use a serial
console ...

>I didn't succeed in getting that to work, my advise would to try it
first
>with the on-board video.
>
>> BTW, thanks for responding, none of this documented anywhere.
>
>Oh yes it is, do a grep maxinefb on the 1999 mail archive available
from
>http://home.zonnet.berg56/ and you see it was discussed in june... 

Hmm.. you're right! I only searched back to the Jan2000 archives but
now I realise that fb support has been around since 1999, my bad.

Cheers,
Guo-Rong


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
