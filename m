Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2012 08:45:50 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57787 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903792Ab2F1Gpn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2012 08:45:43 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from ecaz (gprs4f7a4595.pool.t-umts.hu [79.122.69.149])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1622123C0208;
        Thu, 28 Jun 2012 08:45:38 +0200 (CEST)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     linux-mips@linux-mips.org, "Florian Fainelli" <florian@openwrt.org>
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: Re: [PATCH 05/33] MIPS: AR7: Cleanup files effected by firmware
 changes.
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
 <1340685708-14408-6-git-send-email-sjhill@mips.com> <2501952.67ymQ30y5z@flexo>
Date:   Thu, 28 Jun 2012 08:45:35 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Imre Kaloz" <kaloz@openwrt.org>
Organization: OpenWrt
Message-ID: <op.wglo19ee2s3iss@ecaz>
In-Reply-To: <2501952.67ymQ30y5z@flexo>
X-archive-position: 33863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 26 Jun 2012 16:29:08 +0200, Florian Fainelli <florian@openwrt.org>  
wrote:

> On Monday 25 June 2012 23:41:20 Steven J. Hill wrote:
>> From: "Steven J. Hill" <sjhill@mips.com>
>>
>> Make headers consistent across the files and make changes based on
>> running the checkpatch script.
>>
>> Signed-off-by: Steven J. Hill <sjhill@mips.com>
>> ---
>>  arch/mips/ar7/memory.c   |   18 ++++------------
>>  arch/mips/ar7/platform.c |   53
> ++++++++++++++++++----------------------------
> [snip]
>>   */
>>  #include <linux/bootmem.h>
>>  #include <linux/init.h>
>> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
>> index 284b86a..921e42c 100644
>> --- a/arch/mips/ar7/platform.c
>> +++ b/arch/mips/ar7/platform.c
>> @@ -1,22 +1,12 @@
>>  /*
>> + * This file is subject to the terms and conditions of the GNU General
> Public
>> + * License.  See the file "COPYING" in the main directory of this  
>> archive
>> + * for more details.
>> + *
>>   * Copyright (C) 2006,2007 Felix Fietkau <nbd@openwrt.org>
>>   * Copyright (C) 2006,2007 Eugene Konev <ejka@openwrt.org>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA   
>> 02110-1301
> USA
>> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>
> You are adding MTI's Copyright back here, which I assume is a left-over  
> from
> your first submission.

I don't even see a reason to touch said headers. Specially because with  
some files you are actually changing the license (in this case, GPLv2+ ->  
GPLv2), which is leagally wrong. In other cases your change "only" removes  
the GPL version number, which can cause issues if the file will be moved  
out.

So in files under my copyright, NAK.


Imre
