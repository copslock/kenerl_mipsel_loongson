Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 15:52:01 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:10150 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133639AbVLNPv0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2005 15:51:26 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jBEFpIvM017645;
	Wed, 14 Dec 2005 09:51:48 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 14 Dec 2005 09:51:38 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jBEFpbh5028177; Wed,
 14 Dec 2005 09:51:37 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id A90F1201E; Wed, 14 Dec 2005
 08:51:37 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jBEFrPIv021731; Wed, 14 Dec 2005 08:53:25
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jBEFrPUr021730; Wed, 14 Dec 2005 08:53:25
 -0700
Date:	Wed, 14 Dec 2005 08:53:25 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Rodolfo Giometti" <giometti@linux.it>
cc:	linux-mips@linux-mips.org
Subject: Re: ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20051214155324.GC9734@cosmic.amd.com>
References: <20051202190108.GF28227@cosmic.amd.com>
 <20051214134139.GN22061@hulk.enneenne.com>
MIME-Version: 1.0
In-Reply-To: <20051214134139.GN22061@hulk.enneenne.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBEE0004KG2208181-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 14/12/05 14:41 +0100, Rodolfo Giometti wrote:
> On Fri, Dec 02, 2005 at 12:01:08PM -0700, Jordan Crouse wrote:
> > Add SD support to the AU1200 MMC driver.  This can
> > be added post 2.6.15, I'm just sending them out today so the various
> > maintainers can get them queued up. 
> 
> According to AMD Application Note titled "MultiMediaCard Support Using
> the AMD Alchemy Au1200 and Au1100 Processors" I'd like to test your
> driver on my Au1100 based board.
> 
> Can you please told me the Linux kernel version where the patch apply
> to?

The patch should apply to the most recent linux-mips git (at least as
of Wednesday morning).  

> Do you think there should be some issue to keep in consideration
> regarding the Au1100?

Well, hopefully everything will Just Work (TM), but you'll want to make
sure that all the various definitions are enabled for the AU1100.  I'll
have to give you my standard disclaimer that I haven't compiled this
for anything but a DB1200 and PB1200, so I can't promise that it will work,
but there is nothing in the code that says it won't.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
