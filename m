Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 16:03:16 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:61364 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S3458492AbWBFQDD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2006 16:03:03 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k16G8VBC029219;
	Mon, 6 Feb 2006 08:08:31 -0800
Received: from 139.95.53.182 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 06 Feb 2006 07:21:41 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Mon, 6 Feb 2006 07:21:41 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id DD9292028; Mon, 6 Feb 2006
 08:21:40 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k16FPIwD010716; Mon, 6 Feb 2006 08:25:18
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k16FPHoS010715; Mon, 6 Feb 2006 08:25:17 -0700
Date:	Mon, 6 Feb 2006 08:25:17 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"David Sanchez" <david.sanchez@lexbox.fr>
cc:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Au1xx0: really set KSEG0 to uncached on reboot
Message-ID: <20060206152516.GA10615@cosmic.amd.com>
References: <17AB476A04B7C842887E0EB1F268111E027447@xpserver.intra.lexbox.org>
MIME-Version: 1.0
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E027447@xpserver.intra.lexbox.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Feb 2006 15:21:41.0536 (UTC)
 FILETIME=[0810FA00:01C62B31]
X-WSS-ID: 6FF9B60F1HW6107711-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/02/06 09:10 +0100, David Sanchez wrote:
> Hi,
> 
> This is exactly what I did...
> But I notice that sometimes it works and sometimes the kernel frees when 
> "** Resetting Integrated Peripherals"

We'll need to nail this down before we go any further.  Can we get a trace
of what happens when it crashes?

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
