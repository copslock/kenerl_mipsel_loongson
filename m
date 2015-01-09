Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 22:05:18 +0100 (CET)
Received: from mail-la0-f52.google.com ([209.85.215.52]:42806 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010751AbbAIVFQFVEi7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 22:05:16 +0100
Received: by mail-la0-f52.google.com with SMTP id hs14so17051196lab.11
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2015 13:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ecMGYd0JPndrsydtkTkh4ImHNtfJrQkuFC3tHQp4vBE=;
        b=AWWgzyf4WjcEOzfrXosgcTsl41MxuqLKqRaEGO7GsVkOAql42dXGOb3ehz3B28Nphu
         1mex4QFUQrq5+Cd086pJEwpboVpuBN5LYThA9iVSL+jBDyMAPrBDv2i00k699vCxa7NC
         VgHwjFkNuMGB0Ag8jgdbnCthnGhCXzxBZrI0/ZIobRifqq7nXMksEfyVM2Vev3GgBaw0
         mtGZvayYImqjauCOr/1zU6W12BkEF+r/eioWligB1CcrYzftrAoNjdcwdi0UftsxAC0r
         KpYQ+VxI/Ss9aYef+DKFrL++sfrqUQTZAUxbP8TqOPqdK7Ei6M2BLvoAZWApLG7pTCUD
         bV7w==
X-Gm-Message-State: ALoCoQkyQY2DlceFyDYwU/rfzUauYjophHcNf13EjFSm1Aw9mtI1lZioWK3FLqhfqdrB0dZfXAuB
X-Received: by 10.152.26.201 with SMTP id n9mr24091032lag.50.1420837510625;
        Fri, 09 Jan 2015 13:05:10 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp20-191.pppoe.mtu-net.ru. [81.195.20.191])
        by mx.google.com with ESMTPSA id r5sm2095015lae.34.2015.01.09.13.05.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 13:05:09 -0800 (PST)
Message-ID: <54B04283.5070705@cogentembedded.com>
Date:   Sat, 10 Jan 2015 00:05:07 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de> <1420824103-24169-3-git-send-email-wsa@the-dreams.de> <54B02D7F.7040501@cogentembedded.com> <20150109204522.GB1904@katana>
In-Reply-To: <20150109204522.GB1904@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/09/2015 11:45 PM, Wolfram Sang wrote:

>>> Let the core do the checks if HW quirks prevent a transfer. Saves code
>> >from drivers and adds consistency.

>>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>>> ---
>>>   drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> index 39d25a8cb1ad..7b10a19abf5b 100644
>>> --- a/drivers/i2c/i2c-core.c
>>> +++ b/drivers/i2c/i2c-core.c
>>> @@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
>>>    * ----------------------------------------------------
>>>    */
>>>
>>> +/* Check if val is exceeding the quirk IFF quirk is non 0 */
>>> +#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
>>> +
>>> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
>>> +{
>>> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
>>> +	return -EOPNOTSUPP;
>>> +}

>>     Always returning the same value doesn't make much sense. Are you trying
>> to save space on the call sites?

> Please elaborate. I think it does. If a quirk matches, we report that we
> don't support this transfer.

    OK, but what's the point of having this function return *int* if it always 
returns the same value? AFAIU, you're trying to save the code space on the 
call sites of this function by not having *return* -EOPNOTSUPP there each time?

>> [...]
>>> @@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>>>   	unsigned long orig_jiffies;
>>>   	int ret, try;
>>>
>>> +	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))

>>     So, you only check for non-zero result of this function? Perhaps it makes
>> sense to return true/false instead?

> Could be done, but what would be the advantage? A lot of functions
> return errno or 0.

    It would have been OK if you were actually caring about the result, e.g. 
returning it from __i2c_transfer(). Since you don't, IMO it would make more 
sense to return true from i2c_check_for_quirks() (making it *bool*) iff it did 
find/apply a quirk.

WBR, Sergei
