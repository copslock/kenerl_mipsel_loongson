Received:  by oss.sgi.com id <S554189AbRBAVwR>;
	Thu, 1 Feb 2001 13:52:17 -0800
Received: from sovereign.org ([209.180.91.170]:683 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554180AbRBAVwB>;
	Thu, 1 Feb 2001 13:52:01 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f11Lq3X01790
	for linux-mips@oss.sgi.com; Thu, 1 Feb 2001 14:52:03 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Thu, 1 Feb 2001 14:52:03 -0700
To:     linux-mips@oss.sgi.com
Subject: Re: mips/CVS vs stock 2.4.1
Message-ID: <20010201145203.A1657@sovereign.org>
References: <20010201135347.A1164@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010201135347.A1164@sovereign.org>; from jfree@sovereign.org on Thu, Feb 01, 2001 at 01:53:47PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

In a merciful moment of remedial tutelage, Ilya kindly pointed out
that using   'cvs update -d'   would more properly sync my tree, thus
invalidating the first point of my previous e-mail.

  [ Apologies - publicly showing/rectifying one's ignorance may
    hurt the pride, but perhaps may be instructive to others ]

Someone may have as simple a fix for the dead/empty dirs in mips' CVS ?

...jfree
========
On Thu, Feb 01, 2001 at 01:53:47PM -0700, Jim Freeman wrote:
...
> Non-mips related directories mips has, but not present in stock 2.4.1
> (all empty, except for CVS-relate overhead - should be trimmed out of CVS?) :
> 
> 	Documentation/networking/ip_masq
> 	arch/arm/boot/tools
> 	arch/ia64/kdb
> 	arch/m68k/boot
> 	arch/m68k/console
> 	arch/ppc/kernel/include
> 	arch/sparc/ap1000
> 	drivers/char/hfmodem
> 	drivers/isdn/teles
> 	drivers/net/soundmodem
> 	drivers/sound/lowlevel
> 	drivers/usb/maps
> 	fs/ext
> 	fs/xiafs
> 	include/asm-arm/arch-a5k
> 	include/asm-arm/arch-vnc
> 	include/asm-sparc/ap1000
> 	net/netbeui
> 	scripts/usb
> 	net/irda/irlpt
> 	net/irda/irobex
