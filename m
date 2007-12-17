Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 21:45:20 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:194 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20034152AbXLQVpK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 21:45:10 +0000
Received: from lagash (88-106-143-223.dynamic.dsl.as9105.com [88.106.143.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 1B380481E5;
	Mon, 17 Dec 2007 22:45:04 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1J4Nln-00081z-C4; Mon, 17 Dec 2007 21:45:03 +0000
Date:	Mon, 17 Dec 2007 21:45:03 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	"Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:	linux-mips@linux-mips.org
Subject: Re: [OT?] is there something strange about __builtin_ffs these
	days?
Message-ID: <20071217214503.GB17397@networkno.de>
References: <alpine.LFD.0.9999.0712171602090.13289@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712171602090.13289@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Robert P. J. Day wrote:
> 
>   i'm hoping i'm not abusing this list overly by asking for some help
> with debugging an OpenWRT issue.  the trac ticket is here:
> 
> https://dev.openwrt.org/ticket/2735
> 
> and involves cross-compiling an image for the MIPS-based linksys
> WRT54GL router.  i've verified that this error still exists in the
> latest svn update of openwrt and, in a nutshell, it involves the claim
> that "__builtin_ffs" is undefined:
> 
> ...
>  CC [M]  /home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.o
> /home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.c:538:5:
>   warning: "__builtin_ffs" is not defined
> /home/openwrt/builds/trunk_brcm47xx/build_dir/linux-brcm47xx/spca5xx-le/spca_core.c:538:5:
>   error: missing binary operator before token "("
> ...
> 
>   that line in the source file is simply:
> 
>    #if PUD_SHIFT
> 
> i have no idea what the problem is here and, as you can see from the
> trac ticket, this seems to have started because of the kernel version
> upgrade from 2.6.22 to 2.6.23.  but what about that would affect the
> usage of __builtin_ffs?
> 
>   does anyone have an idea why something this basic might be going
> wrong now?  any suggestions appreciated.  thanks.

The compiler should never attempt to use __builtin_ffs by itself, because
the kernel makefile adds -ffreestanding to CFLAGS. So either your compiler
is broken, or the makefile of your kernel tree is incorrect, or somewhere
in your kernel tree there's a explicit call to __builtin_ffs (which is
also incorrect, as the compiler may invoke library functions to implement
it.)


Thiemo
