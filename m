Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jul 2013 11:54:26 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1312 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822429Ab3GOJyXbTE1Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jul 2013 11:54:23 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 15 Jul 2013 02:48:09 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 15 Jul 2013 02:53:54 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 15 Jul 2013 02:53:54 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2B606F301B; Mon, 15
 Jul 2013 02:52:56 -0700 (PDT)
Date:   Mon, 15 Jul 2013 15:25:02 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Aaro Koskinen" <aaro.koskinen@iki.fi>
cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: tlbex: fix broken build in v3.11-rc1
Message-ID: <20130715095501.GE22314@jayachandranc.netlogicmicro.com>
References: <1373876517-14646-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
In-Reply-To: <1373876517-14646-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7DFD1AD31R044338170-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Mon, Jul 15, 2013 at 11:21:57AM +0300, Aaro Koskinen wrote:
> Commit 6ba045f9fbdafb48da42aa8576ea7a3980443136 (MIPS: Move generated code
> to .text for microMIPS) deleted tlbmiss_handler_setup_pgd_array, but some
> references were not converted. Fix that to enable building a MIPS kernel.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/mm/tlbex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 9ab0f90..cc34521 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1466,7 +1466,7 @@ static void __cpuinit build_r4000_setup_pgd(void)
>  {
>  	const int a0 = 4;
>  	const int a1 = 5;
> -	u32 *p = tlbmiss_handler_setup_pgd_array;
> +	u32 *p = tlbmiss_handler_setup_pgd;
>  	const int tlbmiss_handler_setup_pgd_size =
>  		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
>  	struct uasm_label *l = labels;

Acked-by: "Jayachandran C." <jchandra@broadcom.com>

Thanks, looks like I made a mistake splitting the patchset, this part went
into the next patch which didn't make it to 3.11.

JC.
