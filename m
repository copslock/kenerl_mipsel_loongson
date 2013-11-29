Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 21:39:01 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:45609 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861333Ab3K2Ui7OhRuT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Nov 2013 21:38:59 +0100
Message-ID: <5298FAED.7020408@phrozen.org>
Date:   Fri, 29 Nov 2013 21:37:01 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH V4 1/2] bcma: gpio: add own IRQ domain
References: <1385747290-22575-1-git-send-email-zajec5@gmail.com> <1385752379-19540-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1385752379-19540-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38611
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

On 29/11/13 20:12, Rafał Miłecki wrote:
> +#ifdef CONFIG_BCMA_HOST_SOC
>   	chip->to_irq		= bcma_gpio_to_irq;
> +#endif
>   	chip->ngpio		= 16;


Hi,

Should this not be

if (IS_ENABLED(CONFIG_BCMA_HOST_SOC))
	chip->to_irq = bcma_gpio_to_irq;


	John
