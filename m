Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 11:57:27 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37202 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832092Ab3FMJzuAfeWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 11:55:50 +0200
Received: by mail-pd0-f171.google.com with SMTP id y14so8262171pdi.30
        for <multiple recipients>; Thu, 13 Jun 2013 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=0ciDLZFEWNIboOx7mdD7jtvYY1g1v8EH9r4Rp4qsO/s=;
        b=C/doK7NzEevr0XhRAjxxlqkE+oNv1ES+TJClnaGybU7ZrXR/tKLrHs8kz+5e7eDyes
         DH/T9u/dUdNSPVT9YQZzGRjEq9S5v1LDnxt3v8v1U3JILw4oQAABEqKkSkh8jqNC4hyT
         fl1c5HaqhtNiBImAptjf9bT8nDmw0CXzn8CQco249hqU5n/jgppPTCPc6PIy4Lpv1gK4
         2r8B1gFvXtHbJVYTVlQA2HqQV18E19EUL8D/aKe9Edp+UTg5esOKYkAjB73L/QSJET/8
         krmVXew0zWIeoMJNRREBQTotNQPcUw/N3R/1TCVVO5cKKlKZyRR9yyiWycgWre20DPKA
         sO6A==
X-Received: by 10.68.178.66 with SMTP id cw2mr123534pbc.47.1371117341633; Thu,
 13 Jun 2013 02:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.69.17.33 with HTTP; Thu, 13 Jun 2013 02:55:01 -0700 (PDT)
In-Reply-To: <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
References: <1371066785-17168-1-git-send-email-florian@openwrt.org>
 <20130613.014450.1434692343011842828.davem@davemloft.net> <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
 <20130613.022524.568792627006552244.davem@davemloft.net> <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 13 Jun 2013 10:55:01 +0100
X-Google-Sender-Auth: 6UjzsaGRaYWpaCg0Ac3Ccs24Sr0
Message-ID: <CAGVrzcbBqdy+NnbV_TWWf=bigpbYqPXktCVVOFhtBgvFkCrWgA@mail.gmail.com>
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345 Ethernet
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        mbizon <mbizon@freebox.fr>, jogo@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/6/13 Florian Fainelli <florian@openwrt.org>:
> 2013/6/13 David Miller <davem@davemloft.net>
>>
>> From: Florian Fainelli <florian@openwrt.org>
>> Date: Thu, 13 Jun 2013 09:58:34 +0100
>>
>> > 2013/6/13 David Miller <davem@davemloft.net>:
>> >> From: Florian Fainelli <florian@openwrt.org>
>> >> Date: Wed, 12 Jun 2013 20:53:05 +0100
>> >>
>> >>> +#ifdef BCMCPU_RUNTIME_DETECT
>> >>
>> >> I want the MIPS folks to fix this brain damange.
>> >>
>> >> This runtime detect thing is just a big mess in a header file
>> >> using hundreds of lines of CPP stuff to express what is fundamentally
>> >> a simple (albeit sizable) Kconfig dependency.
>> >
>> > The codebase supporting the Broadcom BCM63xx SoC supports about 6-7
>>
>> You don't need to explain it to me, I read the code and understand
>> what it's trying to accomplish.
>>
>> I reject the implementation of it, only.
>>

You have marked the patch as Rejected in patchwork, so what is the
right way to move on with this?
