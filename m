Received:  by oss.sgi.com id <S553914AbRAZH4d>;
	Thu, 25 Jan 2001 23:56:33 -0800
Received: from [194.90.113.98] ([194.90.113.98]:7442 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553854AbRAZH4O>;
	Thu, 25 Jan 2001 23:56:14 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id JAA32045
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 09:55:20 +0200
Message-ID: <3A712D90.3CC9EBAF@jungo.com>
Date:   Fri, 26 Jan 2001 09:56:00 +0200
From:   Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Pete Popov wrote:
> 
> 
> Another one is the RTL8139.  It's quite cheap (I think less than $20).
> 
> Pete

Surprisingly enough, Realtek's driver is quite x86-oriented. It uses
some ugly outb() functtions without any ioremap()'ping.

We tried to modify it to work for MIPS, but failed. There are some
hard-to-detect situations, when driver just cannot talk to the hardware,
probably due to transmit/receive buffer synchronization. But after some
period the connection is restored (reset?). 

Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
