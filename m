Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 12:28:39 +0000 (GMT)
Received: from p508B765F.dip.t-dialin.net ([IPv6:::ffff:80.139.118.95]:9027
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224908AbUAVM2j>; Thu, 22 Jan 2004 12:28:39 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0MCSaex013114;
	Thu, 22 Jan 2004 13:28:36 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0MCSXZq013113;
	Thu, 22 Jan 2004 13:28:33 +0100
Date: Thu, 22 Jan 2004 13:28:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jun Sun <jsun@mvista.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] set up conswitchp when CONFIG_VT is set
Message-ID: <20040122122832.GA4482@linux-mips.org>
References: <20040121162032.F29705@mvista.com> <Pine.GSO.4.58.0401221052100.1408@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401221052100.1408@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 22, 2004 at 10:52:59AM +0100, Geert Uytterhoeven wrote:

> | +#ifdef CONFIG_VT
> | +#if defined(CONFIG_VGA_CONSOLE)
> | +        conswitchp = &vga_con;
> | +#elif defined(CONFIG_DUMMY_CONSOLE)
> | +        conswitchp = &dummy_con;
> | +#endif
> | +#endif
> 
> Isn't the #ifdef CONFIG_VT superfluous?

No; if CONFIG_VT is undefined conswitchp is undefined also; DUMMY_CONSOLE
however is still selectable if CONFIG_VT is off so there could be
unsatisfied references to consitchp.

  ralf
