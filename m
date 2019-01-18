Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C680C43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 02:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67CB20873
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 02:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsgSY/qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfARCXt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:23:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35535 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfARCXt (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 17 Jan 2019 21:23:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so13241761wrb.2;
        Thu, 17 Jan 2019 18:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cxgtuWq6aEibs191A1+MAka1vcQBlWbCpkH7b4ukQQs=;
        b=HsgSY/qv3rdtoafi1yzdbpBs/Kl3/YW9JcMRAf+79YrAlE8GbApwpDFB/BFZ3L1qou
         ZYMWFR4EbrmKHpVrDqG4sc+nsvbssHiql/ukjqp0sd5kq72n+fgGgbVrj8TA7SGMhhR+
         7KKsHjK9DsyG9YhpL1bER2mBqYB63zGchlaT7fxarbY24J+koSqBWvwJP07kr6Pf3nzI
         llhq/EIubm1ughLrb4tpTDfBKbGd5e0j+tw+1cKuNjfyfXqJx8TGWq3pmu4HLubSJXRQ
         jd4z5SsTuk3IjRpEPdEvbSowUdqtNwNbH4dbm8bG1xhBZZ4N3KgnjgXrAm/3429ZMRFt
         GroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cxgtuWq6aEibs191A1+MAka1vcQBlWbCpkH7b4ukQQs=;
        b=rtVcmpQ/CFvurywYo2qtbH27n5kYyVTM8fDVkpxp5NIlsDAMSqxMnybXTnXmFhwvIV
         jBmChJx+uJO0Cse5yaFQFARTd2w2QqNoG0Xd7FAH3d9RrjMxX3C85CTVDKs7XE+FdN+M
         QLehLOH8zmtEqHGXTY6uH3nEYbXMOOaZ0M3PgjtSJI+MCi8ha5ICztn9sWrniW2As/WQ
         3oMiZMRr2kPu2bciJ0pjd76aUEeIRzY5M3AhxpkkwkuG9Yc1Ffrknvbm9+MMiQnWb06b
         NnkONIiLFRHyEc80L+t59jKI93qzx7eYnJHbLUIvrWiFOqXB8ffhTWinRCvfPnGZQX/6
         I26w==
X-Gm-Message-State: AJcUukeC3FvFseo3HX+FpmG2U8bzdWKtSKOgADuYaB64itOQw3QxGGT7
        gUPk/o8CssjBLzK4V6vRD8k=
X-Google-Smtp-Source: ALg8bN7VAP8S69aCfDgDSdNB6sLnr1vakAemgicp4zyqAycyh0FNaMngoxynVBZMLa6oumNt6Dsp4A==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr15650435wrt.227.1547778226895;
        Thu, 17 Jan 2019 18:23:46 -0800 (PST)
Received: from localhost (83-215-98-136.stmi.dyn.salzburg-online.at. [83.215.98.136])
        by smtp.gmail.com with ESMTPSA id a12sm92203461wro.18.2019.01.17.18.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 18:23:46 -0800 (PST)
Date:   Thu, 17 Jan 2019 18:23:43 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 8/8] net: mscc: PTP offloading support
Message-ID: <20190118022343.qmorsbg6mjtaq3gi@localhost>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
 <20190117100212.2336-9-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117100212.2336-9-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Jan 17, 2019 at 11:02:12AM +0100, Antoine Tenart wrote:
> This patch adds support for offloading PTP timestamping to the Ocelot
> switch for both 1-step and 2-step modes.

For PTP Hardware Clock drivers, please add the PTP maintainer onto CC.

> +int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +{
> +	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> +	u32 val;
> +	time64_t s;
> +	s64 ns;
> +
> +	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> +	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> +	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_SAVE);
> +	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> +
> +	s = ocelot_read_rix(ocelot, PTP_PIN_TOD_SEC_MSB, TOD_ACC_PIN);
> +	s += ocelot_read_rix(ocelot, PTP_PIN_TOD_SEC_LSB, TOD_ACC_PIN);
> +	ns = ocelot_read_rix(ocelot, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
> +
> +	/* Deal with negative values */
> +	if (ns >= 0x3ffffff0 && ns <= 0x3fffffff) {
> +		s--;
> +		ns &= 0xf;
> +		ns += 999999984;
> +	}
> +
> +	set_normalized_timespec64(ts, s, ns);
> +	return 0;
> +}
> +
> +static int ocelot_ptp_settime64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> +	u32 val;
> +
> +	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> +	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> +	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_IDLE);
> +
> +	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> +
> +	ocelot_write_rix(ocelot, lower_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_LSB,
> +			 TOD_ACC_PIN);
> +	ocelot_write_rix(ocelot, upper_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_MSB,
> +			 TOD_ACC_PIN);
> +	ocelot_write_rix(ocelot, ts->tv_nsec, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
> +
> +	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> +	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> +	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_LOAD);
> +
> +	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);

You are writing multiple registers.  This code is not safe when called
concurrently.

Ditto for gettime, adjtime, and adjfreq.

> +	return 0;
> +}
> +
> +static int ocelot_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	if (delta > -(NSEC_PER_SEC / 2) && delta < (NSEC_PER_SEC / 2)) {
> +		struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> +		u32 val;
> +
> +		val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> +		val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> +		val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_IDLE);
> +
> +		ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> +
> +		ocelot_write_rix(ocelot, 0, PTP_PIN_TOD_SEC_LSB, TOD_ACC_PIN);
> +		ocelot_write_rix(ocelot, 0, PTP_PIN_TOD_SEC_MSB, TOD_ACC_PIN);
> +		ocelot_write_rix(ocelot, delta, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
> +
> +		val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> +		val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> +		val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_DELTA);
> +
> +		ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> +	} else {
> +		/* Fall back using ocelot_ptp_settime64 which is not exact. */
> +		struct timespec64 ts;
> +		u64 now;
> +
> +		ocelot_ptp_gettime64(ptp, &ts);
> +
> +		now = ktime_to_ns(timespec64_to_ktime(ts));
> +		ts = ns_to_timespec64(now + delta);
> +
> +		ocelot_ptp_settime64(ptp, &ts);
> +	}
> +	return 0;
> +}
> +
> +static int ocelot_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
> +{

Please implement adjfine instead.

> +	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> +	u64 adj = 0;
> +	u32 unit = 0, direction = 0;
> +
> +	if (!ppb)
> +		goto disable_adj;
> +
> +	if (ppb < 0) {
> +		direction = PTP_CFG_CLK_ADJ_CFG_DIR;
> +		ppb = -ppb;
> +	}
> +
> +	adj = PSEC_PER_SEC;
> +	do_div(adj, ppb);
> +
> +	/* If the adjustment value is too large, use ns instead */
> +	if (adj >= (1L << 30)) {
> +		unit = PTP_CFG_CLK_ADJ_FREQ_NS;
> +		do_div(adj, 1000);
> +	}
> +
> +	/* Still too big */
> +	if (adj >= (1L << 30))
> +		goto disable_adj;
> +
> +	ocelot_write(ocelot, unit | adj, PTP_CLK_CFG_ADJ_FREQ);
> +	ocelot_write(ocelot, PTP_CFG_CLK_ADJ_CFG_ENA | direction,
> +		     PTP_CLK_CFG_ADJ_CFG);
> +	return 0;
> +
> +disable_adj:
> +	ocelot_write(ocelot, 0, PTP_CLK_CFG_ADJ_CFG);
> +	return 0;
> +}
> +
> +static struct ptp_clock_info ocelot_ptp_clock_info = {
> +	.owner		= THIS_MODULE,
> +	.name		= "ocelot ptp",
> +	.max_adj	= 0x7fffffff,
> +	.n_alarm	= 0,
> +	.n_ext_ts	= 0,
> +	.n_per_out	= 0,
> +	.n_pins		= 0,
> +	.pps		= 0,
> +	.gettime64	= ocelot_ptp_gettime64,
> +	.settime64	= ocelot_ptp_settime64,
> +	.adjtime	= ocelot_ptp_adjtime,
> +	.adjfreq	= ocelot_ptp_adjfreq,
> +};
> +
> +static int ocelot_init_timestamp(struct ocelot *ocelot)
> +{
> +	ocelot->ptp_info = ocelot_ptp_clock_info;
> +
> +	ocelot->ptp_clock = ptp_clock_register(&ocelot->ptp_info, ocelot->dev);
> +	if (IS_ERR(ocelot->ptp_clock))
> +		return PTR_ERR(ocelot->ptp_clock);
> +
> +	ocelot_write(ocelot, SYS_PTP_CFG_PTP_STAMP_WID(30), SYS_PTP_CFG);
> +	ocelot_write(ocelot, 0xffffffff, ANA_TABLES_PTP_ID_LOW);
> +	ocelot_write(ocelot, 0xffffffff, ANA_TABLES_PTP_ID_HIGH);
> +
> +	ocelot_write(ocelot, PTP_CFG_MISC_PTP_EN, PTP_CFG_MISC);
> +
> +	return 0;
> +}
> +
>  int ocelot_probe_port(struct ocelot *ocelot, u8 port,
>  		      void __iomem *regs,
>  		      struct phy_device *phy)
> @@ -1649,6 +2138,8 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
>  	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr, ocelot_port->pvid,
>  			  ENTRYTYPE_LOCKED);
>  
> +	INIT_LIST_HEAD(&ocelot_port->skbs);
> +
>  	err = register_netdev(dev);
>  	if (err) {
>  		dev_err(ocelot->dev, "register_netdev failed\n");
> @@ -1669,7 +2160,7 @@ EXPORT_SYMBOL(ocelot_probe_port);
>  int ocelot_init(struct ocelot *ocelot)
>  {
>  	u32 port;
> -	int i, cpu = ocelot->num_phys_ports;
> +	int i, ret, cpu = ocelot->num_phys_ports;
>  	char queue_name[32];
>  
>  	ocelot->lags = devm_kcalloc(ocelot->dev, ocelot->num_phys_ports,
> @@ -1796,6 +2287,18 @@ int ocelot_init(struct ocelot *ocelot)
>  	INIT_DELAYED_WORK(&ocelot->stats_work, ocelot_check_stats);
>  	queue_delayed_work(ocelot->stats_queue, &ocelot->stats_work,
>  			   OCELOT_STATS_CHECK_DELAY);
> +
> +	if (ocelot->ptp) {
> +		ret = ocelot_init_timestamp(ocelot);
> +		if (ret) {
> +			dev_err(ocelot->dev,
> +				"Timestamp initialization failed\n");
> +			return ret;
> +		}
> +
> +		ocelot_vcap_is2_init(ocelot);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(ocelot_init);
> diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
> index 994ba953d60e..ed1583037dc2 100644
> --- a/drivers/net/ethernet/mscc/ocelot.h
> +++ b/drivers/net/ethernet/mscc/ocelot.h
> @@ -11,9 +11,11 @@
>  #include <linux/bitops.h>
>  #include <linux/etherdevice.h>
>  #include <linux/if_vlan.h>
> +#include <linux/net_tstamp.h>
>  #include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/ptp_clock_kernel.h>
>  #include <linux/regmap.h>
>  
>  #include "ocelot_ana.h"
> @@ -46,6 +48,8 @@ struct frame_info {
>  	u16 port;
>  	u16 vid;
>  	u8 tag_type;
> +	u16 rew_op;
> +	u32 timestamp;	/* rew_val */
>  };
>  
>  #define IFH_INJ_BYPASS	BIT(31)
> @@ -54,6 +58,12 @@ struct frame_info {
>  #define IFH_TAG_TYPE_C 0
>  #define IFH_TAG_TYPE_S 1
>  
> +#define IFH_REW_OP_NOOP			0x0
> +#define IFH_REW_OP_DSCP			0x1
> +#define IFH_REW_OP_ONE_STEP_PTP		0x2
> +#define IFH_REW_OP_TWO_STEP_PTP		0x3
> +#define IFH_REW_OP_ORIGIN_PTP		0x5
> +
>  #define OCELOT_SPEED_2500 0
>  #define OCELOT_SPEED_1000 1
>  #define OCELOT_SPEED_100  2
> @@ -401,6 +411,13 @@ enum ocelot_regfield {
>  	REGFIELD_MAX
>  };
>  
> +enum ocelot_clk_pins {
> +	ALT_PPS_PIN	= 1,
> +	EXT_CLK_PIN,
> +	ALT_LDST_PIN,
> +	TOD_ACC_PIN
> +};
> +
>  struct ocelot_multicast {
>  	struct list_head list;
>  	unsigned char addr[ETH_ALEN];
> @@ -450,6 +467,12 @@ struct ocelot {
>  	u64 *stats;
>  	struct delayed_work stats_work;
>  	struct workqueue_struct *stats_queue;
> +
> +	u8 ptp:1;
> +	struct ptp_clock *ptp_clock;
> +	struct ptp_clock_info ptp_info;
> +	struct hwtstamp_config hwtstamp_config;
> +	struct mutex ptp_lock;

Just what does this mutex protect?  Please add a comment.

Thanks,
Richard
