Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 20:27:24 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33988 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029746AbcEQS1VS4Rkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 20:27:21 +0200
Received: by mail-pf0-f196.google.com with SMTP id 145so2640704pfz.1
        for <linux-mips@linux-mips.org>; Tue, 17 May 2016 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GYDlh1K4mz1uFrvR+JnPMzTvNgxscHrnBlRsqxQtkD0=;
        b=MEnlyol5Zvi/gJg6tgJZcwPi9jsQGvmHyfi71Awyls15RHogV6n72R1yRn/WFbXlx9
         qYwf3NClROMiy9paP9TXO9zrT2iTJgrTnGaMSaWtx8lQIPV429kfnmUXXessgfFP89SY
         IWXagDZ5+tTfiPy+GK/o1AfOt6kIocSUgq6ClcMf2rPtW52ryf2ulLjVuUCXRCsgmC52
         sDh5tDQT5a29/IACc/GYfr1Mk7orH4KtuH+nm6YVOpXdvpBrUUojwrALiCKZxMILn3oD
         0sG0BoruvZT69EAaYOyqNysJDijXcbbOzFm5/BAH0YBbaqih+lV8zOn1AbIROj4FWU6R
         quZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GYDlh1K4mz1uFrvR+JnPMzTvNgxscHrnBlRsqxQtkD0=;
        b=hnXtBouKn3txBAkRQ5R6ZY7g4naQfyovB9g54OdzUDQvV/8qceE3nJ0SlvQYx7dJFD
         9jHBrbbe19hXWoeXKd976ZIMK3PGYLGu2jwmlYFHsoaknTbJkbz1KN+gxLkAPnBtHQff
         QtAtc3M8Zs8KsoLSOEE7F2i2fcn67xT4IzXvCg5nPD5Fv8iz8iMKaKU5Os2oEZ3ihYal
         VTgVews+d8/IUYhgTXoXvDP5g4gt6e91vXWZJNU+K5LEc5TcffDuc5ejAwu+nlRog1xf
         xUUK1lzU/4n3IozNNtT5halvY58XoagZB3XG5OaL2ktsrXyazYATjOOhFQiknhKwqd7y
         N76g==
X-Gm-Message-State: AOPr4FWHCl7WHC+4D1TaFqulM1zFmdetutx9yfAFKCjazXs/r2EBZSJ3RLW5xtrzqjQ68Q==
X-Received: by 10.98.67.143 with SMTP id l15mr4161899pfi.114.1463509635199;
        Tue, 17 May 2016 11:27:15 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id yv7sm6414300pab.31.2016.05.17.11.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2016 11:27:14 -0700 (PDT)
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
To:     David Miller <davem@davemloft.net>, rabin.vincent@axis.com
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
 <20160517.142034.611823602956859056.davem@davemloft.net>
Cc:     andrew@lunn.ch, netdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, rabinv@axis.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <573B6280.3030405@gmail.com>
Date:   Tue, 17 May 2016 11:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160517.142034.611823602956859056.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 05/17/2016 11:20 AM, David Miller wrote:
> From: Rabin Vincent <rabin.vincent@axis.com>
> Date: Mon, 16 May 2016 13:15:56 +0200
> 
>> From: Rabin Vincent <rabinv@axis.com>
>>
>> Since e7f4dc3536a ("mdio: Move allocation of interrupts into core"),
>> platforms which call fixed_phy_add() before fixed_mdio_bus_init() is
>> called (for example, because the platform code and the fixed_phy driver
>> use the same initcall level) crash in fixed_phy_add() since the
>> ->mii_bus is not allocated.
>>
>> Also since e7f4dc3536a, these interrupts are initalized to polling by
>> default.  All callers of both fixed_phy_register() and fixed_phy_add()
>> pass PHY_POLL for the irq argument, so we can fix these crashes by
>> simply removing the irq parameter, since the default is correct for all
>> users.
>>
>> Fixes: e7f4dc3536a400 ("mdio: Move allocation of interrupts into core")
>> Signed-off-by: Rabin Vincent <rabinv@axis.com>
> 
> Applied.

David, there was a v2 sent just earlier this morning here:

http://patchwork.ozlabs.org/patch/622967/

which was appropriately marked with Changes Requested, so why would we
apply v1?
-- 
Florian
