Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f46GBDc05742
	for linux-mips-outgoing; Sun, 6 May 2001 09:11:13 -0700
Received: from mailgw2.netvision.net.il (mailgw2.netvision.net.il [194.90.1.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f46GBAF05739
	for <linux-mips@oss.sgi.com>; Sun, 6 May 2001 09:11:11 -0700
Received: from athena.home.krftech.com ([194.90.113.98])
	by mailgw2.netvision.net.il (8.9.3/8.9.3) with SMTP id TAA17636
	for <linux-mips@oss.sgi.com>; Sun, 6 May 2001 19:12:52 +0300 (IDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shay Deloya <shay@jungo.com>
Reply-To: shay@jungo.com
Organization: Jungo Corp.
To: linux-mips@oss.sgi.com
Subject: insmod problems
Date: Sun, 6 May 2001 19:13:43 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050619134301.01140@athena.home.krftech.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

I have an old problem came up again and the old solution aren't helping.
I'm using busybox version 0.50 and with kernel 2.2 , and inserting 
some modules ,especially those with DEBUG macroes e.g:
#define DEBUG_HIGH(args...) {if (debug_level >= HIGH) printk(args);}
causes the message :
Relocation overflow of type 4 for

and insmod fails.

I'm compiling the modules with -mlong-calls and still getting this message.

Is it insmod knowen bugs that the relocation is done in bad way or 
a linker/compiler bug. I'm using compiler: egcs ver 1.0.3a
I'm checking this problem at the moment and looking for insmod bug.

Thanks,

Shay Deloya
______________________________________
Software Developer
Jungo - R&D
email: shayd@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 221
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
