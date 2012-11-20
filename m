Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 09:13:40 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36211 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816668Ab2KTINjwfVL3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Nov 2012 09:13:39 +0100
Message-ID: <50AB3B6C.4000505@phrozen.org>
Date:   Tue, 20 Nov 2012 09:12:28 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org,
        zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 7/8] ssb: add GPIO driver
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1353365877-11131-8-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35055
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


 > +#ifdef CONFIG_SSB_DRIVER_EXTIF

...

> +}
> +
> +#else
> +static int ssb_gpio_extif_init(struct ssb_bus *bus)
> +{
> +	return 0;
> +}
> +#endif

ssb_gpio_extif_init() is also defined as a static inline stub in the 
header files. you should drop this definition from the code file

	John
