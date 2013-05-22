Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 23:55:48 +0200 (CEST)
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:16290
        "EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823056Ab3EVVzrWtA9l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 23:55:47 +0200
Received: from mail79-db8-R.bigfish.com (10.174.8.226) by
 DB8EHSOBE006.bigfish.com (10.174.4.69) with Microsoft SMTP Server id
 14.1.225.23; Wed, 22 May 2013 21:55:40 +0000
Received: from mail79-db8 (localhost [127.0.0.1])       by mail79-db8-R.bigfish.com
 (Postfix) with ESMTP id E245A4C02C2;   Wed, 22 May 2013 21:55:40 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.242.245;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0712HT003.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 4
X-BigFish: PS4(za62pzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail79-db8 (localhost.localdomain [127.0.0.1]) by mail79-db8
 (MessageSwitch) id 1369259738708156_19405; Wed, 22 May 2013 21:55:38 +0000
 (UTC)
Received: from DB8EHSMHS030.bigfish.com (unknown [10.174.8.230])        by
 mail79-db8.bigfish.com (Postfix) with ESMTP id 9CE3F400045;    Wed, 22 May 2013
 21:55:38 +0000 (UTC)
Received: from BL2PRD0712HT003.namprd07.prod.outlook.com (157.56.242.245) by
 DB8EHSMHS030.bigfish.com (10.174.4.40) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 22 May 2013 21:55:36 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.36) with Microsoft SMTP Server (TLS) id 14.16.311.1; Wed, 22 May
 2013 21:55:30 +0000
Message-ID: <519D3ED0.20703@caviumnetworks.com>
Date:   Wed, 22 May 2013 14:55:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] MIPS: OCTEON: Get rid of CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
References: <1369259204-29164-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369259204-29164-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 05/22/2013 02:46 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> When you turn it off, the kernel is unusable, so get rid of the option
> and always allow unaligned access.
>
> The Octeon specific memcpy intentionally does unaligned accesses and it
> must not fault.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   arch/mips/cavium-octeon/Kconfig                              | 11 -----------
>   arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h |  7 +------
>   2 files changed, 1 insertion(+), 17 deletions(-)
>

This patch is stand-alone too. So subject should be [PATCH 1/1] ...

Still mergeable though.

David Daney
