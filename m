Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 11:25:33 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:33243 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3FMJZ3pd3ns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 11:25:29 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D8A1A581F4C;
        Thu, 13 Jun 2013 02:25:26 -0700 (PDT)
Date:   Thu, 13 Jun 2013 02:25:24 -0700 (PDT)
Message-Id: <20130613.022524.568792627006552244.davem@davemloft.net>
To:     florian@openwrt.org
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, mbizon@freebox.fr, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345
 Ethernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
References: <1371066785-17168-1-git-send-email-florian@openwrt.org>
        <20130613.014450.1434692343011842828.davem@davemloft.net>
        <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Florian Fainelli <florian@openwrt.org>
Date: Thu, 13 Jun 2013 09:58:34 +0100

> 2013/6/13 David Miller <davem@davemloft.net>:
>> From: Florian Fainelli <florian@openwrt.org>
>> Date: Wed, 12 Jun 2013 20:53:05 +0100
>>
>>> +#ifdef BCMCPU_RUNTIME_DETECT
>>
>> I want the MIPS folks to fix this brain damange.
>>
>> This runtime detect thing is just a big mess in a header file
>> using hundreds of lines of CPP stuff to express what is fundamentally
>> a simple (albeit sizable) Kconfig dependency.
> 
> The codebase supporting the Broadcom BCM63xx SoC supports about 6-7

You don't need to explain it to me, I read the code and understand
what it's trying to accomplish.

I reject the implementation of it, only.

> No, the ifdefs are kept in the arch/mips/bcm63xx portions of the code
> specifically for that reason. The driver just needs to take into account a
> new set of platform_data properties to deal with this.

Fine, it's still terrible.
