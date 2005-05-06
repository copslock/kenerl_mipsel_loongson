Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 06:38:48 +0100 (BST)
Received: from isilmar.linta.de ([IPv6:::ffff:213.239.214.66]:1697 "EHLO
	linta.de") by linux-mips.org with ESMTP id <S8224831AbVEFFid>;
	Fri, 6 May 2005 06:38:33 +0100
Received: (qmail 25401 invoked by uid 1000); 6 May 2005 05:38:24 -0000
Date:	Fri, 6 May 2005 07:38:24 +0200
From:	Dominik Brodowski <linux@dominikbrodowski.net>
To:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
Cc:	"'ppopov@embeddedalley.com'" <ppopov@embeddedalley.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	"'linux-pcmcia@lists.infradead.org'" 
	<linux-pcmcia@lists.infradead.org>
Subject: Re: pcmcia-cs package for linux-mips 2.6.10?
Message-ID: <20050506053824.GA25388@isilmar.linta.de>
Mail-Followup-To: Kiran Thota <Kiran_Thota@pmc-sierra.com>,
	"'ppopov@embeddedalley.com'" <ppopov@embeddedalley.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	"'linux-pcmcia@lists.infradead.org'" <linux-pcmcia@lists.infradead.org>
References: <9DFF23E1E33391449FDC324526D1F259024380C8@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259024380C8@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.9i
Return-Path: <brodo@linta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

On Thu, May 05, 2005 at 04:32:02PM -0700, Kiran Thota wrote:
> I m trying to build memory_cs.o as a module.
> It aint available in kernel. What do i do?

It is replaced by pcmciamtd.

	Dominik
