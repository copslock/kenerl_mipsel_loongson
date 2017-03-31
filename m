Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 23:32:19 +0200 (CEST)
Received: from resqmta-ch2-08v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:40]:51322
        "EHLO resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdCaVcLgh-jo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 23:32:11 +0200
Received: from resomta-ch2-08v.sys.comcast.net ([69.252.207.104])
        by resqmta-ch2-08v.sys.comcast.net with SMTP
        id u48mcHasrAfZsu49Rcrq0Y; Fri, 31 Mar 2017 21:32:09 +0000
Received: from [192.168.1.13] ([69.251.157.57])
        by resomta-ch2-08v.sys.comcast.net with SMTP
        id u49PcJxqltZO6u49PcpR4Q; Fri, 31 Mar 2017 21:32:09 +0000
Subject: Re: [PATCH 0/5] MIPS/irqchip: Use IPI IRQ domains for CPU interrupt
 controller IPIs
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20170330190614.14844-1-paul.burton@imgtec.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <24092d33-ae11-f0f4-a390-0add8e3650da@gentoo.org>
Date:   Fri, 31 Mar 2017 17:31:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170330190614.14844-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHIRxnFB/hfmn1cUxLDo5i7CHUTdLBxKsRE7j5a7NWuoNGDXBLdunQQTbaM+zCG8yUyj4pnhdB04Nnq+T5N+GXborWIiG7eoywsUh5B0tgpKDPoHtus7
 fh/p2iENu9z+igRQg+/jJP14tGvn1tNAsco9Veqbqn7sD8fIco1lP6I/HJTqq1H+ZNGOKZIFyvH4u25uqZKHveAhnKFX5dV0Gav13gMWlsdsAEddKTGXPNF9
 laycQ83PMKENK+wj0IPV/4AAxJPQ1ebEeio5/x+1a/Dh1s3T66uytiuZYuqxKn77rW3rDcL5TGO/jsEIUYimet4osHLGBSPIx3duj5yo/is=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 03/30/2017 15:06, Paul Burton wrote:
> This series introduces support for IPI IRQ domains to the CPU interrupt
> controller driver, allowing IPIs to function in the same way as those
> provided by the MIPS GIC as far as platform/board code is concerned.
> 
> Doing this allows us to avoid duplicating code across platforms, avoid
> having to handle cases where IPI domains are or aren't in use depending
> upon the interrupt controller, and strengthen a sanity check for cases
> where IPI IRQ domains are supported.
> 
> Applies atop v4.11-rc4.
> 
> 
> Paul Burton (5):
>   irqchip: mips-cpu: Replace magic 0x100 with IE_SW0
>   irqchip: mips-cpu: Prepare for non-legacy IRQ domains
>   irqchip: mips-cpu: Introduce IPI IRQ domain support
>   MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
>   MIPS: Stengthen IPI IRQ domain sanity check
> 
>  arch/mips/kernel/smp-mt.c       |  49 ++------------
>  arch/mips/kernel/smp.c          |  20 +++---
>  arch/mips/lantiq/irq.c          |  52 --------------
>  arch/mips/mti-malta/malta-int.c |  83 ++---------------------
>  drivers/irqchip/Kconfig         |   2 +
>  drivers/irqchip/irq-mips-cpu.c  | 146 +++++++++++++++++++++++++++++++++++-----
>  6 files changed, 151 insertions(+), 201 deletions(-)

Out of curiosity, "legacy" systems like SGI IP27 (in-tree) and IP30 (external)
support SMP and the IRQ handling is fairly old for IP27 (IP30 borrows IP27's
logic).  Could these systems benefit from using IPI domains?  If so, is there
any kind of crash-course or dummies guide to switching from plain irq_chip to
IPI domains?  Note, both systems have somewhat unique interrupt controllers
built into their system ASICs, but actual IRQ dispatch happens from the CPU
interrupt pins.

Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
