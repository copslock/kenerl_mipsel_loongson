Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 15:44:02 +0100 (BST)
Received: from amdext3.amd.com ([139.95.251.6]:61841 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S7620188AbWECOnu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 May 2006 15:43:50 +0100
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k43EhQcE022418;
	Wed, 3 May 2006 07:44:27 -0700
Received: from 139.95.53.182 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 03 May 2006 07:43:33 -0700
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Wed, 3 May 2006 07:43:33 -0700
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E66FD2028; Wed, 3 May 2006
 08:43:32 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k43ExRam003142; Wed, 3 May 2006 08:59:27
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k43ExRx8003141; Wed, 3 May 2006 08:59:27 -0600
Date:	Wed, 3 May 2006 08:59:27 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Wolfgang Ocker" <weo@reccoware.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Au1200 MMC/SD problem
Message-ID: <20060503145927.GD24185@cosmic.amd.com>
References: <1146548770.1597.43.camel@seneca.recco.de>
 <20060502144314.GI22167@cosmic.amd.com>
 <1146592926.11188.12.camel@seneca.recco.de>
MIME-Version: 1.0
In-Reply-To: <1146592926.11188.12.camel@seneca.recco.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 03 May 2006 14:43:33.0502 (UTC)
 FILETIME=[F3D131E0:01C66EBF]
X-WSS-ID: 68461E1F32W5755790-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> The last one. In au1xmmc_irq() the status register is read with the
> SD_STATUS_RAT bit set.

Ok - so the card is timing out.  That could be a series of problems, some
of which could be hardware, some of which could be software.  Since you are
using a db1200, I'll rule out hardware for the moment, unless you have a
modified board.

Do MMC cards work?  Try one - that will give us another data point.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
