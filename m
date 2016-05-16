Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 19:26:28 +0200 (CEST)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35617 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029155AbcEPR00lR5F0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 19:26:26 +0200
Received: by mail-pf0-f170.google.com with SMTP id 77so69352260pfv.2
        for <linux-mips@linux-mips.org>; Mon, 16 May 2016 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GE6fmIOy87aQCDHez1GzxESqd/Bwx6C0I1bkIyNrs+8=;
        b=clVHTClmyQyIPcmsu8NZXdZM/Ui/FrTtFG6t5xdClVqwjYqqRNPYJPoR4KZd9uVrGk
         /tG+ujTP+v2bcIrvxohhvBQXcxklN/VY5+HPvEvw03xqTJBZDY8dnIHpiu3rpoL1H1UJ
         lm21BMwPrVTehgb851Zdv4vtD0YhtG+7y3f7De8OfdQMpZ0fWXW3sq1lO5DhetSR8FJf
         NtkYpjHb2LtirU26zJcVWd1gBdme2oL/D6HvGn9+3lvX5gnYsAjW3k9eSUz/xNMdeuyq
         /fX81MRGUqVe2c6b8EasPuviRI6Y90/NvtFRKbeUEhxc30cD0Bm3UteQA5T8fKSr2YVh
         EBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GE6fmIOy87aQCDHez1GzxESqd/Bwx6C0I1bkIyNrs+8=;
        b=Bojq+7m9ytUYbRahgH0PNbIwPbJd0o5EydtxBHYeFeOt//48PJkJq/iolOGsgN3xBv
         19BwXdY/SD3eKgzjCa83hH3symkp8Kiywhz8q+8pzxJobax6sXNUoqHV2ZPR3ACeThc0
         S6yoZhCXoZE9ouAGw74+b8eKSsvKkX/nqIWzIU2zIrVWuAVQuRljPgcLePNiRkigIVks
         u4m7/Rtn1qasq0nlYI4KMgloXwrYoonRvDPKizI5v+p2fE8yzHT3Qt82bGQpn50vBEGW
         eY4AmjquHRX5TfUyOUBnRn25GCIuqj3boSNkDYuaKrCrH9Dd1aQvUc1QdEeS9Wh0ZZ/X
         S9Xg==
X-Gm-Message-State: AOPr4FXLnO/PwxSOwcg005VYCYX/SmGpgbxuc8zFM5Savy62y1oMyFDCLEna38JaSkgscg==
X-Received: by 10.98.35.212 with SMTP id q81mr48085763pfj.108.1463419580610;
        Mon, 16 May 2016 10:26:20 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id ba9sm48753712pab.24.2016.05.16.10.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 10:26:19 -0700 (PDT)
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
To:     Andrew Lunn <andrew@lunn.ch>, Rabin Vincent <rabin@rab.in>
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
 <20160516122903.GA27725@lunn.ch>
 <20160516131134.GA31094@lnxartpec.se.axis.com>
 <20160516134042.GD27725@lunn.ch>
Cc:     Rabin Vincent <rabin.vincent@axis.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Rabin Vincent <rabinv@axis.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <573A02BA.3080709@gmail.com>
Date:   Mon, 16 May 2016 10:26:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160516134042.GD27725@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53461
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

On 05/16/2016 06:40 AM, Andrew Lunn wrote:
> On Mon, May 16, 2016 at 03:11:35PM +0200, Rabin Vincent wrote:
>> On Mon, May 16, 2016 at 02:29:03PM +0200, Andrew Lunn wrote:
>>> What i think is better is to make fixed_phy_add() return -EPROBE_DEFER
>>> if it is called before fixed_mdio_bus_init().
>>
>> I don't see how this will work for platforms such as ar7 and bcm47xx
>> which call fixed_phy_add() from platform code.
> 
> Ah! Not good.
> 
> fixed_phy_add() is the lower layer call. What we can do is only access
> fmb->mii_bus->irq[phy_addr] if irq != PHY_POLL. That should make ar7
> and bcm47xx work again.
> 
> The higher level function fixed_phy_register() should return
> -EPROBE_DEFER if fixed_mdio_bus_init() has not been called yet.

ar7 and bcm47xx date back from when the fixed MDIO bus needed its fixed
PHYs to be registered before the MDIO bus driver had a chance to probe
them, otherwise, you would not be able to utilize them. Things have
changed now, and your suggestion makes sense.
-- 
Florian
