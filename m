Received:  by oss.sgi.com id <S554010AbRA1KLr>;
	Sun, 28 Jan 2001 02:11:47 -0800
Received: from [194.90.113.98] ([194.90.113.98]:38418 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553995AbRA1KLb>;
	Sun, 28 Jan 2001 02:11:31 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id MAA11441;
	Sun, 28 Jan 2001 12:10:26 +0200
Message-ID: <3A73F03A.3516E4F5@jungo.com>
Date:   Sun, 28 Jan 2001 12:11:06 +0200
From:   Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com> <20010127112204.J867@bacchus.dhis.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Fri, Jan 26, 2001 at 09:56:00AM +0200, Michael Shmulevich wrote:
> > Date:   Fri, 26 Jan 2001 09:56:00 +0200
> > From: Michael Shmulevich <michaels@jungo.com>
> > CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
> > Subject: Re: MIPS/linux compatible PCI network cards
> > To: unlisted-recipients:; (no To-header on input)
> >
> > Pete Popov wrote:
> > >
> > >
> > > Another one is the RTL8139.  It's quite cheap (I think less than $20).
> > >
> > > Pete
> >
> > Surprisingly enough, Realtek's driver is quite x86-oriented. It uses
> > some ugly outb() functtions without any ioremap()'ping.
> 
> inb() and friends are for what Inhell calls I/O space.  Ioremap is for
> memory mapped I/O.  So you usually don't find both of them in the same
> driver.
> 
>   Ralf

I guess I will not. But at least hoped to see some io_port_base (?)
reference somewhere. neither ioremap, nor io_port_base is found in
rtl8139.c... I have tried to add some, but the results are still quite
disencouraging. 

Newer version of rtl8139.c (from the Scyld) have pci-scan dependency
which is not compatible with 2.2.14...

 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
