Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:49:09 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:45073 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAPPsq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 15:48:46 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C49D264D55; Mon, 16 Jan 2006 15:52:17 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2CD958517; Mon, 16 Jan 2006 15:52:08 +0000 (GMT)
Date:	Mon, 16 Jan 2006 15:52:08 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: make meth eht0 on IP32
Message-ID: <20060116155208.GD26771@deprecation.cyrius.com>
References: <41E582A0.1050407@total-knowledge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E582A0.1050407@total-knowledge.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ilya A. Volynets-Evenbakh <ilya@total-knowledge.com> [2005-01-12 12:03]:
> meth is built-in ethernet card on O2, and it would make sense for it to be
> eth0, even if there is also another network card in PCI slot.

This sounds like a good idea to me.  Can this patch be applied?

>    Ilya.
> 
> Index: drivers/net/Makefile
> ===================================================================
> RCS file: /home/cvs/linux/drivers/net/Makefile,v
> retrieving revision 1.107
> diff -u -r1.107 Makefile
> --- drivers/net/Makefile        15 Nov 2004 11:49:28 -0000      1.107
> +++ drivers/net/Makefile        12 Jan 2005 19:58:47 -0000
> @@ -28,6 +28,8 @@
> obj-$(CONFIG_MYRI_SBUS) += myri_sbus.o
> obj-$(CONFIG_SUNGEM) += sungem.o sungem_phy.o
> 
> +obj-$(CONFIG_SGI_O2MACE_ETH) += meth.o
> +
> obj-$(CONFIG_MACE) += mace.o
> obj-$(CONFIG_BMAC) += bmac.o
> 
> @@ -125,7 +127,6 @@
> obj-$(CONFIG_SUN3LANCE) += sun3lance.o
> obj-$(CONFIG_DEFXX) += defxx.o
> obj-$(CONFIG_SGISEEQ) += sgiseeq.o
> -obj-$(CONFIG_SGI_O2MACE_ETH) += meth.o
> obj-$(CONFIG_AT1700) += at1700.o
> obj-$(CONFIG_FMV18X) += fmv18x.o
> obj-$(CONFIG_EL1) += 3c501.o
> 

-- 
Martin Michlmayr
http://www.cyrius.com/
