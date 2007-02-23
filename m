Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 20:39:29 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:15863 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039036AbXBWUjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 20:39:25 +0000
Received: (qmail 23852 invoked by uid 101); 23 Feb 2007 20:38:17 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 23 Feb 2007 20:38:17 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1NKcGpT030538;
	Fri, 23 Feb 2007 12:38:16 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPBPQF>; Fri, 23 Feb 2007 12:38:16 -0800
Message-ID: <45DF50AE.8090102@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] mtd: PMC MSP71xx flash/rootfs mappings
Date:	Fri, 23 Feb 2007 12:38:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 23 Feb 2007 20:38:06.0739 (UTC) FILETIME=[85ED8E30:01C7578A]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Sergei,

I was trying to get some feedback on the set as a whole before submitting
the subsystem parts to separate maintainers. Theory being that changes
to the platform code may force changes to the subsystems and I'd avoid
unnecessary churn to those non-MIPS maintainers.

Marc

Sergei Shtylyov wrote:
> Hello.
> 
> Marc St-Jean wrote:
>  > [PATCH 5/5] mtd: PMC MSP71xx flash/rootfs mappings
> 
>  > Patch to add flash and rootfs mappings for the PMC-Sierra
>  > MSP71xx devices.
> 
>  > These 5 patches along with the previously posted serial patch
>  > will boot the PMC-Sierra MSP7120 Residential Gateway board.
> 
>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>  > ---
>  >  Kconfig          |   31 +++++++++
>  >  Makefile         |    2
>  >  pmcmsp-flash.c   |  180 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  >  pmcmsp-ramroot.c |  106 ++++++++++++++++++++++++++++++++
>  >  4 files changed, 319 insertions(+)
> 
>     This patch surely belongs to linux-mtd@lists.infradead.org
> 
> WBR, Sergei
> 
