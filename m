Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 23:20:42 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:60665 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992675AbdF1VUgJxry1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 23:20:36 +0200
Received: from [192.168.10.172] (p579785E8.dip0.t-ipconnect.de [87.151.133.232])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 73D581001DD;
        Wed, 28 Jun 2017 23:20:31 +0200 (CEST)
Subject: Re: BC47xx build errors
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20170627231629.GA5049@linux-mips.org>
 <0acf4ff1-c5b8-adb7-14c1-75a3c56b5164@gmail.com>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <987c7279-c1d7-070d-7494-58c9a043f90e@hauke-m.de>
Date:   Wed, 28 Jun 2017 23:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0acf4ff1-c5b8-adb7-14c1-75a3c56b5164@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58887
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

On 06/28/2017 06:46 AM, Florian Fainelli wrote:
> On 27/06/2017 16:16, Ralf Baechle wrote:
>> A less than smart build test system has flagged the following build error:
>>
>>   CC      arch/mips/bcm47xx/irq.o
>> In file included from arch/mips/bcm47xx/irq.c:32:0:
>> ./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: expected identifier
>> +before
>> +‘}’ token
>>  };
>>
>> I don't have any .config or anything for this error.  While trying to
>> reproduce this error I tried to build bcm47xx_defconfig but with
>> CONFIG_BCM47XX_SSB and CONFIG_BCM47XX_BCMA disabled.  That resulted in
>> the following build error:
> 
> I am not sure if we should define an invalid bus type enum value just to
> avoid creating an empty enum or simply making sure that neither
> CONFIG_BCM47XX_SSB nor CONFIG_BCM47XX_BCMA can be disabled with
> CONFIG_BCM47XX, as clearly this would not result in a functioning
> kernel, Rafal, Hauke, thoughts?
> 

What about adding a BUILD_BUG() with a message when neither SSB or BCMA
support is selected?

The kernel will be unusable anyway and you also can not test compile
anything which you could not test compile with bcma or ssb selected.

Hauke
