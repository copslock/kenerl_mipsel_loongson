Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 23:22:47 +0100 (CET)
Received: from mail-ea0-f177.google.com ([209.85.215.177]:60729 "EHLO
        mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831685Ab2LEWWpVuIw8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 23:22:45 +0100
Received: by mail-ea0-f177.google.com with SMTP id c10so2222654eaa.36
        for <linux-mips@linux-mips.org>; Wed, 05 Dec 2012 14:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r7fkgQr+CsD4GMPFB5s0zN/5zgtTM0ouJWb/3Cc/lMI=;
        b=o9kqjekaOtBBxmH02N66jD8xZ9KtFHhkO8/kNRrXU7zrr+xtCYB1Suas7AlXstOx+k
         BKSNVNtgRH7rQdyDWXlRxyit0/z3JspqmUjfJOwTuc2ZBtkRqBDY63CTZ/IArWtIExZq
         egTNv64BNegz/LRLiFSSV9Qnh+D9+1YPzIEtQGjmv/RRUpYH3q0yTJ7T7ERB9kZZzvkB
         zQFWk/GGXfb6MoZ8+SKjkHn+KUKoISuNpLkoRFt3J69aNcb7pc+VwahOnrT4MeZvXcON
         MQQdSPRqil285OBw9DGOH3/tnZ2BmWV5b5oLClRO1zZsRyUZsDsuwzqkTl3Z2YTO0OT+
         A/FA==
Received: by 10.14.177.1 with SMTP id c1mr65207416eem.8.1354746159925; Wed, 05
 Dec 2012 14:22:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.14.224.129 with HTTP; Wed, 5 Dec 2012 14:22:19 -0800 (PST)
In-Reply-To: <1354729568-19993-7-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de> <1354729568-19993-7-git-send-email-hauke@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 6 Dec 2012 09:22:19 +1100
Message-ID: <CAGRGNgXp7PVtdVOraF3PcGpzZ=9zAfa=9MWODiTCq9cFXPCoqA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] ssb: get alp clock from devices with PMU
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, wim@iguana.be,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke,

Sorry this is so late, I only just noticed.

On Thu, Dec 6, 2012 at 4:46 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> If there is a PMU in the device, get the alp clock from that part and
> do not assume 20000000.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/ssb/driver_chipcommon.c     |   15 +++++++++------
>  drivers/ssb/driver_chipcommon_pmu.c |   27 +++++++++++++++++++++++++++
>  drivers/ssb/ssb_private.h           |    1 +
>  3 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
> index d7d5804..a43415a 100644
> --- a/drivers/ssb/driver_chipcommon_pmu.c
> +++ b/drivers/ssb/driver_chipcommon_pmu.c
> @@ -618,6 +618,33 @@ void ssb_pmu_set_ldo_paref(struct ssb_chipcommon *cc, bool on)
>  EXPORT_SYMBOL(ssb_pmu_set_ldo_voltage);
>  EXPORT_SYMBOL(ssb_pmu_set_ldo_paref);
>
> +static u32 ssb_pmu_get_alp_clock_clk0(struct ssb_chipcommon *cc)
> +{
> +       u32 crystalfreq;
> +       const struct pmu0_plltab_entry *e = NULL;
> +
> +       crystalfreq = chipco_read32(cc, SSB_CHIPCO_PMU_CTL) &
> +                     SSB_CHIPCO_PMU_CTL_XTALFREQ >> SSB_CHIPCO_PMU_CTL_XTALFREQ_SHIFT;
> +       e = pmu0_plltab_find_entry(crystalfreq);
> +       BUG_ON(!e);
> +       return e->freq * 1000;
> +}
> +
> +u32 ssb_pmu_get_alp_clock(struct ssb_chipcommon *cc)
> +{
> +       struct ssb_bus *bus = cc->dev->bus;
> +
> +       switch (bus->chip_id) {
> +       case 0x5354:
> +               ssb_pmu_get_alp_clock_clk0(cc);
> +       default:
> +               ssb_printk(KERN_ERR PFX
> +                          "ERROR: PMU alp clock unknown for device %04X\n",
> +                          bus->chip_id);
> +               return 0;

Would it be better to return the default here (or handle this case in
ssb_chipco_alp_clock() ) so these chips have a clock rate?

> +       }
> +}
> +
>  u32 ssb_pmu_get_cpu_clock(struct ssb_chipcommon *cc)
>  {
>         struct ssb_bus *bus = cc->dev->bus;

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
