Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 08:25:38 +0100 (CET)
Received: from smtp-out-231.synserver.de ([212.40.185.231]:1096 "EHLO
        smtp-out-231.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011100AbbATHZg5ZsCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 08:25:36 +0100
Received: (qmail 21857 invoked by uid 0); 20 Jan 2015 07:25:35 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 21835
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.21?) [88.217.3.222]
  by 217.119.54.87 with AES256-SHA encrypted SMTP; 20 Jan 2015 07:25:35 -0000
Message-ID: <54BE0364.7060404@metafoo.de>
Date:   Tue, 20 Jan 2015 08:27:32 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de> <20150119190142.GA9451@kroah.com> <20150119230427.GH26493@n2100.arm.linux.org.uk> <20150120014159.GA3349@kroah.com> <54BDFE30.5090303@metafoo.de> <20150120071256.GA18983@kroah.com>
In-Reply-To: <20150120071256.GA18983@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 01/20/2015 08:12 AM, Greg Kroah-Hartman wrote:
> On Tue, Jan 20, 2015 at 08:05:20AM +0100, Lars-Peter Clausen wrote:
>> On 01/20/2015 02:41 AM, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 19, 2015 at 11:04:27PM +0000, Russell King - ARM Linux wrote:
>>>> On Tue, Jan 20, 2015 at 03:01:42AM +0800, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
>>>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>>>> index 39d25a8cb1ad..15cc5902cf89 100644
>>>>>> --- a/drivers/i2c/i2c-core.c
>>>>>> +++ b/drivers/i2c/i2c-core.c
>>>>>> @@ -41,7 +41,6 @@
>>>>>>   #include <linux/of_device.h>
>>>>>>   #include <linux/of_irq.h>
>>>>>>   #include <linux/clk/clk-conf.h>
>>>>>> -#include <linux/completion.h>
>>>>>>   #include <linux/hardirq.h>
>>>>>>   #include <linux/irqflags.h>
>>>>>>   #include <linux/rwsem.h>
>>>>>> @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
>>>>>>
>>>>>>   static void i2c_adapter_dev_release(struct device *dev)
>>>>>>   {
>>>>>> -	struct i2c_adapter *adap = to_i2c_adapter(dev);
>>>>>> -	complete(&adap->dev_released);
>>>>>> +	/* empty, but the driver core insists we need a release function */
>>>>>
>>>>> Yeah, it does, but I hate to see this in "real" code as something is
>>>>> probably wrong with it if it happens.
>>>>>
>>>>> Please move the rest of 'i2c_del_adapter' into the release function
>>>>> (what was after the wait_for_completion() call), and then all should be
>>>>> fine.
>>>>
>>>> Are you sure about that?  Some drivers do this, eg,
>>>>
>>>>          i2c_del_adapter(&drv_data->adapter);
>>>>          free_irq(drv_data->irq, drv_data);
>>>>
>>>> where drv_data was allocated using devm_kzalloc(), and so will be
>>>> released when the ->remove callback (which calls the above
>>>> i2c_del_adapter()) returns... freeing the embedded device struct.
>>>
>>> But that will fail today if the memory is freed in i2c_del_adapter(), so
>>> there shouldn't be any change in logic here.
>>>
>>> Or am I missing something obvious?
>>
>> The memory is not freed in i2c_del_adapter().
>
> Right, and I'm not saying it should be, just move the existing logic
> into the release callback, and the code flow should be the same and we
> don't end up with an "empty" release callback.

But the code flow often is.

i2c_del_adapter(&drvdata->adap);
kfree(drvdata);

That wont work anymore if i2c_del_adapter() returns before the last reference 
has been dropped. This needs to be restructured so that the adapter memory can 
be freed by the release callback.
