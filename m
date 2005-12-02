Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 21:08:21 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:21658 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133539AbVLBVH7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 21:07:59 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB2LBCqU017942;
	Fri, 2 Dec 2005 13:11:13 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Dec 2005 13:09:22 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB2L9LQe028963; Fri, 2
 Dec 2005 13:09:21 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 106FC2026; Fri, 2 Dec 2005
 14:09:21 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB2LH96p000345; Fri, 2 Dec 2005 14:17:09
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB2LH9Uo000344; Fri, 2 Dec 2005 14:17:09 -0700
Date:	Fri, 2 Dec 2005 14:17:09 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Pierre Ossman" <drzeus@drzeus.cx>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Russell King" <rmk+lkml@arm.linux.org.uk>
Subject: Re: ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20051202211709.GL28227@cosmic.amd.com>
References: <20051202190108.GF28227@cosmic.amd.com>
 <4390A38A.1010907@drzeus.cx>
MIME-Version: 1.0
In-Reply-To: <4390A38A.1010907@drzeus.cx>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8E67881IW1481965-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 02/12/05 20:42 +0100, Pierre Ossman wrote:
> Jordan Crouse wrote:
> > @@ -196,7 +207,11 @@ static int au1xmmc_send_command(struct a
> >  
> >  	switch(cmd->flags) {
> >  	case MMC_RSP_R1:
> > -		mmccmd |= SD_CMD_RT_1;
> > +		if (cmd->opcode == 0x03 && host->mmc->mode == MMC_MODE_SD)
> > +			mmccmd |= SD_CMD_RT_6;
> > +		else
> > +			mmccmd |= SD_CMD_RT_1;
> > +
> >  		break;
> >  	case MMC_RSP_R1B:
> >  		mmccmd |= SD_CMD_RT_1B;
> 
> No, no, no! Even if this wasn't already fixed in the current kernel you
> never hack around bugs in other parts of the kernel, you fix them!

As of a git pull about 30 minutes ago, both MMC_RSP_R1 and MMC_RSP_R6 resolve
to (MMC_RSP_SHORT|MMC_RSP_CRC).  Now, I really wouldn't call that a 
bug in the subsystem, because it is technically correct, but the Au1200
needs us to specifically specify if the required response is an R1 or
an R6, thus the specified logic.  

Jordan
--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
