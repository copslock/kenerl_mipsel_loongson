Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 21:25:18 +0000 (GMT)
Received: from e6.ny.us.ibm.com ([IPv6:::ffff:32.97.182.146]:40147 "EHLO
	e6.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8225348AbVAFVZM>;
	Thu, 6 Jan 2005 21:25:12 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j06LP6gg023088;
	Thu, 6 Jan 2005 16:25:06 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j06LP615275568;
	Thu, 6 Jan 2005 16:25:06 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j06LP530021843;
	Thu, 6 Jan 2005 16:25:06 -0500
Received: from echidna.beaverton.ibm.com (echidna.beaverton.ibm.com [9.47.21.82])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j06LP5iD021720;
	Thu, 6 Jan 2005 16:25:05 -0500
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1Cmdao-1jK-00; Thu, 06 Jan 2005 11:46:46 -0800
Date: Thu, 6 Jan 2005 11:46:46 -0800
From: Greg KH <greg@kroah.com>
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Ladislav Michl <ladis@linux-mips.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050106194646.GB5481@kroah.com>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DD9313.4030105@total-knowledge.com>
User-Agent: Mutt/1.5.6i
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 06, 2005 at 11:35:47AM -0800, Ilya A. Volynets-Evenbakh wrote:
> Ralf Baechle wrote:
> 
> >On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:
> >
> > 
> >
> >>There's no reason for offering a MIPS-only driver on other architectures 
> >>(even though it does compile).
> >>
> >>Even better dependencies on specific MIPS variables might be possible 
> >>that obsolete this patch, but this patch fixes at least the !MIPS case.
> >>   
> >>
> >
> >Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
> >actually using it.
> >
> >Ladis, is VisWS using this algo also?
> > 
> >
> Since MACE is common part, it most likely does.

Ok, can someone send me the proper patch then?

thanks,

greg k-h
