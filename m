Received:  by oss.sgi.com id <S554014AbRA1KV2>;
	Sun, 28 Jan 2001 02:21:28 -0800
Received: from [194.90.113.98] ([194.90.113.98]:39954 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S554002AbRA1KVO>;
	Sun, 28 Jan 2001 02:21:14 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id MAA11481;
	Sun, 28 Jan 2001 12:20:04 +0200
Message-ID: <3A73F27B.9FFC3A8@jungo.com>
Date:   Sun, 28 Jan 2001 12:20:43 +0200
From:   Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com> <3A71BF37.7DBE8234@mvista.com> <3A728DCE.33C2CE8A@jungo.com> <3A733E40.9B1F02DD@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Pete Popov wrote:
> 
> >
> > By the way, which version of the driver are you talking about? Mine
> > doesn't have any ifdef on anything... besides MODULE of course:-)
> >
> > Mine is:
> >
> > static const char *version =
> > "rtl8139.c:v1.07 5/6/99 Donald Becker
> > http://cesdis.gsfc.nasa.gov/linux/drivers/"
> 
> Hmmm, the above looks like the header for the 8129 driver, except that
> it says rtl8139.  Make sure you're using drivers/net/8139too.c   I see
> this in the driver:   #define RTL8139_VERSION "0.9.10". I'm using test9
> kernel, I doubt that you're driver is out of date -- it seems you're
> perhaps using the wrong driver.
> 
> Regarding the I/O vs MEM accesses, look for this:
> 
> /* define to 1 to enable PIO instead of MMIO */
> #undef USE_IO_OPS
> 
> Pete

I have checked the Scyld web page, this is where D. Becker currently
work on the driver (http://www.scyld.com/network/rtl8139.html)

Newer driver indeed seem to be more multi-platform aware, though
out-of-box compilation still crashed the kernel (access to 0x18000051
instead of 0xb8000051, KSEG1 stuff again). Corrected. Still no luck,
driver seems not to find where the card is. Switched cards to another
manufacturer [compatible, of course :-)] -- same result.

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
