Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 20:18:19 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:40614 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133414AbWBQUSI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 20:18:08 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1HKKiwL017551;
	Fri, 17 Feb 2006 12:24:41 -0800
Received: from 139.95.53.182 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 17 Feb 2006 12:03:18 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Fri, 17 Feb 2006 12:03:13 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E9E492028; Fri, 17 Feb 2006
 13:03:12 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1HK9jJ3032177; Fri, 17 Feb 2006 13:09:45
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1HK9ihp032176; Fri, 17 Feb 2006 13:09:44
 -0700
Date:	Fri, 17 Feb 2006 13:09:44 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
cc:	linux-mips@linux-mips.org
Subject: Re: replaced io_remap_page_range() with io_remap_pfn_range()
Message-ID: <20060217200944.GF30429@cosmic.amd.com>
References: <20060217145352.GD14066@dusktilldawn.nl>
 <20060217173448.GB30429@cosmic.amd.com>
 <20060217183155.GH14066@dusktilldawn.nl>
MIME-Version: 1.0
In-Reply-To: <20060217183155.GH14066@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Feb 2006 20:03:13.0814 (UTC)
 FILETIME=[2F314B60:01C633FD]
X-WSS-ID: 6FE8F4701V0320899-04-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 17/02/06 19:31 +0100, Freddy Spierenburg wrote:
 
> I now think I covered it all, or am I still missing something?
> Anyway, I did not find the problem fixed in any of these
> repositories or tarballs so hence I shall send the patch to
> Antonino Daplas later tonight or tomorrow.

Well, won't hurt, but don't be surprised if he says its fixed.  I'm
looking at the lmo tree right now, and its very definately fixed at
au1200fb.c:1280.  Either way, thanks for the patch.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
