Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 15:47:05 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:58091
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225214AbTBGPrE>; Fri, 7 Feb 2003 15:47:04 +0000
Received: from bogon.sigxcpu.org (unknown [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id BA0472BC2D
	for <linux-mips@linux-mips.org>; Fri,  7 Feb 2003 16:47:02 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 5A8394AF4C; Fri,  7 Feb 2003 16:45:39 +0100 (CET)
Date: Fri, 7 Feb 2003 16:45:39 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Endianity problems in XFree86-4.2 XAA on MIPSEB
Message-ID: <20030207154539.GA748@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <3E43ECC6.8090109@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E43ECC6.8090109@niisi.msk.ru>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 07, 2003 at 05:28:38PM +0000, Alexandr Andreev wrote:
> We have a MipsEB machine and a video card which has a 2D BitBLT engine.
It would help a lot if you'd tell us what card you're using. Some of the
drivers are more endian clean then others.
> It looks like we found a problem in XAA when we tried to use our hardware
> 8x8 Mono Pattern Fills. The problem appears when an application uses 
> pixmaps.
Did you have a look at the XAA.HOWTO at:
 xc/programs/Xserver/hw/xfree86/xaa
especially the
  BIT_ORDER_IN_BYTE_MSBFIRST
  BIT_ORDER_IN_BYTE_LSBFIRST
flags?
 --Guido
