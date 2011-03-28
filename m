Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 23:55:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7853 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100592Ab1C1Vzy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2011 23:55:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d9104210000>; Mon, 28 Mar 2011 14:56:49 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 28 Mar 2011 14:55:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 28 Mar 2011 14:55:51 -0700
Message-ID: <4D9103E7.1090109@caviumnetworks.com>
Date:   Mon, 28 Mar 2011 14:55:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 2/3] MIPS: Octeon: Rewrite interrupt handling code.
References: <20110328150330.110780523@linutronix.de> <20110328150627.679291180@linutronix.de>
In-Reply-To: <20110328150627.679291180@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2011 21:55:51.0847 (UTC) FILETIME=[E7B30B70:01CBED92]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/28/2011 08:06 AM, Thomas Gleixner wrote:
> From: David Daney<ddaney@caviumnetworks.com>
>
> This includes conversion to new style irq_chip functions, and
> correctly enabling/disabling per-CPU interrupts.
>
> The hardware interrupt bit to irq number mapping is now done with a
> flexible map, instead of by bit twiddling the irq number.
>
> [ tglx: Adjusted to new irq_cpu_on/offline callbacks and
>          __irq_set_affinity_lock ]
>
> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> Cc: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> LKML-Reference:<1301081931-11240-5-git-send-email-ddaney@caviumnetworks.com>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c           | 1410 ++++++++++++++-----------
>   arch/mips/cavium-octeon/setup.c                |   12
>   arch/mips/cavium-octeon/smp.c                  |   39
>   arch/mips/include/asm/mach-cavium-octeon/irq.h |  243 +---
>   arch/mips/include/asm/octeon/octeon.h          |    2
>   arch/mips/pci/msi-octeon.c                     |   20
>   6 files changed, 915 insertions(+), 811 deletions(-)
>

Well tglx modified my patch slightly, but it still works.  So this one 
is OK too.

David Daney
