Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 03:30:21 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:54824 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492152Ab0ELBaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 May 2010 03:30:18 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id o4C1U9Xi030092;
        Tue, 11 May 2010 18:30:09 -0700
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 11 May 2010 18:29:26 -0700
Message-ID: <4BEA04A1.5030207@mips.com>
Date:   Tue, 11 May 2010 18:30:09 -0700
From:   Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix abs.[sd] and neg.[sd] emulation for NaN operands
References: <20091012215718.30362.67068.stgit@localhost.localdomain>    <20100510.234946.229279777.anemo@mba.ocn.ne.jp> <4BE85256.9010709@mips.com> <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
In-Reply-To: <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2010 01:29:26.0298 (UTC) FILETIME=[8F1B57A0:01CAF172]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 
> ieee754d/sp_nanxcpt will set the invalid exception bit if its first
> argument was a signaling NaN.  And ieee754dp/sp_indef() is a quiet
> NaN.

You're right! I'll send a separate patch with an appropriate subject to 
correct this.

Thanks
Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
