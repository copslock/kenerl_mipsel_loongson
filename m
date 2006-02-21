Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 15:05:49 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:36790 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133422AbWBUPFi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2006 15:05:38 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1LFCQSE026500;
	Tue, 21 Feb 2006 09:12:36 -0600
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 21 Feb 2006 09:12:22 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Tue, 21 Feb 2006 07:12:22 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 9C3CD202D; Tue, 21 Feb 2006
 08:12:21 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1LFJrN5018238; Tue, 21 Feb 2006 08:19:53
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1LFJqjo018237; Tue, 21 Feb 2006 08:19:52
 -0700
Date:	Tue, 21 Feb 2006 08:19:52 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	"Domen Puncer" <domen.puncer@ultra.si>, linux-mips@linux-mips.org
Subject: Re: au1xmmc: fix mmc_rsp_type typo
Message-ID: <20060221151952.GU30429@cosmic.amd.com>
References: <20060221093834.GA5120@domen.ultra.si>
 <20060221104619.GD5120@domen.ultra.si>
 <20060221123416.GA3718@linux-mips.org>
MIME-Version: 1.0
In-Reply-To: <20060221123416.GA3718@linux-mips.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 21 Feb 2006 15:12:22.0419 (UTC)
 FILETIME=[3700BE30:01C636F9]
X-WSS-ID: 6FE5F25C3101292896-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> > > Patch that added this suggests mmc_rsp_type should be mmc_resp_type.
> > 
> > Ouch, I thought I compile tested.
> > Here's a fixed version:
> 
> Jordan?

Looks good to me.  Thanks Domen.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
