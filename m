Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:42:19 +0200 (CEST)
Received: from smtp-out-158.synserver.de ([212.40.185.158]:1056 "EHLO
        smtp-out-158.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815758Ab3DJNmR61vKH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 15:42:17 +0200
Received: (qmail 20789 invoked by uid 0); 10 Apr 2013 13:42:16 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 20670
Received: from p4fe61d6b.dip.t-dialin.net (HELO ?192.168.0.176?) [79.230.29.107]
  by 217.119.54.96 with AES256-SHA encrypted SMTP; 10 Apr 2013 13:42:16 -0000
Message-ID: <51656C04.6070105@metafoo.de>
Date:   Wed, 10 Apr 2013 15:41:24 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 16/18] MIPS: ralink: add support for periodic timer irq
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-17-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365594447-13068-17-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 04/10/2013 01:47 PM, John Crispin wrote:
> +
> +static int rt_timer_request(struct rt_timer *rt)
> +{
> +	int err = request_irq(rt->irq, rt_timer_irq, IRQF_DISABLED,

IRQF_DISABLED is deprecated and a no-op these dats since all interrupts run
with IRQs disabled, it shouldn't be used in new code.

> +						dev_name(rt->dev), rt);
> +	if (err) {
> +		dev_err(rt->dev, "failed to request irq\n");
> +	} else {
> +		u32 t = TMR0CTL_MODE_PERIODIC | TMR0CTL_PRESCALE_VAL;
> +		rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
> +	}
> +	return err;
> +}
