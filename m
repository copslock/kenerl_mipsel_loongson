Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 19:14:51 +0000 (GMT)
Received: from e31.co.us.ibm.com ([IPv6:::ffff:32.97.110.129]:35761 "EHLO
	e31.co.us.ibm.com") by linux-mips.org with ESMTP
	id <S8225428AbVAGTOo>; Fri, 7 Jan 2005 19:14:44 +0000
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j07JEbm4072838;
	Fri, 7 Jan 2005 14:14:37 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j07JEbr8433536;
	Fri, 7 Jan 2005 12:14:37 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j07JEaEC013304;
	Fri, 7 Jan 2005 12:14:36 -0700
Received: from echidna.beaverton.ibm.com (echidna.beaverton.ibm.com [9.47.21.82])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j07JEZb1013251;
	Fri, 7 Jan 2005 12:14:36 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1CmzZ8-7pI-00; Fri, 07 Jan 2005 11:14:30 -0800
Date: Fri, 7 Jan 2005 11:14:30 -0800
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050107191430.GC30051@kroah.com>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com> <20050106194646.GB5481@kroah.com> <20050107091218.GA3715@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107091218.GA3715@orphique>
User-Agent: Mutt/1.5.6i
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Fri, Jan 07, 2005 at 10:12:19AM +0100, Ladislav Michl wrote:
> On Thu, Jan 06, 2005 at 11:46:46AM -0800, Greg KH wrote:
> > Ok, can someone send me the proper patch then?
> 
> Index: drivers/i2c/algos/Kconfig

Applied, thanks.

greg k-h
