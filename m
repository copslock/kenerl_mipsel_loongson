Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 05:59:41 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60613 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3DPD7k3ms0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 05:59:40 +0200
Message-ID: <516CCBBA.8000103@openwrt.org>
Date:   Tue, 16 Apr 2013 05:55:38 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org> <1365845618-16040-2-git-send-email-blogic@openwrt.org> <20130415181402.GA25194@kroah.com>
In-Reply-To: <20130415181402.GA25194@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 15/04/13 20:14, Greg Kroah-Hartman wrote:
> On Sat, Apr 13, 2013 at 11:33:36AM +0200, John Crispin wrote:
>> In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
>> the iotype to UPIO_RT.
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> ---
>>   drivers/tty/serial/of_serial.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
>> index b025d54..42f8550 100644
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>   		port->regshift = prop;
>>
>>   	port->irq = irq_of_parse_and_map(np, 0);
>> -	port->iotype = UPIO_MEM;
>> +	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
>> +		port->iotype = UPIO_AU;
>> +	else
>> +		port->iotype = UPIO_MEM;
> Why are you putting device-specific things into a generic driver?
> Shouldn't this be able to be described in device tree without relying on
> an vendor-specific test in this driver?
>
> greg k-h
>
>
Hi Greg,

would 'reg-io-type = "au";' sound better to you ?

     John
