Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 15:29:17 +0100 (BST)
Received: from amdext4.amd.com ([163.181.251.6]:1973 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133712AbWEBO3G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 15:29:06 +0100
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k42ER2nU001594;
	Tue, 2 May 2006 09:29:28 -0500
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 02 May 2006 09:28:47 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Tue, 2 May 2006 09:28:47 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id C59F42028; Tue, 2 May 2006
 08:28:46 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k42EhE2r019166; Tue, 2 May 2006 08:43:14
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k42EhET4019165; Tue, 2 May 2006 08:43:14 -0600
Date:	Tue, 2 May 2006 08:43:14 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Wolfgang Ocker" <weo@reccoware.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Au1200 MMC/SD problem
Message-ID: <20060502144314.GI22167@cosmic.amd.com>
References: <1146548770.1597.43.camel@seneca.recco.de>
MIME-Version: 1.0
In-Reply-To: <1146548770.1597.43.camel@seneca.recco.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 May 2006 14:28:47.0484 (UTC)
 FILETIME=[B94BD3C0:01C66DF4]
X-WSS-ID: 6849B3154IS4797242-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 02/05/06 07:46 +0200, Wolfgang Ocker wrote:
> Hello,
> 
> I'm trying to get a SD card to work on an Db1200 board. I'm using kernel
> 2.6.16.11 (+ the patch from Jordan Crouse):

Thats not an encouraging sign.

> au1xx(0): DEBUG: set_ios (power=2, clock=450000Hz, vdd=15, mode=2)
> MMC: starting cmd 09 arg e0080000 flags 00000007
> MMC: req done (09): 1: 00000000 00000000 00000000 00000000
> MMC: req done (09): 1: 00000000 00000000 00000000 00000000
> MMC: req done (09): 1: 00000000 00000000 00000000 00000000
> MMC: req done (09): 1: 00000000 00000000 00000000 00000000

Ok - so the reasons for cmd->error to be MMC_ERR_TIMEOUT are:

  * invalid return from dma_map_sg in au1xmmc_prepare_data 
  * general error from the DBDMA engine
  * one of SD_STATUS_RAT sent when the IRQ fires

So to narrow it down - check the return value of au1xmmc_prepare_data
in au1xmmc_request.  Then, see if RAT is ever set in au1xmmc_irq.   This
will help narrow down the problem.  

Also, the usual general questions:
What SD card are you using?  How big is it?  Is it a v1.01 or a v1.1 card?

Jordan
