Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 00:34:03 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40575 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903515Ab2HPWd5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 00:33:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 00F273EE18;
        Fri, 17 Aug 2012 00:33:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kp8Nek3mTxME; Fri, 17 Aug 2012 00:33:52 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:2a:1be:14a6:74fa] (unknown [IPv6:2001:470:1f0b:447:2a:1be:14a6:74fa])
        by hauke-m.de (Postfix) with ESMTPSA id 882D83EE16;
        Fri, 17 Aug 2012 00:33:52 +0200 (CEST)
Message-ID: <502D754F.9090908@hauke-m.de>
Date:   Fri, 17 Aug 2012 00:33:51 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de> <1345132801-8430-4-git-send-email-hauke@hauke-m.de> <502D4B70.4010509@phrozen.org>
In-Reply-To: <502D4B70.4010509@phrozen.org>
X-Enigmail-Version: 1.5a1pre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 08/16/2012 09:35 PM, John Crispin wrote:
> On 16/08/12 18:00, Hauke Mehrtens wrote:
>> int gpio_get_value(unsigned gpio)
>> +{
>> +	if (gpio < bcm47xx_gpio_count)
>> +		return bcm47xx_gpio_in(1 << gpio);
>> +
>> +	return __gpio_get_value(gpio);
>> +}
>> +EXPORT_SYMBOL(gpio_get_value);
> 
> Hi,
> 
> You are using a gpio_chip. simply doing this
> 
> #define gpio_get_value __gpio_get_value
> 
> inside your arch/mips/include/asm/mach-bcm47xx/gpio.h will be enough.
> __gpio_get_value() will then automatically find and use
> bcm47xx_gpio_get_value() via the gpio_chip.

With this code gpio_get_value() is faster as the hole gpiolib is not
called for the get and set methods. I assume then these gpios are the
first being registered and all calls to these gpios are directly handled
by this methods and are not going through the gpiolib code.
This is based on the way it is done for ath79.

Hauke
