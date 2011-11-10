Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 01:38:26 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:60686 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904284Ab1KJAiT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 01:38:19 +0100
Received: from anacreon.sc.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.55.39])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id pAA0bmYS011235
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Wed, 9 Nov 2011 16:37:49 -0800
Message-ID: <4EBB1CD7.6040502@zytor.com>
Date:   Wed, 09 Nov 2011 16:37:43 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: binfmt_elf: Create Kconfig variable for PIE randomization.
References: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
In-Reply-To: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 31490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8373

On 11/09/2011 04:32 PM, David Daney wrote:
> Randomization of PIE load address is hard coded in binfmt_elf.c for
> X86 and ARM.  Create a new Kconfig variable
> (CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE) for this and use it instead.
> Thus architecture specific policy is pushed out of the generic
> binfmt_elf.c and into the architecture Kconfig files.
> 
> X86 and ARM Kconfigs are modified to select the new variable so there
> is no change in behavior.  A follow on patch will select it for MIPS
> too.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: H. Peter Anvin <hpa@zytor.com>
