Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 23:16:53 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:58638 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2BSWQu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Feb 2012 23:16:50 +0100
Received: by lahg1 with SMTP id g1so7127433lah.36
        for <linux-mips@linux-mips.org>; Sun, 19 Feb 2012 14:16:44 -0800 (PST)
Received-SPF: pass (google.com: domain of netrolller.3d@gmail.com designates 10.152.125.20 as permitted sender) client-ip=10.152.125.20;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of netrolller.3d@gmail.com designates 10.152.125.20 as permitted sender) smtp.mail=netrolller.3d@gmail.com; dkim=pass header.i=netrolller.3d@gmail.com
Received: from mr.google.com ([10.152.125.20])
        by 10.152.125.20 with SMTP id mm20mr13296693lab.6.1329689804494 (num_hops = 1);
        Sun, 19 Feb 2012 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=unAcuzRbWgAf8MFdIqAuNsEK4mQoY8AxOjIfgnvNT7Y=;
        b=le90sHib75pgisgdq1p9ey/nxXtlg5jzKkfTIJ9WffNY3HmI3S0U8399jVfL+jPoFF
         +ObUHUNrOgpyg+4/0QisX1Qni/FAvhp7TQwX+u4/F65S80oaFpM7BQCNZYVC8nTT9GJW
         bCFj7ulbkf1TwstO7MNaDJu5Ov34ClYT8+Tc4=
Received: by 10.152.125.20 with SMTP id mm20mr11135692lab.6.1329689803342;
 Sun, 19 Feb 2012 14:16:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.27.104 with HTTP; Sun, 19 Feb 2012 14:16:23 -0800 (PST)
In-Reply-To: <1329676345-15856-6-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-6-git-send-email-hauke@hauke-m.de>
From:   =?ISO-8859-1?Q?G=E1bor_Stefanik?= <netrolller.3d@gmail.com>
Date:   Sun, 19 Feb 2012 23:16:23 +0100
Message-ID: <CA+XFjipnKcDP0F00_0i81PMYkje5avAywC6DfoLkjApAHf-1qw@mail.gmail.com>
Subject: Re: [PATCH 05/11] ssb: add some missing sprom attributes
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        m@bues.ch, arend@broadcom.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: netrolller.3d@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Feb 19, 2012 at 7:32 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This patch extends the sprom struct to contain all sprom attributes
> found in sprom version 1 to 9. This was done accordingly to the open
> source part of the Braodcom SDK.

Typo.

>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  include/linux/ssb/ssb.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 75 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
> index 44e486e..992c47a 100644
> --- a/include/linux/ssb/ssb.h
> +++ b/include/linux/ssb/ssb.h
> @@ -32,6 +32,8 @@ struct ssb_sprom {
>        u8 et0mdcport;          /* MDIO for enet0 */
>        u8 et1mdcport;          /* MDIO for enet1 */
>        u16 board_rev;          /* Board revision number from SPROM. */
> +       u16 board_num;          /* Board number number from SPROM. */

Please remove the repeated repeated word.

> +       u16 board_type;         /* Board type number from SPROM. */
>        u8 country_code;        /* Country Code */
>        char ccode[2];          /* Country Code as two chars like EU or US */
>        u8 leddc_on_time;       /* LED Powersave Duty Cycle On Count */
> @@ -107,7 +109,79 @@ struct ssb_sprom {
>                } ghz5;
>        } fem;
>
> -       /* TODO - add any parameters needed from rev 2, 3, 4, 5 or 8 SPROMs */
> +       u16 mcs2gpo[8];
> +       u16 mcs5gpo[8];
> +       u16 mcs5glpo[8];
> +       u16 mcs5ghpo[8];
> +       u8 opo;
> +
> +       u8 rxgainerr2ga[3];
> +       u8 rxgainerr5gla[3];
> +       u8 rxgainerr5gma[3];
> +       u8 rxgainerr5gha[3];
> +       u8 rxgainerr5gua[3];
> +
> +       u8 noiselvl2ga[3];
> +       u8 noiselvl5gla[3];
> +       u8 noiselvl5gma[3];
> +       u8 noiselvl5gha[3];
> +       u8 noiselvl5gua[3];
> +
> +       u8 regrev;
> +       u8 txchain;
> +       u8 rxchain;
> +       u8 antswitch;
> +       u16 cddpo;
> +       u16 stbcpo;
> +       u16 bw40po;
> +       u16 bwduppo;
> +
> +       u8 tempthresh;
> +       u8 tempoffset;
> +       u16 rawtempsense;
> +       u8 measpower;
> +       u8 tempsense_slope;
> +       u8 tempcorrx;
> +       u8 tempsense_option;
> +       u8 freqoffset_corr;
> +       u8 iqcal_swp_dis;
> +       u8 hw_iqcal_en;
> +       u8 elna2g;
> +       u8 elna5g;
> +       u8 phycal_tempdelta;
> +       u8 temps_period;
> +       u8 temps_hysteresis;
> +       u8 measpower1;
> +       u8 measpower2;
> +       u8 pcieingress_war;
> +
> +       /* power per rate from sromrev 9 */
> +       u16 cckbw202gpo;
> +       u16 cckbw20ul2gpo;
> +       u32 legofdmbw202gpo;
> +       u32 legofdmbw20ul2gpo;
> +       u32 legofdmbw205glpo;
> +       u32 legofdmbw20ul5glpo;
> +       u32 legofdmbw205gmpo;
> +       u32 legofdmbw20ul5gmpo;
> +       u32 legofdmbw205ghpo;
> +       u32 legofdmbw20ul5ghpo;
> +       u32 mcsbw202gpo;
> +       u32 mcsbw20ul2gpo;
> +       u32 mcsbw402gpo;
> +       u32 mcsbw205glpo;
> +       u32 mcsbw20ul5glpo;
> +       u32 mcsbw405glpo;
> +       u32 mcsbw205gmpo;
> +       u32 mcsbw20ul5gmpo;
> +       u32 mcsbw405gmpo;
> +       u32 mcsbw205ghpo;
> +       u32 mcsbw20ul5ghpo;
> +       u32 mcsbw405ghpo;
> +       u16 mcs32po;
> +       u16 legofdm40duppo;
> +       u8 sar2g;
> +       u8 sar5g;
>  };
>
>  /* Information about the PCB the circuitry is soldered on. */
> --
> 1.7.5.4
>
>
> _______________________________________________
> b43-dev mailing list
> b43-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/b43-dev



-- 
Vista: [V]iruses, [I]ntruders, [S]pyware, [T]rojans and [A]dware. :-)
