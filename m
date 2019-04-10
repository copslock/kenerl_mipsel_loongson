Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B5C282CE
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EF2217F4
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 07:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfDJHd2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:33:28 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59251 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfDJHd2 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 10 Apr 2019 03:33:28 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BF3AAFF80C;
        Wed, 10 Apr 2019 07:33:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to
 mm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190404055128.24330-1-alex@ghiti.fr>
 <20190404055128.24330-3-alex@ghiti.fr> <20190410065908.GC2942@infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
Date:   Wed, 10 Apr 2019 09:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190410065908.GC2942@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 04/10/2019 08:59 AM, Christoph Hellwig wrote:
> On Thu, Apr 04, 2019 at 01:51:25AM -0400, Alexandre Ghiti wrote:
>> - fix the case where stack randomization should not be taken into
>>    account.
> Hmm.  This sounds a bit vague.  It might be better if something
> considered a fix is split out to a separate patch with a good
> description.

Ok, I will move this fix in another patch.

>
>> +config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> +	bool
>> +	help
>> +	  This allows to use a set of generic functions to determine mmap base
>> +	  address by giving priority to top-down scheme only if the process
>> +	  is not in legacy mode (compat task, unlimited stack size or
>> +	  sysctl_legacy_va_layout).
> Given that this is an option that is just selected by other Kconfig
> options the help text won't ever be shown.  I'd just move it into a
> comment bove the definition.

Oh yes, it does not appear, thanks, I'll move it above the definition.

>
>> +#ifdef CONFIG_MMU
>> +#ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> I don't think we need the #ifdef CONFIG_MMU here,
> CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should only be selected
> if the MMU is enabled to start with.

Ok, thanks.

>> +#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
>> +unsigned long arch_mmap_rnd(void)
> Now that a bunch of architectures use a version in common code
> the arch_ prefix is a bit mislead.  Probably not worth changing
> here, but some time in the future it could use a new name.

Ok I'll keep it in mind for later,

Thanks for your time,

Alex
