Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 00:49:37 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:53945 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008532AbbDFWtgjhkl1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 00:49:36 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YfFpm-0004Jh-Kj
        for linux-mips@linux-mips.org; Tue, 07 Apr 2015 00:49:35 +0200
Received: from [2a02:578:4a04:2a00::5]
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YfFpd-0004J2-H9; Tue, 07 Apr 2015 00:49:25 +0200
Message-ID: <55230D74.3000003@biot.com>
Date:   Tue, 07 Apr 2015 00:49:24 +0200
From:   Bert Vermeulen <bert@biot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Add support for CPLD chip on Mikrotik RB4xx boards
References: <1428285076-14269-1-git-send-email-bert@biot.com> <CAHp75VfeY80hu9kZWJ1KPos7gzTgV53OT-X67MJWT2h8nGSjqw@mail.gmail.com>
In-Reply-To: <CAHp75VfeY80hu9kZWJ1KPos7gzTgV53OT-X67MJWT2h8nGSjqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bert@biot.com
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

Hi Andy,

I will submit a new version with your comments addressed. However this one:

On 04/06/2015 12:13 PM, Andy Shevchenko wrote:

>> +static struct spi_driver rb4xx_cpld_driver = {
>> +       .probe = rb4xx_cpld_probe,
>> +       .remove = rb4xx_cpld_remove,
>> +       .driver = {
>> +               .name = "rb4xx-cpld",
>> +               .bus = &spi_bus_type,
>> +               .owner = THIS_MODULE,
> 
> Do we really need this line?
>
> +       },
> +};
> +
> +module_spi_driver(rb4xx_cpld_driver);

Yes, apparently. It's only the module_platform_driver() macro that
automatically fills in the owner field. All SPI protocol drivers do this
(except one, video/backlight/hx8357.c). Having said that, I don't really get
what that field is used for.


-- 
Bert Vermeulen        bert@biot.com          email/xmpp
