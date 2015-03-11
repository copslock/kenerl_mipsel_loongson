Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 09:29:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38671 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006725AbbCKI3B4uf0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 09:29:01 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4FCEB7BBB20D1;
        Wed, 11 Mar 2015 08:28:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 08:28:56 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 11 Mar
 2015 08:28:55 +0000
Message-ID: <54FFFCC7.5090707@imgtec.com>
Date:   Wed, 11 Mar 2015 08:28:55 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] Revert "MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction"
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 02/23/2015 10:52 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> This reverts commit 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed.
> 
> There are two problems:
> 
> 1) It breaks OCTEON, which will now crash in early boot with:
> 
>   Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
> 
> 2) The logic is broken.
> 
> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction
> is required.  The offending patch attempts (and fails) to change the
> meaning to be that EHB is part of the ISA.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
Hi,

First of all sorry about the octeon breakage.

However, whilst this patch will fix Octeon it will break R6

Can we please consider another patch that will simply use
cpu_has_mips_r2_r6 instead of cpu_has_mips_r2 so both will work in 4.0?

-- 
markos
