Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 22:05:38 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44948 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825923Ab2KTVFhiRZCO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2012 22:05:37 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C44E88F61;
        Tue, 20 Nov 2012 22:05:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HCNmpNFvK5FP; Tue, 20 Nov 2012 22:05:29 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:6d1e:baeb:418:870b] (unknown [IPv6:2001:470:1f0b:447:6d1e:baeb:418:870b])
        by hauke-m.de (Postfix) with ESMTPSA id AB94B8F60;
        Tue, 20 Nov 2012 22:05:28 +0100 (CET)
Message-ID: <50ABF095.4020502@hauke-m.de>
Date:   Tue, 20 Nov 2012 22:05:25 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org,
        zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 1/8] bcma: add locking around GPIO register accesses
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-2-git-send-email-hauke@hauke-m.de> <50AB3AFF.2000001@phrozen.org>
In-Reply-To: <50AB3AFF.2000001@phrozen.org>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35059
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

On 11/20/2012 09:10 AM, John Crispin wrote:
> Hi Hauke
> 
>> u32 bcma_chipco_gpio_in(struct bcma_drv_cc *cc, u32 mask)
>>   {
>> -    return bcma_cc_read32(cc, BCMA_CC_GPIOIN)&  mask;
>> +    unsigned long flags;
>> +    u32 res;
>> +
>> +    spin_lock_irqsave(&cc->gpio_lock, flags);
>> +    res = bcma_cc_read32(cc, BCMA_CC_GPIOIN)&  mask;
>> +    spin_unlock_irqrestore(&cc->gpio_lock, flags);
>> +
>> +    return res;
>>   }
>>
> 
> Hi Hauke,
> 
> do you need to lock the read access ?
> 
> if bcma_cc_read32() is a simple memory read wrapper you most likely wont
> need the lock
> 
>     John
Yes you are right, I do not need it here, it is just needed for the
masked write to the other GPIO registers.

Hauke
