Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Dec 2014 19:26:36 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64619 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008923AbaLPS0e3e-tx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Dec 2014 19:26:34 +0100
Received: by mail-ie0-f170.google.com with SMTP id rd18so13521880iec.15
        for <multiple recipients>; Tue, 16 Dec 2014 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EzPSopAId+r2RewCwoHe8IgEZxaeSsqMw68ZszOnGwI=;
        b=mKvVByf0bHEr+tTkCHPnJl5gQ9b8Xs4sz6744N2FkvTcriOiFtYu8KGG2y8V6rAHXv
         cerLgrJ51bWHLRWXoV9bdZECUXHPgjsLMlPHcbpiN/OtmjH0D8xAfhL4lvw+g0yVVU+s
         WADMDTFPXnniuXR+TvKh+znUfH/9PY9JwZQ/NfOw4kEohrejrKDkjGY04rcgsbt65Lus
         D5ZJcd9fP9P3iFP/8rfBh9mbBzbKI4wjjxqqyGaBJpCWATuRoeDIJqv5LTSbHR/GxtMT
         M/ysbilHLxZ0It9G8lOmGdtLQ5l78Pu1YWPwWH/Tx6d8HXWhlDJ61DZKQzV0yIbrP+5T
         YSgA==
X-Received: by 10.42.194.17 with SMTP id dw17mr33120267icb.4.1418754388680;
        Tue, 16 Dec 2014 10:26:28 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n7sm6538243igp.0.2014.12.16.10.26.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:26:28 -0800 (PST)
Message-ID: <54907952.7030504@gmail.com>
Date:   Tue, 16 Dec 2014 10:26:26 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aleksey Makarov <feumilieu@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
Subject: Re: [PATCH 00/14] MIPS: OCTEON: Some partial support for Octeon III
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 12/15/2014 10:03 AM, Aleksey Makarov wrote:
> These patches fix some issues in the Cavium Octeon code and
> introduce some partial support for Octeon III and little-endian.
>

We will be sending a second revision of these to improve the patches as 
per some of feedback received.

David Daney


> Aleksey Makarov (1):
>    MIPS: OCTEON: Delete unused COP2 saving code
>
> Chandrakala Chavva (1):
>    MIPS: OCTEON: Use correct instruction to read 64-bit COP0 register
>
> David Daney (12):
>    MIPS: OCTEON: Save/Restore wider multiply registers in OCTEON III CPUs
>    MIPS: OCTEON: Fix FP context save.
>    MIPS: OCTEON: Save and restore CP2 SHA3 state
>    MIPS: Remove unneeded #ifdef __KERNEL__ from asm/processor.h
>    MIPS: OCTEON: Implement the core-16057 workaround
>    MIPS: OCTEON: Don't do acknowledge operations for level triggered
>      irqs.
>    MIPS: OCTEON: Add ability to used an initrd from a named memory block.
>    MIPS: OCTEON: Add little-endian support to asm/octeon/octeon.h
>    MIPS: OCTEON: Implement DCache errata workaround for all CN6XXX
>    MIPS: OCTEON: Update octeon-model.h code for new SoCs.
>    MIPS: OCTEON: Add register definitions for OCTEON III reset unit.
>    MIPS: OCTEON: Handle OCTEON III in csrc-octeon.
>
>   arch/mips/cavium-octeon/csrc-octeon.c              |  10 +
>   arch/mips/cavium-octeon/octeon-irq.c               |  45 ++-
>   arch/mips/cavium-octeon/setup.c                    |  81 +++-
>   arch/mips/include/asm/bootinfo.h                   |   1 +
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     |  22 +
>   arch/mips/include/asm/mach-cavium-octeon/war.h     |   3 +
>   arch/mips/include/asm/octeon/cvmx-rst-defs.h       | 441 +++++++++++++++++++++
>   arch/mips/include/asm/octeon/octeon-model.h        |  65 ++-
>   arch/mips/include/asm/octeon/octeon.h              | 148 +++++--
>   arch/mips/include/asm/processor.h                  |   8 +-
>   arch/mips/include/asm/ptrace.h                     |   4 +-
>   arch/mips/kernel/asm-offsets.c                     |   1 +
>   arch/mips/kernel/octeon_switch.S                   | 218 ++++++----
>   arch/mips/kernel/setup.c                           |  19 +-
>   arch/mips/mm/uasm.c                                |   2 +-
>   15 files changed, 935 insertions(+), 133 deletions(-)
>   create mode 100644 arch/mips/include/asm/octeon/cvmx-rst-defs.h
>
