Received:  by oss.sgi.com id <S553953AbRA1CzY>;
	Sat, 27 Jan 2001 18:55:24 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:54278 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553952AbRA1CzK>;
	Sat, 27 Jan 2001 18:55:10 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08851
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870781AbRA0TWE>; Sat, 27 Jan 2001 11:22:04 -0800
Date: 	Sat, 27 Jan 2001 11:22:04 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Michael Shmulevich <michaels@jungo.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010127112204.J867@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A712D90.3CC9EBAF@jungo.com>; from michaels@jungo.com on Fri, Jan 26, 2001 at 09:56:00AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 09:56:00AM +0200, Michael Shmulevich wrote:
> Date:   Fri, 26 Jan 2001 09:56:00 +0200
> From: Michael Shmulevich <michaels@jungo.com>
> CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
> Subject: Re: MIPS/linux compatible PCI network cards
> To: unlisted-recipients:; (no To-header on input)
> 
> Pete Popov wrote:
> > 
> > 
> > Another one is the RTL8139.  It's quite cheap (I think less than $20).
> > 
> > Pete
> 
> Surprisingly enough, Realtek's driver is quite x86-oriented. It uses
> some ugly outb() functtions without any ioremap()'ping.

inb() and friends are for what Inhell calls I/O space.  Ioremap is for
memory mapped I/O.  So you usually don't find both of them in the same
driver.

  Ralf
