Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 09:23:22 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:65514 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225228AbUARJXV>;
	Sun, 18 Jan 2004 09:23:21 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0I9NKw1000626
	for <linux-mips@linux-mips.org>; Sun, 18 Jan 2004 10:23:20 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id KAA22075
	for linux-mips@linux-mips.org; Sun, 18 Jan 2004 10:23:19 +0100 (MET)
Date: Sun, 18 Jan 2004 10:23:19 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: linux-mips@linux-mips.org
Subject: Re: VR4131 - MQ1132 - UPD63335
Message-ID: <20040118092318.GA22052@sonycom.com>
References: <40079391.7080301@mistralsoftware.com> <20040117122022.GD5288@linux-mips.org> <20040117125142.GX14285@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117125142.GX14285@lug-owl.de>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 17, 2004 at 01:51:42PM +0100, Jan-Benedict Glaw wrote:
> On Sat, 2004-01-17 13:20:22 +0100, Ralf Baechle <ralf@linux-mips.org>
> wrote in message <20040117122022.GD5288@linux-mips.org>:
> > #define FOO_BASE	0x12340000UL		/* physical address */
>                         ^^^^^^^^^^
> > #define FOO_SIZE	0x00001000UL
> > 
> > 	base = ioremap(0x1234, FOO_SIZE);
>                        ^^^^^^
> Not FOO_BASE?
> 

And it's better to use writel/readl and friends on thingies returned by
ioremap:

      struct foo_regs* foo = ioremap(FOO_BASE, FOO_SIZE);
      ...      
      writel(42, &foo->blinkenlight);


Dimitri


-- 
Dimitri Torfs       |  NSCE 
dimitri@sonycom.com |  The Corporate Village
tel: +32 2 7008541  |  Da Vincilaan 7 - D1 
fax: +32 2 7008622  |  B-1935 Zaventem - Belgium
