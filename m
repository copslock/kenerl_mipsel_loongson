Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 20:58:51 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:32922
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993980AbdF2S6oh8wDL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 20:58:44 +0200
Received: by mail-pf0-x243.google.com with SMTP id e199so14208874pfh.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gjntR6yVzs053RdyIkImoCi5RU51uyyysW5L7vaTVbg=;
        b=n4fsVVqhpkEdraVH8lr/MjVz2Tvg/xBdj7WCd/AGOkyuydjY3lPqLwPawpOcGDJC/s
         8Nt9HzVCEgyi7lP6Q/S+Ufi99Mb+JZpmHUGlUqdsrnij23LwJhgNENhqLrk+vC77Pkyf
         g+kDWwqQiZqs6V9QY7uWUGpCZMAXar5hhGH2/t8vzFgK2FXtEPZohXX7dyTJ36MuCmZh
         ZOIVzpSqPaIDzK8n4MxYnx0PBtPz8NoqbXPWMKSEoaR7sFhR/8Es3MAauvhvx0BfJlFd
         o+/l0TRcxmia4mBUz0VxkMMWSgPBbwfw6SNfIgy94bwRNgjS/JnNoVLiH2SOeKXXxSQ5
         gNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gjntR6yVzs053RdyIkImoCi5RU51uyyysW5L7vaTVbg=;
        b=sgSOWoz/Lta2kp6AfMHTnAcMfcA8i5oVzMe/1+u44PJjzKRG278qjh35ayTJjlFf1R
         lgDV5DUeCR4zb9OsvYdM0RNG5HrQ/GSUOs9erUdu4jX/VwNi/2x1884FWWx/29UbDgjm
         HMfegDL4FHel82krRHIFrP6cL5Mjtt/N5sF5w6KFh6cTQ12A95jr3k5vyJ5SM4j9Lb4D
         QKRWnY5jlGEzHiopU8Oe9or/qkvTV0t+aQhpkkTlw/47Cnm62YvcBaiUHyxvlFiRjR34
         DdmzPLuEjcY6lmSalbv54R8xvYhEuUjcfwNDorW08mc3EGx4Tt40e4sAMtGcJ2rMl/G0
         JmAg==
X-Gm-Message-State: AKS2vOze70tjdL2I1tPrNq6tXK/PShtyIKllkl+VA8Gpt8Yzu9xCQs5S
        dPEe1P7iBg71sQsMvts=
X-Received: by 10.98.76.145 with SMTP id e17mr17899769pfj.78.1498762718560;
        Thu, 29 Jun 2017 11:58:38 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1311:145f:bb89:aeca:cbe])
        by smtp.gmail.com with ESMTPSA id c63sm14672895pfk.79.2017.06.29.11.58.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:58:37 -0700 (PDT)
Date:   Thu, 29 Jun 2017 11:58:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, Lingfeng Yang <lfy@google.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v2 5/7] input: goldfish: Fix multitouch event handling
Message-ID: <20170629185835.GB38388@dtor-ws>
References: <1498665399-29007-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498665399-29007-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498665399-29007-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58908
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

On Wed, Jun 28, 2017 at 05:56:29PM +0200, Aleksandar Markovic wrote:
> From: Lingfeng Yang <lfy@google.com>
> 
> Register Goldfish Events device properly as a multitouch device,
> and send SYN_REPORT event in appropriate cases only.
> 
> If SYN_REPORT is sent on every single multitouch event, it breaks
> the multitouch. The multitouch becomes janky and having to click
> 2-3 times to do stuff (plus randomly activating notification bars
> when not clicking).

This sounds like a deficiency in protocol handling in userspace. Given
that input core can suppress duplicate events userpsace mught very well
only see one ABS_X followed by SYN_REPORT if Y coordinate did not change
or was suppressed by jitter detection.

> If these SYN_REPORT events are supressed,
> multitouch will work fine, plus the events will have a protocol
> that looks nice.
> 
> In addition, Goldfish Events device needs to be registerd as a
> multitouch device by issuing input_mt_init_slots. Otherwise,
> input_handle_abs_event in drivers/input/input.c will silently drop
> all ABS_MT_SLOT events, casusing touches with more than one finger
> not to work properly.
> 
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  drivers/input/keyboard/goldfish_events.c | 33 +++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
> index f6e643b..6e0b8bb 100644
> --- a/drivers/input/keyboard/goldfish_events.c
> +++ b/drivers/input/keyboard/goldfish_events.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/input.h>
> +#include <linux/input/mt.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -24,6 +25,8 @@
>  #include <linux/io.h>
>  #include <linux/acpi.h>
>  
> +#define GOLDFISH_MAX_FINGERS 5
> +
>  enum {
>  	REG_READ        = 0x00,
>  	REG_SET_PAGE    = 0x00,
> @@ -52,7 +55,22 @@ static irqreturn_t events_interrupt(int irq, void *dev_id)
>  	value = __raw_readl(edev->addr + REG_READ);
>  
>  	input_event(edev->input, type, code, value);
> -	input_sync(edev->input);
> +
> +	/*
> +	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event if a key
> +	 * was pressed. Some keyboard device drivers may only send
> +	 * the EV_KEY event and not EV_SYN.

Can they be fixed?

> +	 *
> +	 * Note that sending an extra SYN_REPORT is not necessary
> +	 * nor correct protocol with other devices such as
> +	 * touchscreens, which will send their own SYN_REPORT's
> +	 * when sufficient event information has been collected
> +	 * (e.g., for touchscreens, when pressure and X/Y coordinates
> +	 * have been received). Hence, we will only send this extra
> +	 * SYN_REPORT if type == EV_KEY.
> +	 */
> +	if (type == EV_KEY)
> +		input_sync(edev->input);

Ideally we would not be sending synthetic EV_SYN at all...

>  	return IRQ_HANDLED;
>  }
>  
> @@ -155,6 +173,19 @@ static int events_probe(struct platform_device *pdev)
>  	input_dev->name = edev->name;
>  	input_dev->id.bustype = BUS_HOST;
>  
> +	/*
> +	 * Set the Goldfish Device to be multitouch.
> +	 *
> +	 * In the Ranchu kernel, there is multitouch-specific code
> +	 * for handling ABS_MT_SLOT events (see
> +	 * drivers/input/input.c:input_handle_abs_event).
> +	 * If we do not issue input_mt_init_slots, the kernel will
> +	 * filter out needed ABS_MT_SLOT events when we touch the
> +	 * screen in more than one place, preventing multitouch with
> +	 * more than one finger from working.
> +	 */
> +	input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);

This needs error handling. Also, can the backend communicate number of
slots so the userspace has better idea about the capabilities of the
device?

> +
>  	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
>  	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
>  	events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
