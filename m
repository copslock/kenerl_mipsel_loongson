Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 23:57:19 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:18298
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224933AbVBCX5E>; Thu, 3 Feb 2005 23:57:04 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13Nv2ak023286;
	Fri, 4 Feb 2005 00:57:02 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13Nv2SZ023285;
	Fri, 4 Feb 2005 00:57:02 +0100
Date:	Fri, 4 Feb 2005 00:57:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix Kconfig for Broadcom SWARM
Message-ID: <20050203235702.GA22311@linux-mips.org>
References: <20050201202835.GA10788@prometheus.mvista.com> <20050203142919.GB9796@linux-mips.org> <4202611A.4000302@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202611A.4000302@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 03, 2005 at 09:36:26AM -0800, Manish Lachwani wrote:

> The problem is that SIBYTE_SB1xxx_SOC is undefined. We need a small 
> change in arch/mips/sibyte/Kconfig:
> 
> config SIBYTE_SB1xxx_SOC
>        bool "Support for Broadcom BCM1xxx SOCs "
> 
> Since the ethernet driver, the serial driver and the CFE depend on this 
> option to be selected else they wont be compiled in.

The fix for this is already in CVS since a few hours.

  Ralf
