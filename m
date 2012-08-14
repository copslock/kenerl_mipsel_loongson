Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 14:56:57 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50088 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903831Ab2HNM4x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 14:56:53 +0200
Message-ID: <502A4AD0.7030106@phrozen.org>
Date:   Tue, 14 Aug 2012 14:55:44 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, hauke@hauke-m.de
Subject: Re: [PATCH 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
References: <1344165123-4640-1-git-send-email-hauke@hauke-m.de> <1344165123-4640-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1344165123-4640-4-git-send-email-hauke@hauke-m.de>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

>  int gpio_to_irq(unsigned gpio)
>  {
> @@ -99,4 +216,11 @@ int gpio_to_irq(unsigned gpio)
>  	}
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(gpio_to_irq);
> +EXPORT_SYMBOL(gpio_to_irq);

can you change this to use gpio_chip.to_irq()

and then #define gpio_to_irq __gpio_to_irq    inside your gpio.h ?

Thanks,
John
