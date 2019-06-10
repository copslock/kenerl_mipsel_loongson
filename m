Return-Path: <SRS0=Bczd=UJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52121C282DD
	for <linux-mips@archiver.kernel.org>; Mon, 10 Jun 2019 10:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494C20859
	for <linux-mips@archiver.kernel.org>; Mon, 10 Jun 2019 10:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbfFJKS4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:18:56 -0400
Received: from foss.arm.com ([217.140.110.172]:39778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfFJKSz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 10 Jun 2019 06:18:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09527337;
        Mon, 10 Jun 2019 03:18:55 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1B213F557;
        Mon, 10 Jun 2019 03:20:34 -0700 (PDT)
Subject: Re: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
To:     Huw Davies <huw@codeweavers.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-3-vincenzo.frascino@arm.com>
 <20190610093146.GB11076@merlot.physics.ox.ac.uk>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <01907a8b-c052-c51a-4113-389312f9efe7@arm.com>
Date:   Mon, 10 Jun 2019 11:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610093146.GB11076@merlot.physics.ox.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 10/06/2019 10:31, Huw Davies wrote:
> On Thu, May 30, 2019 at 03:15:14PM +0100, Vincenzo Frascino wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
> 
> This doesn't make much sense.  Perhaps: "In the last few years we
> have seen an explosion in vdso..." ?
>

Thanks for this, I will fix in v7.

> Huw.
> 

-- 
Regards,
Vincenzo
