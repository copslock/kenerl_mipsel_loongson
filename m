Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 15:10:05 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:64657 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20029582AbYETOKD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2008 15:10:03 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id F0DFB5BC057;
	Tue, 20 May 2008 17:10:00 +0300 (EEST)
Date:	Tue, 20 May 2008 17:07:52 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	"Robert P. J. Day" <rpjday@crashcourse.ca>,
	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: references from Makefiles to non-existent CONFIG variables
Message-ID: <20080520140752.GA31216@cs181133002.pp.htv.fi>
References: <alpine.LFD.1.10.0805171641190.14930@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805171641190.14930@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Sat, May 17, 2008 at 04:45:58PM -0400, Robert P. J. Day wrote:
> 
>   here's the current, unadulterated list of references from Makefiles
> to CONFIG variables that are not defined in any Kconfig file.  once
> again, enjoy.
>...
> ===== MSPETH =====
> ./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_MSPETH) += msp_eth.o
>...

This PMC MSP71xx platform in the kernel was AFAIR never in a usable 
state (read: even compilation fails).

Marc, will you (or anyone else) bring it into shape or should I send a 
patch removing it?

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
