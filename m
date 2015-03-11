Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 05:29:06 +0100 (CET)
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:48592 "EHLO
        e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006154AbbCKE3EmWU8z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 05:29:04 +0100
Received: from /spool/local
        by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <neelegup@linux.vnet.ibm.com>;
        Wed, 11 Mar 2015 09:58:56 +0530
Received: from d28dlp03.in.ibm.com (9.184.220.128)
        by e28smtp05.in.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 11 Mar 2015 09:58:54 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
        by d28dlp03.in.ibm.com (Postfix) with ESMTP id C0F69125805A
        for <linux-mips@linux-mips.org>; Wed, 11 Mar 2015 10:00:18 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
        by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2B4Snmk51249358
        for <linux-mips@linux-mips.org>; Wed, 11 Mar 2015 09:58:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
        by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2B4Snix027642
        for <linux-mips@linux-mips.org>; Wed, 11 Mar 2015 09:58:49 +0530
Received: from localhost.localdomain ([9.124.88.89])
        by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t2B4Sjjh027545;
        Wed, 11 Mar 2015 09:58:46 +0530
Message-ID: <54FFC3EC.7020708@linux.vnet.ibm.com>
Date:   Wed, 11 Mar 2015 09:56:20 +0530
From:   Neelesh Gupta <neelegup@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC V2 04/12] i2c: opal: make use of the new infrastructure
 for quirks
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de> <1424880126-15047-5-git-send-email-wsa@the-dreams.de> <54FF2631.9050006@linux.vnet.ibm.com> <1426029133.17565.9.camel@kernel.crashing.org>
In-Reply-To: <1426029133.17565.9.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15031104-0017-0000-0000-0000040C6E81
Return-Path: <neelegup@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: neelegup@linux.vnet.ibm.com
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


On 03/11/2015 04:42 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-03-10 at 22:43 +0530, Neelesh Gupta wrote:
>> I tested the i2c opal driver after updating the patch as below.
>> Basically I think we can also support write-then-{read/write}
>> for the number of messages = 2.
>> Ben, any issues if we support both write plus read/write in the
>> opal driver ?
> Nope, in fact it's a good idea, I found myself having to expoes such
> an interface to some userspace tool of ours.
>
> However...
>
>> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
>> index 16f90b1..85412ba 100644
>> --- a/drivers/i2c/busses/i2c-opal.c
>> +++ b/drivers/i2c/busses/i2c-opal.c
>> @@ -104,18 +104,8 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>>    		req.buffer_ra = cpu_to_be64(__pa(msgs[0].buf));
>>    		break;
>>    	case 2:
>> -		/* For two messages, we basically support only simple
>> -		 * smbus transactions of a write plus a read. We might
>> -		 * want to allow also two writes but we'd have to bounce
>> -		 * the data into a single buffer.
>> -		 */
>> -		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
>> -			return -EOPNOTSUPP;
> Don't we still want to enforce that the first message is a write ?
> Somebody may not be looking at the quirks...
>
>> -		if (msgs[0].len > 4)
>> -			return -EOPNOTSUPP;
> And that the len is supported...
>
>> -		if (msgs[0].addr != msgs[1].addr)
>> -			return -EOPNOTSUPP;
> Same...
>
> Ie, the quirk indicates to the callers what we support, but we should
> still check that we aren't called with something that doesn't match.

Quirk *also* return error to the user if any of the conditions mismatch with
what we have indicated through the quriks structure...

I think we can't land up here by-passing the check for quirks so above 
checks
are duplicated here..

Neelesh.

>
>> -		req.type = OPAL_I2C_SM_READ;
>> +		req.type = (msgs[1].flags & I2C_M_RD) ?
>> +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
>>    		req.addr = cpu_to_be16(msgs[0].addr);
>>    		req.subaddr_sz = msgs[0].len;
>>    		for (i = 0; i < msgs[0].len; i++)
>> @@ -210,6 +200,11 @@ static const struct i2c_algorithm i2c_opal_algo = {
>>    	.functionality	= i2c_opal_func,
>>    };
>>
>> +static struct i2c_adapter_quirks i2c_opal_quirks = {
>> +	.flags = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADDR,
>> +	.max_comb_1st_msg_len = 4,
>> +};
>> +
>>    static int i2c_opal_probe(struct platform_device *pdev)
>>    {
>>    	struct i2c_adapter	*adapter;
>> @@ -232,6 +227,7 @@ static int i2c_opal_probe(struct platform_device *pdev)
>>
>>    	adapter->algo = &i2c_opal_algo;
>>    	adapter->algo_data = (void *)(unsigned long)opal_id;
>> +	adapter->quirks = &i2c_opal_quirks;
>>    	adapter->dev.parent = &pdev->dev;
>>    	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
>>    	pname = of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
>>
>>
>>
>> On 02/25/2015 09:31 PM, Wolfram Sang wrote:
>>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>
>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>> ---
>>>    drivers/i2c/busses/i2c-opal.c | 22 +++++++++++-----------
>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
>>> index 16f90b1a750894..b2788ecad5b3cb 100644
>>> --- a/drivers/i2c/busses/i2c-opal.c
>>> +++ b/drivers/i2c/busses/i2c-opal.c
>>> @@ -104,17 +104,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>>>    		req.buffer_ra = cpu_to_be64(__pa(msgs[0].buf));
>>>    		break;
>>>    	case 2:
>>> -		/* For two messages, we basically support only simple
>>> -		 * smbus transactions of a write plus a read. We might
>>> -		 * want to allow also two writes but we'd have to bounce
>>> -		 * the data into a single buffer.
>>> -		 */
>>> -		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
>>> -			return -EOPNOTSUPP;
>>> -		if (msgs[0].len > 4)
>>> -			return -EOPNOTSUPP;
>>> -		if (msgs[0].addr != msgs[1].addr)
>>> -			return -EOPNOTSUPP;
>>>    		req.type = OPAL_I2C_SM_READ;
>>>    		req.addr = cpu_to_be16(msgs[0].addr);
>>>    		req.subaddr_sz = msgs[0].len;
>>> @@ -210,6 +199,16 @@ static const struct i2c_algorithm i2c_opal_algo = {
>>>    	.functionality	= i2c_opal_func,
>>>    };
>>>    
>>> +/* For two messages, we basically support only simple
>>> + * smbus transactions of a write plus a read. We might
>>> + * want to allow also two writes but we'd have to bounce
>>> + * the data into a single buffer.
>>> + */
>>> +static struct i2c_adapter_quirks i2c_opal_quirks = {
>>> +	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
>>> +	.max_comb_1st_msg_len = 4,
>>> +};
>>> +
>>>    static int i2c_opal_probe(struct platform_device *pdev)
>>>    {
>>>    	struct i2c_adapter	*adapter;
>>> @@ -232,6 +231,7 @@ static int i2c_opal_probe(struct platform_device *pdev)
>>>    
>>>    	adapter->algo = &i2c_opal_algo;
>>>    	adapter->algo_data = (void *)(unsigned long)opal_id;
>>> +	adapter->quirks = &i2c_opal_quirks;
>>>    	adapter->dev.parent = &pdev->dev;
>>>    	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
>>>    	pname = of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
>
