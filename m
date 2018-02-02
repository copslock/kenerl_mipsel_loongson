Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:34:37 +0100 (CET)
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:27999
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeBBDe3kOIB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:34:29 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CtAABG23Na/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGEKIEdg2CZEwMBAQEGgTSZXy2FGIMLFAEBAQEBAQEBAoY2AQEBAQI?=
 =?us-ascii?q?kVgUWDQEDAwECAQICJgJRDg0GAgEBiiQFGK07boInIYpCAQEBAQEBBAEBAQEBH?=
 =?us-ascii?q?gWBD4NagySCMCmDBYMvBIUGgmUFpCIBiBmEAZYdh2iNaYs/NoFyMxoIKAiCZ4J?=
 =?us-ascii?q?SAgEcghhmi2wBAQE?=
X-IPAS-Result: =?us-ascii?q?A2CtAABG23Na/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGEKIE?=
 =?us-ascii?q?dg2CZEwMBAQEGgTSZXy2FGIMLFAEBAQEBAQEBAoY2AQEBAQIkVgUWDQEDAwECA?=
 =?us-ascii?q?QICJgJRDg0GAgEBiiQFGK07boInIYpCAQEBAQEBBAEBAQEBHgWBD4NagySCMCm?=
 =?us-ascii?q?DBYMvBIUGgmUFpCIBiBmEAZYdh2iNaYs/NoFyMxoIKAiCZ4JSAgEcghhmi2wBA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.46,445,1511798400"; 
   d="scan'208";a="43058757"
Received: from unknown (HELO [172.16.0.22]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 02 Feb 2018 11:34:19 +0800
To:     James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
Message-ID: <079ec8f9-d2c2-9e29-278e-48e76bbb8de7@linux-m68k.org>
Date:   Fri, 2 Feb 2018 13:34:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
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

Hi James,

James Hogan wrote:
> From 17278a91e04f858155d54bee5528ba4fbcec6f87 Mon Sep 17 00:00:00 2001
> From: James Hogan <jhogan@kernel.org>
> Date: Tue, 14 Nov 2017 12:01:20 +0000
> Subject: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
> 
> MIPS CPS has a build warning on kernels configured for MIPS32R1 or
> MIPS64R1, due to the use of .set mt without a prior .set mips{32,64}r2:
> 
> arch/mips/kernel/cps-vec.S Assembler messages:
> arch/mips/kernel/cps-vec.S:238: Warning: the `mt' extension requires MIPS32 revision 2 or greater
> 
> Add .set MIPS_ISA_LEVEL_RAW before .set mt to silence the warning.

This change breaks booting for me on a MediaTek MT7621 platform:

  ...
  Calibrating delay loop... 586.13 BogoMIPS (lpj=2930688)^M
  pid_max: default: 32768 minimum: 301^M
  Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
  Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
  Hierarchical SRCU implementation.^M
  smp: Bringing up secondary CPUs ...^M
  Reserved instruction in kernel code[#1]:^M
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-ac0 #3^M
  $ 0   : 00000000 00000001 00000000 00000000^M
  $ 4   : 8501dd80 00000001 00000004 00000000^M
  $ 8   : 00000004 00000002 00000001 ffffffff^M
  $12   : 00000000 00000400 00000003 8501de00^M
  $16   : 807d5ca0 8501dd80 00000000 00000001^M
  $20   : 80842814 00000000 00000001 000000e0^M
  $24   : fffffffc 00000001                  ^M
  $28   : 85026000 85027de0 00000020 80013538^M
  Hi    : 00000006^M
  Lo    : 8e778000^M
  epc   : 80656620 mips_cps_boot_vpes+0x4c/0x160^M
  ra    : 80013538 cps_boot_secondary+0x280/0x440^M
  Status: 11000403        KERNEL EXL IE ^M
  Cause : 50800028 (ExcCode 0a)^M
  PrId  : 0001992f (MIPS 1004Kc)^M

If I revert the patch then I can boot up again, all works as expected.

I am not exactly using a pure mainline 4.15 source base though.
(I have a bunch of additional changes to make this platform actually work).

But this patch certainly does trap as above when present. I am using
a gcc-5.4.0/binutils-2.25.1 toolchain.

Any thoughts?

Regards
Greg


> Fixes: 245a7868d2f2 ("MIPS: smp-cps: rework core/VPE initialisation")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <james.hogan@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/17699/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/kernel/cps-vec.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index c7ed260..e68e6e0 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -235,6 +235,7 @@ LEAF(mips_cps_core_init)
>         has_mt  t0, 3f
> 
>         .set    push
> +       .set    MIPS_ISA_LEVEL_RAW
>         .set    mt
> 
>         /* Only allow 1 TC per VPE to execute... */
> @@ -388,6 +389,7 @@ LEAF(mips_cps_boot_vpes)
>  #elif defined(CONFIG_MIPS_MT)
> 
>         .set    push
> +       .set    MIPS_ISA_LEVEL_RAW
>         .set    mt
> 
>         /* If the core doesn't support MT then return */
> -- 
> 1.9.1
