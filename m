Received:  by oss.sgi.com id <S554142AbRA0I7a>;
	Sat, 27 Jan 2001 00:59:30 -0800
Received: from [194.90.113.98] ([194.90.113.98]:26642 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S554139AbRA0I7O>;
	Sat, 27 Jan 2001 00:59:14 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id KAA04772
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 10:58:15 +0200
Message-ID: <3A728DCE.33C2CE8A@jungo.com>
Date:   Sat, 27 Jan 2001 10:58:54 +0200
From:   Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com> <3A71BF37.7DBE8234@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Pete Popov wrote:
 
> To get the realtek driver to work, all you need to do is to set
> mips_io_port_base to KSEG1.  Let's assume that the ethernet card has
> been assigned i/o space at 0x14000000.  The driver will pick that up as
> the ioaddr and use the 0x1400000 as the "port". The inb()/outb() macros
> add mips_io_port_base to the "port" value and now you have 0xB4000000,
> so you can access the card.
> 
> Pete

The KSEG1() is indeed what I did, however the driver, as I tried to
describe, starts to loose synchronization on buffer at some point and
just waits quietly... Even with all the DEBUG and mental effort switched
on I can't get the reason why this happens...

By the way, which version of the driver are you talking about? Mine
doesn't have any ifdef on anything... besides MODULE of course:-)

Mine is:

static const char *version =
"rtl8139.c:v1.07 5/6/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/"

-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
