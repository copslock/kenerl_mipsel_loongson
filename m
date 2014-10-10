Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 12:21:59 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:32897 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011062AbaJJKV5ips6p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 12:21:57 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E7E4128BFD6
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 12:20:56 +0200 (CEST)
Received: from dicker-alter.lan (p548C9AAE.dip0.t-ipconnect.de [84.140.154.174])
        by arrakis.dune.hu (Postfix) with ESMTPSA
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 12:20:48 +0200 (CEST)
Message-ID: <5437B32F.3060302@openwrt.org>
Date:   Fri, 10 Oct 2014 12:21:35 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: ralink: add support for MT7620n
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org> <1412927388-60721-4-git-send-email-blogic@openwrt.org> <5437B020.3000405@cogentembedded.com>
In-Reply-To: <5437B020.3000405@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 10/10/2014 12:08, Sergei Shtylyov wrote:
>> +    if (bga) { name = "MT7620A"; soc_info->compatible =
>> "ralink,mt7620a-soc"; } else { -        panic("mt7620: unknown
>> SoC, n0:%08x n1:%08x", n0, n1); +        name = "MT7620N"; +
>> soc_info->compatible = "ralink,mt7620n-soc"; +#ifdef CONFIG_PCI
> 
> I suggest:
> 
> if (IS_ENABLED(CONFIG_PCI))
> 
> in order to avoid this #ifdef.
> 
> [...]
> 
> WBR, Sergei
> 


yep, holds true fo the irq-gic.c patch where i also use ifdef. I'll
fix and resend the 2 patches.

	John
