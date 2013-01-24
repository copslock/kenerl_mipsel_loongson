Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 11:35:16 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36625 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832208Ab3AXKfPI3XDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 11:35:15 +0100
Message-ID: <51010DBF.5060302@phrozen.org>
Date:   Thu, 24 Jan 2013 11:32:31 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V8 00/13] MIPS: Add Loongson-3 based machines support
References: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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


>
> Huacai Chen(13):
>   MIPS: Loongson: Add basic Loongson-3 definition.
>   MIPS: Loongson: Add basic Loongson-3 CPU support.
>   MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
>   MIPS: Loongson 3: Add Lemote-3A machtypes definition.
>   MIPS: Loongson: Add UEFI-like firmware interface support.
>   MIPS: Loongson 3: Add HT-linked PCI support.
>   MIPS: Loongson 3: Add IRQ init and dispatch support.
>   MIPS: Loongson 3: Add serial port support.
>   MIPS: Loongson: Add swiotlb to support big memory (>4GB).
>   MIPS: Loongson: Add Loongson-3 Kconfig options.
>   MIPS: Loongson 3: Add Loongson-3 SMP support.
>   MIPS: Loongson 3: Add CPU hotplug support.
>   MIPS: Loongson: Add a Loongson-3 default config file.
>
> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> Signed-off-by: Hua Yan<yanh@lemote.com>
> ---

Hi,

I have added all patches apart from 3/13 to my queue.

I believe "MIPS: Loongson: Introduce and use cpu_has_coherent_cache 
feature." should e rewritten in a saner way.

Please compile and runtime test the tree before I send it to Ralf
--> 
http://git.linux-mips.org/?p=john/linux-john.git;a=shortlog;h=refs/heads/mips-next-3.9

I cleaned up a few minor whitespace errors while merging.

http://patchwork.linux-mips.org/patch/4547/ has a few comments. Please 
prepare a patch asap to address those so i can fold it into the series.

	John
