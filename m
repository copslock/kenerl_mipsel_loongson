Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 17:12:13 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:48015 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133714AbWBQRME (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 17:12:04 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1HHIa4Z022821;
	Fri, 17 Feb 2006 09:18:38 -0800
Received: from 139.95.53.182 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 17 Feb 2006 09:18:18 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Fri, 17 Feb 2006 09:18:18 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id B83222030; Fri, 17 Feb 2006
 10:18:17 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1HHOmgM030541; Fri, 17 Feb 2006 10:24:48
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1HHOluY030540; Fri, 17 Feb 2006 10:24:47
 -0700
Date:	Fri, 17 Feb 2006 10:24:47 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
cc:	linux-mips@linux-mips.org
Subject: Re: Small time UART configuration fix for AU1100 processor
Message-ID: <20060217172447.GA30429@cosmic.amd.com>
References: <20060217145406.GE14066@dusktilldawn.nl>
MIME-Version: 1.0
In-Reply-To: <20060217145406.GE14066@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Feb 2006 17:18:18.0653 (UTC)
 FILETIME=[25378CD0:01C633E6]
X-WSS-ID: 6FE8DAD02W4253210-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> The AU1100 processor does not have an internal UART2. Only
> UART0, UART1 and UART3 exist. This patch removes the non existing
> UART2 and replaces it with a descriptive comment.

Thanks.  I think that Ralf already told you to send it to Russell King,
but I'll toss it in my tree as well, in case he doesn't get it.

The comment probably isn't required, though - just remove it.

I know this is a stupid question for an AMD employee to ask, but since
I've only been associated with the AU1200, and to a limited extent the AU1550,
do *ANY* of our boards have an UART2 on them?

Jordan
