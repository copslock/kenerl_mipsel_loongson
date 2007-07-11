Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 00:06:50 +0100 (BST)
Received: from nic.NetDirect.CA ([216.16.235.2]:17823 "EHLO
	rubicon.netdirect.ca") by ftp.linux-mips.org with ESMTP
	id S20021977AbXGKXGs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 00:06:48 +0100
X-Originating-Ip: 72.143.66.27
Received: from [192.168.1.102] (CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com [72.143.66.27])
	(authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6BN5T6C001239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2007 19:05:37 -0400
Date:	Wed, 11 Jul 2007 19:03:45 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To:	Shane McDonald <mcdonald.shane@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: latest list of apparently "dead" CONFIG variables under arch/mips
In-Reply-To: <b2b2f2320707111546p5b7e1c6dv60a8d600a28634e7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0707111901110.28156@localhost.localdomain>
References: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain>
 <b2b2f2320707111546p5b7e1c6dv60a8d600a28634e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck:	not spam, SpamAssassin (not cached,
	score=-36.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, INIT_RECVD_OUR_AUTH -20.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Return-Path: <rpjday@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@mindspring.com
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Shane McDonald wrote:

> The following are not "just pure junk", as PMC-Sierra is working on
> providing acceptable code that supports their MSP71xx processors.
> Patches to remove these are not required!
>
> On 7/11/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> >
> > ========== PMCTWILED ==========
> > arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y
> > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED
> > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
> > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
> > arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED
> > ========== SQUASHFS ==========
> > arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y
> > arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
> > arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS
> > arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:            /* Get SQUASHFS
> > size */

i never *claimed* that they were junk, i was *asking* what was junk
since, typically, there's little value in testing preprocessor
variables if they aren't defined in a Kconfig file somewhere.  and if
something is not defined in a Kconfig file, it's generally a bad
choice to name it with a "CONFIG_" prefix.

in addition, i'm not sure what's going on with that SQUASHFS test,
since squashfs is not part of the kernel source tree, so what you're
testing for there is a mystery.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
