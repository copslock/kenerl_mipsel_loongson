Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 17:22:09 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:4497 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133716AbWBQRWA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 17:22:00 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1HHPxHV024242;
	Fri, 17 Feb 2006 09:28:35 -0800
Received: from 139.95.53.182 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 17 Feb 2006 09:28:20 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Fri, 17 Feb 2006 09:28:19 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id CEC54202D; Fri, 17 Feb 2006
 10:28:18 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1HHYnKl030661; Fri, 17 Feb 2006 10:34:49
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1HHYmXt030660; Fri, 17 Feb 2006 10:34:48
 -0700
Date:	Fri, 17 Feb 2006 10:34:48 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
cc:	linux-mips@linux-mips.org
Subject: Re: replaced io_remap_page_range() with io_remap_pfn_range()
Message-ID: <20060217173448.GB30429@cosmic.amd.com>
References: <20060217145352.GD14066@dusktilldawn.nl>
MIME-Version: 1.0
In-Reply-To: <20060217145352.GD14066@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Feb 2006 17:28:20.0216 (UTC)
 FILETIME=[8BC6C780:01C633E7]
X-WSS-ID: 6FE8D83E2W4256147-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

I do believe that this fix is already upstream.  Are you playing
with the latest kernel?

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
