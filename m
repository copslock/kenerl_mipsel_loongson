Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 09:53:05 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:49677 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeCUIw6ErPLX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 09:52:58 +0100
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 21 Mar 2018 08:52:50 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 21
 Mar 2018 01:52:56 -0700
Subject: Re: [PATCH v3] MIPS: ralink: fix booting on mt7621
To:     NeilBrown <neil@brown.name>, John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <87efkf9z0o.fsf@notabene.neil.brown.name>
 <87605r9mwf.fsf@notabene.neil.brown.name>
 <871sge872l.fsf@notabene.neil.brown.name>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <364419e1-947b-2a87-526d-ccf3e77beb16@mips.com>
Date:   Wed, 21 Mar 2018 08:52:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <871sge872l.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1521622370-321457-2567-40066-1
X-BESS-VER: 2018.3-r1803192001
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191261
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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



On 21/03/18 03:02, NeilBrown wrote:
> 
> Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621
> has not been able to boot.
> 
> This patched caused mips_cm_probe() to be called before
> mt7621.c::proc_soc_init().
> 
> prom_soc_init() has a comment explaining that mips_cm_probe()
> "wipes out the bootloader config" and means that configuration
> registers are no longer available.  It has some code to re-enable
> this config.
> 
> Before this re-enable code is run, the sysc register cannot be
> read, so when SYSC_REG_CHIP_NAME0 is read, a garbage value
> is returned and panic() is called.
> 
> If we move the config-repair code to the top of prom_soc_init(),
> the registers can be read and boot can proceed.
> 
> Very occasionally, the first register read after the reconfiguration
> returns garbage.  So I added a call to __sync().
> 
> Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good to me

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

> ---
>   arch/mips/ralink/mt7621.c | 42 ++++++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index 1b274742077d..d2718de60b9b 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -170,6 +170,28 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
>   	u32 n1;
>   	u32 rev;
>   
> +	/* Early detection of CMP support */
> +	mips_cm_probe();
> +	mips_cpc_probe();
> +
> +	if (mips_cps_numiocu(0)) {
> +		/*
> +		 * mips_cm_probe() wipes out bootloader
> +		 * config for CM regions and we have to configure them
> +		 * again. This SoC cannot talk to pamlbus devices
> +		 * witout proper iocu region set up.
> +		 *
> +		 * FIXME: it would be better to do this with values
> +		 * from DT, but we need this very early because
> +		 * without this we cannot talk to pretty much anything
> +		 * including serial.
> +		 */
> +		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
> +		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
> +				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
> +		__sync();
> +	}
> +
>   	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
>   	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
>   
> @@ -194,26 +216,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
>   
>   	rt2880_pinmux_data = mt7621_pinmux_data;
>   
> -	/* Early detection of CMP support */
> -	mips_cm_probe();
> -	mips_cpc_probe();
> -
> -	if (mips_cps_numiocu(0)) {
> -		/*
> -		 * mips_cm_probe() wipes out bootloader
> -		 * config for CM regions and we have to configure them
> -		 * again. This SoC cannot talk to pamlbus devices
> -		 * witout proper iocu region set up.
> -		 *
> -		 * FIXME: it would be better to do this with values
> -		 * from DT, but we need this very early because
> -		 * without this we cannot talk to pretty much anything
> -		 * including serial.
> -		 */
> -		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
> -		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
> -				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
> -	}
>   
>   	if (!register_cps_smp_ops())
>   		return;
> 
