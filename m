Return-Path: <SRS0=1uEU=QB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98272C282C6
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67284218FC
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAYPQw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:16:52 -0500
Received: from foss.arm.com ([217.140.101.70]:48858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYPQw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 25 Jan 2019 10:16:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02DDDA78;
        Fri, 25 Jan 2019 07:16:51 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BD5C3F5AF;
        Fri, 25 Jan 2019 07:16:44 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:16:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mattst88@gmail.com, linux@armlinux.org.uk, will.deacon@arm.com,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/29] ARM: add migrate_pages() system call
Message-ID: <20190125151641.GF25901@arrakis.emea.arm.com>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161835.2259170-7-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Jan 18, 2019 at 05:18:12PM +0100, Arnd Bergmann wrote:
> The migrate_pages system call has an assigned number on all architectures
> except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
> Fix warning: #warning syscall migrate_pages not implemented"), it was
> intentionally left out based on the observation that there are no 32-bit
> ARM NUMA systems.
> 
> However, there are now arm64 NUMA machines that can in theory run 32-bit
> kernels (actually enabling NUMA there would require additional work)
> as well as 32-bit user space on 64-bit kernels, so that argument is no
> longer very strong.
> 
> Assigning the number lets us use the system call on 64-bit kernels as well
> as providing a more consistent set of syscalls across architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
