Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OFpIc21732
	for linux-mips-outgoing; Tue, 24 Jul 2001 08:51:18 -0700
Received: from highland.isltd.insignia.com (highland.isltd.insignia.com [195.217.222.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OFpHO21727
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 08:51:17 -0700
Received: from wolf.isltd.insignia.com (wolf.isltd.insignia.com [172.16.1.3])
	by highland.isltd.insignia.com (8.11.3/8.11.3/check_local4.2) with ESMTP id f6OFpF439191;
	Tue, 24 Jul 2001 16:51:15 +0100 (BST)
Received: from snow (snow.isltd.insignia.com [172.16.17.209])
	by wolf.isltd.insignia.com (8.9.3/8.9.3) with SMTP id QAA23185;
	Tue, 24 Jul 2001 16:51:14 +0100 (BST)
Message-ID: <013401c11458$7813b6c0$d11110ac@snow.isltd.insignia.com>
From: "Andrew Thornton" <andrew.thornton@insignia.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc: "James Simmons" <jsimmons@transvirtual.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
Date: Tue, 24 Jul 2001 16:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert,

>Using `atydebug' (from tools in CVS module atyfb at
>http://www.sourceforge.net/projects/linux-fbdev/), the PLL debug values
mean:
>
>| tux$ ./atydebug ac ac 24 df f6 04 00 fd 8e 9e 65 05 00 00 00 00
>| PLL rate = 417.901480 MHz (guessed)
>| bad MCLK post divider 5
>| VCLK0 = 414.623821 MHz
>| VCLK1 = 232.713765 MHz
>| VCLK2 = 86.311678 MHz
>| VCLK3 = 165.521763 MHz
>| tux$
>
>Which looks a bit odd. The same for the 512 K SGRAM.
>
>So I guess the Malta firmware hasn't initialized the RAGE XL yet. And atyfb
>requires an initialized chip.

I guess this is not surprising because the Malta firmware isn't a PC BIOS.

Andrew Thornton
