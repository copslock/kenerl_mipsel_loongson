Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 12:02:04 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:52557 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeCTLB4Uh3q1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 12:01:56 +0100
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 20 Mar 2018 11:01:45 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 20
 Mar 2018 04:01:50 -0700
Subject: Re: [PATCH v2] MIPS: ralink: fix booting on mt7621
To:     NeilBrown <neil@brown.name>, John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <87efkf9z0o.fsf@notabene.neil.brown.name>
 <87605r9mwf.fsf@notabene.neil.brown.name>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <cc33f000-16ed-b331-53b7-d767e20a4a9c@mips.com>
Date:   Tue, 20 Mar 2018 11:01:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87605r9mwf.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1521543705-452060-25377-39749-1
X-BESS-VER: 2018.3.1-r1803192000
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191229
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
X-archive-position: 63076
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

Hi Neil,


On 20/03/18 08:22, NeilBrown wrote:
> 
> Further testing showed that the original version of this
> patch wasn't 100% reliable.  Very occasionally the read
> of SYSC_REG_CHIP_NAME0 returns garbage.  Repeating the
> read seems to be reliable, but it hasn't happened enough
> for me to be completely confident.
> So this version repeats that first read.

You almost certainly need a sync() to ensure that the write to gcr_reg0 
has completed before attempting to read sysc + SYSC_REG_CHIP_NAME0.

> 
> Thanks,
> NeilBrown
> 
> 
> ----------------8<--------------------
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
> returns garbage.  So repeat that read to be on the safe side.
> 
> Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   arch/mips/ralink/mt7621.c | 43 +++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index 1b274742077d..c37716407fbe 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -170,6 +170,29 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
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

i.e. Try putting a sync() here.

> +	}
> +
> +	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
> +	/* Sometimes first read returns garbage, so try again to be safe */

Rather than doing this, which is a bit of a hack and there's no 
guarantee the second read won't also read garbage without the barrier.

Thanks,
Matt

>   	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
>   	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
>   
> @@ -194,26 +217,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
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
