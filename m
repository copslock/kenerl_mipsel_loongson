Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 10:33:34 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:55146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992971AbeKMJdbuxfUK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 10:33:31 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91744B651;
        Tue, 13 Nov 2018 09:33:30 +0000 (UTC)
Date:   Tue, 13 Nov 2018 10:33:28 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Huacai Chen <chenhc@lemote.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn
 calculation
Message-Id: <20181113103328.c9f49cc7b9c632b64f179436@suse.de>
In-Reply-To: <20181112221742.4900-1-paul.burton@mips.com>
References: <20181112221742.4900-1-paul.burton@mips.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

On Mon, 12 Nov 2018 22:18:01 +0000
Paul Burton <paul.burton@mips.com> wrote:

> Both the Loongson3 & SGI-IP27 platforms set max_low_pfn to the last
> available PFN describing memory. They both do it in paging_init() which
> is later than ideal since max_low_pfn is used before that function is
> called. Simplify both platforms to trivially initialize max_low_pfn
> using the end address of DRAM, and do it earlier in prom_meminit().
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index d8b8444d6795..813d13f92957 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -435,6 +435,7 @@ void __init prom_meminit(void)
>  
>  	mlreset();
>  	szmem();
> +	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());

this is too early, memory gets added after the following for loop.

>  
>  	for (node = 0; node < MAX_COMPACT_NODES; node++) {
>  		if (node_online(node)) {

it should work after this loop. I have the hardware to test later this day.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
