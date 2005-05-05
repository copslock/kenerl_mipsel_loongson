Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 23:47:16 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:22442
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225254AbVEEWrC>; Thu, 5 May 2005 23:47:02 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 5 May 2005 22:46:58 -0000
Subject: Re: pcmcia-cs package for linux-mips 2.6.10?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	"'linux-pcmcia@lists.infradead.org'" 
	<linux-pcmcia@lists.infradead.org>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259024380C7@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
References: <9DFF23E1E33391449FDC324526D1F259024380C7@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 05 May 2005 15:46:53 -0700
Message-Id: <1115333213.5820.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-05-05 at 15:43 -0700, Kiran Thota wrote:
> 
> I have downloaded pcmcia-cs package v3.2.8 [David Hinds] from sourceforge.
> The  Configure file doesnt have anything for MIPS. I tweaked Configure
> and config.mk step-by-step and could get cardmgr/ to compile but wasnt
> successful with clients/
> 
> Is there any patch for MIPS? linux-mips 2.6.10 to be specific? Can you point
> me to its porting to MIPS?

Use the in-kernel client drivers instead. All you need from the pcmcia-
cs package is the userland utilities.

Pete
