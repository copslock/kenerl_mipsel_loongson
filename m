Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2017 23:18:25 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34506
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdGIVSSeBC9i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2017 23:18:18 +0200
Received: by mail-pf0-x241.google.com with SMTP id c24so11856552pfe.1;
        Sun, 09 Jul 2017 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92QcbuGjosYPKpEQXDIHynEzZ5LUp1yfEIDcyns/co4=;
        b=dKjG3tuZU/fzcB0vohDE8KJ4fpKLzi6NvWNSpbuwCnmzCFRTrMfjltntW3zWC4N0Oz
         jRnb2dAW0HYYX5KNCqpQOTOqJK6DQg1RTjUAbBIjhXa7mzc4C/hVJ6kc/QQh8vMG+PZI
         DKqfryJ1ZSYW+CW8e1V+kOa4LdNxSZTRCG/d9LsWHaVzc5GIXLc1KBxnkwvqHeqZ7dgm
         GRyk1oIU9btrJYVVzi5PmMDXm4CNgvfaOr5p/WredgCjIBSPygBsydedYrtaZUFlED3I
         5O3eQ1/OaxXrFqwI2nyFWKqttNeKYvjtedHScl8CknQ6Ti4irbEO8biVE/F8LzJUt0Dw
         QRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92QcbuGjosYPKpEQXDIHynEzZ5LUp1yfEIDcyns/co4=;
        b=BrlO2umvx+/A14Qd5sJqLc7jTT1xpDNk9hYn4yLpO/J+JOpdFOLV5AwIJ+5ZRZbMxj
         I+aoxcnhCMhSC9XZSCJYvHSeTMxsKzjV2Kb2Y8JHC1Vv4O1f22j2YQpfItbvsjFh+sNu
         3ruPsmqeQzcciW/J6wzOO/guVisjwvYQmGg65xPH/jBUkN/ouNVHmoUwzFQP4RRKe+LY
         zdtkhXLfOKsxPfiH61AZ2/MEPN4f6ukkjcWs+mRd3cfX9AHbZyV8fSmdGJO1u3D39xPR
         tyyALNP713BKjNDLiQplaL2Mauk+74Db9fvDcK9iB6yHHLqDrfFoVq4n4jMqQQkKKk8f
         u91Q==
X-Gm-Message-State: AIVw110u/AouPyReEkz7SS8aqEdmONhDCS6hHhhCCHFoK6CVbQsxDThU
        s0zbEd5Hx2t7QwzLP5A=
X-Received: by 10.99.105.200 with SMTP id e191mr11541627pgc.215.1499635092577;
        Sun, 09 Jul 2017 14:18:12 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1311:cbd:69c8:e158:7235])
        by smtp.gmail.com with ESMTPSA id h90sm22159602pfh.133.2017.07.09.14.18.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 14:18:11 -0700 (PDT)
Date:   Sun, 9 Jul 2017 14:18:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 09/10] MIPS: i8042: Probe this device only if it exists
Message-ID: <20170709211809.GB21945@dtor-ws>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-10-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498664922-28493-10-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Wed, Jun 28, 2017 at 05:47:02PM +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> ARCH_MIGHT_HAVE_PC_SERIO is selected by default for MIPS platforms.
> As a consequence SERIO_I8042 would be automatically selected for any
> MIPS board which wants to enable input support like keyboard
> (INPUT_KEYBOARD) regardless of i8042 controller existence.
> 
> The dependency is as follows :
> 
> config ARCH_MIGHT_HAVE_PC_SERIO [=y]
>     Defined at drivers/input/serio/Kconfig:19
>     Depends on: !UML
>     Selected by: MIPS [=y]
> 
> config SERIO
>     Defined at drivers/input/serio/Kconfig:4
>     default y
>     Depends on: !UML
>     Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
>                  INPUT_KEYBOARD [=y]
> 
> config SERIO_I8042
>     Defined at drivers/input/serio/Kconfig:28
>     tristate "i8042 PC Keyboard controller"
>     default y
>     Depends on: !UML && SERIO [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]
>     Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
>                  INPUT_KEYBOARD [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]
> 
> If this driver probes the I8042_DATA_REG not knowing if the device
> exists it can cause a kernel to crash. Using check_legacy_ioport()
> interface we can selectively enable this driver only for the MIPS
> boards which actually have the i8042 controller.
> 
> New "Ranchu" virtual platform does not support i8042 controller
> so it's added to the blacklist match table.
> 
> Each MIPS machine should update this table with it's compatible strings
> if it does not support i8042 controller.
> 
> In order to utilize this mechanism, each MIPS machine that do not
> have i8042 controller should update the blacklist table with its
> compatible strings.
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  arch/mips/kernel/setup.c       | 16 ++++++++++++++++
>  drivers/input/serio/i8042-io.h |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c22cde8..c3e0d2b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -79,6 +79,15 @@ const unsigned long mips_io_port_base = -1;
>  EXPORT_SYMBOL(mips_io_port_base);
>  
>  /*
> + * Here we blacklist all MIPS boards which do not have i8042 controller
> + */
> +static const struct of_device_id i8042_blacklist_of_match[] = {
> +	{ .compatible = "mti,ranchu", },
> +	{},
> +};
> +#define I8042_DATA_REG	0x60
> +
> +/*
>   * Check for existence of legacy devices
>   *
>   * Some drivers may try to probe some I/O ports which can lead to
> @@ -90,9 +99,16 @@ EXPORT_SYMBOL(mips_io_port_base);
>   */
>  int check_legacy_ioport(unsigned long base_port)
>  {
> +	struct device_node *np;
>  	int ret = 0;
>  
>  	switch (base_port) {
> +	case I8042_DATA_REG:
> +		np = of_find_matching_node(NULL, i8042_blacklist_of_match);
> +		if (np)
> +			ret = -ENODEV;
> +		of_node_put(np);
> +		break;

Can you simply mark 8042 region as busy when you are setting up the
board, so when i8042 tries to requets it it will fail?

>  	default:
>  		/* We will assume that the I/O device port exists if
>  		 * not explicitly added to the blacklist match table
> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> index 34da81c..ec5fe9e 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -72,7 +72,7 @@ static inline int i8042_platform_init(void)
>   * On some platforms touching the i8042 data register region can do really
>   * bad things. Because of this the region is always reserved on such boxes.
>   */
> -#if defined(CONFIG_PPC)
> +#if defined(CONFIG_PPC) || defined(CONFIG_MIPS)
>  	if (check_legacy_ioport(I8042_DATA_REG))
>  		return -ENODEV;
>  #endif
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
