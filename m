Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 11:50:52 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:38922 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225321AbVCCLuh>; Thu, 3 Mar 2005 11:50:37 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j23BoKDP011397;
	Thu, 3 Mar 2005 11:50:20 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j23BoKDG011396;
	Thu, 3 Mar 2005 11:50:20 GMT
Date:	Thu, 3 Mar 2005 11:50:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sparse and mips
Message-ID: <20050303115020.GB10556@linux-mips.org>
References: <422256A3.2030407@amsat.org> <4223240C.4010207@amsat.org> <20050303104654.GB5457@linux-mips.org> <200503031238.38363.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503031238.38363.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 03, 2005 at 12:38:38PM +0100, Ulrich Eckhardt wrote:

> Ralf Baechle wrote:
> > CHECKFLAGS-$(CONFIG_CPU_BIG_ENDIAN)     += -D__MIPSEL__
> > CHECKFLAGS-$(CONFIG_CPU_LITTLE_ENDIAN)  += -D__MIPSEL__
> 
> typo? ;)

Guess I've been assimilated ;)

  Ralf
