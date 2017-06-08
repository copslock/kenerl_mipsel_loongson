Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 23:12:22 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60418 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdFHVMOjTXs0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 23:12:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Jun 2017 23:12:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/15] serial: 8250_ingenic: Parse earlycon options
In-Reply-To: <939febde-f962-6e2b-3657-a9b6c719dac1@imgtec.com>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-7-paul@crapouillou.net>
 <939febde-f962-6e2b-3657-a9b6c719dac1@imgtec.com>
Message-ID: <1a2b9e1fcf0f9fbf76bd0d25e8904beb@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,

[...]
>> diff --git a/drivers/tty/serial/8250/8250_ingenic.c 
>> b/drivers/tty/serial/8250/8250_ingenic.c
>> index b31b2ca552d1..59f3e632df49 100644
>> --- a/drivers/tty/serial/8250/8250_ingenic.c
>> +++ b/drivers/tty/serial/8250/8250_ingenic.c
>> @@ -99,14 +99,24 @@ static int __init 
>> ingenic_early_console_setup(struct earlycon_device *dev,
>>   					      const char *opt)
>>   {
>>   	struct uart_port *port = &dev->port;
>> -	unsigned int baud, divisor;
>> +	unsigned int divisor;
>> +	int baud = 115200;
>>     	if (!dev->port.membase)
>>   		return -ENODEV;
>>   +	if (opt) {
>> +		char options[256];
>> +		unsigned int parity, bits, flow; /* unused for now */
>> +
>> +		strlcpy(options, opt, sizeof(options));
> 
> Rather than adding this extra local copy maybe you could instead:
> 
> -void uart_parse_options(char *options, int *baud, int *parity, int 
> *bits,
> +void uart_parse_options(const char *options, int *baud, int *parity, 
> int *bits,
> 
> I cannot see any reason why uart_parse_options shouldn't take 'const
> char *options' as an argument.

Sure, good remark. I'll send a patch to change the prototype.

Thanks,
- Paul
