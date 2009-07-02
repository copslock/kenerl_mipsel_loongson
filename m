Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 06:08:18 +0200 (CEST)
Received: from gateway10.websitewelcome.com ([69.56.148.20]:57917 "HELO
	gateway10.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492039AbZGBEIM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 06:08:12 +0200
Received: (qmail 14955 invoked from network); 2 Jul 2009 04:08:03 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway10.websitewelcome.com with SMTP; 2 Jul 2009 04:08:03 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:30429 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MMDV4-000109-DM; Wed, 01 Jul 2009 23:02:18 -0500
Message-ID: <4A4C314B.2070907@paralogos.com>
Date:	Wed, 01 Jul 2009 21:02:19 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Raghu Gandham <raghu@mips.com>
CC:	linux-mips@linux-mips.org, chris@mips.com
Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE bindings
 when doing cross VPE writes
References: <20090702023938.23268.65453.stgit@linux-raghu> <20090702024331.23268.98671.stgit@linux-raghu>
In-Reply-To: <20090702024331.23268.98671.stgit@linux-raghu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Note that, regardless of the reset state, smtc_configure_tlb() should 
have at least temporarily bound TC 1 to VPE1, which may be why this 
never seemed to be a problem on the 34K.  If one wants to support 
designs with more than 2 VPEs, then this is probably one of the things 
that needs to be fixed.  That having been said, rather than adding a 
usually-redundant write_vpe_c0_vpeconf0() in that clause, wouldn't it be 
cleaner to just move the MVP setting from the top of the loop to the 
point in the loop just after the TCs have been bound to the VPE in 
question, i.e.,

 454                 if (slop) {
 455                         if (tc != 0) {
 456                                 smtc_tc_setup(vpe,tc, cpu);
 457                                 cpu++;
 458                         }
 459                         printk(" %d", tc);
 460                         tc++;
 461                         slop--;
 462                 }

                        write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() | 
VPECONF0_MVP);

 463                 if (vpe != 0) {
 464                         /*
 465                          * Clear any stale software interrupts from 
VPE's Cause
 466                          */

This should definitely be OK for a 34K, because it's being executed by 
TC0 in VPE0 and the reset state of VPE0 has MVP set.  If it weren't, 
smtc_configure_tlb() would have failed.

          Regards,

          Kevin K.

Raghu Gandham wrote:
> From: Kurt Martin <kurt@mips.com>
>
> Signed-off-by: Jaidev Patwardhan <jaidev@mips.com>
> 	Signed-off-by: Chris Dearman <chris@mips.com>
> ---
>
>  arch/mips/kernel/smtc.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
> index 69240c4..3498b82 100644
> --- a/arch/mips/kernel/smtc.c
> +++ b/arch/mips/kernel/smtc.c
> @@ -481,6 +481,18 @@ void smtc_prepare_cpus(int cpus)
>  			 */
>  			if (tc != 0) {
>  				smtc_tc_setup(vpe, tc, cpu);
> +				if (vpe != 0) {
> +					/*
> +					 * Set MVP bit (possibly again).  Do it
> +					 * here to catch CPUs that have no TCs
> +					 * bound to the VPE at reset.  In that
> +					 * case, a TC must be bound to the VPE
> +					 * before we can set VPEControl[MVP]
> +					 */
> +					write_vpe_c0_vpeconf0(
> +						read_vpe_c0_vpeconf0() |
> +						VPECONF0_MVP);
> +				}
>  				cpu++;
>  			}
>  			printk(" %d", tc);
>
>
>   
