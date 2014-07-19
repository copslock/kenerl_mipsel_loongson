Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 14:06:06 +0200 (CEST)
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:55089 "EHLO
        cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860071AbaGSMGDcgKu2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 14:06:03 +0200
Received: from cpsps-ews19.kpnxchange.com ([10.94.84.185]) by cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 19 Jul 2014 14:05:57 +0200
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews19.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 19 Jul 2014 14:05:56 +0200
Received: from [192.168.10.107] ([77.173.140.92]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 19 Jul 2014 14:05:56 +0200
Message-ID: <1405771556.18077.5.camel@x220>
Subject: Re: [PATCH] mips: Remove uneeded line in cmp_smp_finish
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Nicholas Krause <xerofoify@gmail.com>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com,
        Leonid.Yegoshin@imgtec.com, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Jul 2014 14:05:56 +0200
In-Reply-To: <1405746604-7737-1-git-send-email-xerofoify@gmail.com>
References: <1405746604-7737-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jul 2014 12:05:56.0659 (UTC) FILETIME=[CBF1B830:01CFA349]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Sat, 2014-07-19 at 01:10 -0400, Nicholas Krause wrote:
> This patch removes a unneeded line from this file as stated by the
> fix me in this file.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/mips/kernel/smp-cmp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
> index fc8a515..61bfa20 100644
> --- a/arch/mips/kernel/smp-cmp.c
> +++ b/arch/mips/kernel/smp-cmp.c
> @@ -60,8 +60,6 @@ static void cmp_smp_finish(void)
>  {
>  	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
>  
> -	/* CDFIXME: remove this? */
> -	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));

That comment ends in a question mark. I wonder why...
 
>  #ifdef CONFIG_MIPS_MT_FPAFF
>  	/* If we have an FPU, enroll ourselves in the FPU-full mask */


Paul Bolle
