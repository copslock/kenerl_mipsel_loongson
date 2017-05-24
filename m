Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 18:02:14 +0200 (CEST)
Received: from mout.web.de ([212.227.15.14]:60296 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993953AbdEXQCEVAEPg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 18:02:04 +0200
Received: from [192.168.1.2] ([92.228.187.15]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1DVw-1e6TjZ2g0m-00tCei; Wed, 24
 May 2017 18:01:41 +0200
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed memory
 allocation in octeon_irq_init_gpio()
To:     Joe Perches <joe@perches.com>
Cc:     linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
 <1495565752.2093.69.camel@perches.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <71a2ce6a-968c-b13c-95b0-610f0c1bab03@users.sourceforge.net>
Date:   Wed, 24 May 2017 18:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1495565752.2093.69.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:FOA8UjbqGn7bOY8fyJrCdLfSxyEQYFcM5MGhgSiaZqilO+EjDNx
 03+uJhRL9MV5d2VudkaFEK/6QXatkRm/wpBozxHfgGXUWUETrsmeofOtx6ONPBSX1vWxijc
 b+GLiqhqigdX4nCX63yaVT+606vKE/5bPGwmCnXCw/vcbe3yJdT9/iM5j8qmEj/0b67sjGX
 uIDhnbLwztEtjYQSOSR3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oXOGvMpPuqs=:sYaq6WgFdwP2y0E+M8T88K
 yXTWnFt3mxYk9akwiTNq7jxEA2pAEM+wvmYpGOjlqVZOuJ9qpF/8gVa4XNsrxqYpplBWAp7SS
 1nD9WrD9z4MiFe+ASf6W7iLmUM9HtWG/TdwG85Psx3tlwqtYqo37LWYKuYfexqHJsomKvPnUj
 LFxHATSFY2SMSEX8mLQCIg+t5pY7mt3aTIcOGPu1r/w9H0gMjqzIrh9AWKOtthXOVMX8cWH3Q
 OGl34Vov5+P3EKlZi4axiEXeIpeqEHL1Yr1mKtLhsObr74McAxHk//o6Q5Pf3qkD47qbrxgmP
 UrzCqpWABHMHIW6T8lwmwNm4vV8TP0c3ziR9jVDUipjDY6Flv/NfD4i4RMMhUNTz7DeqMqRWq
 MG2sa4efrqs9FwkvKxuAlvv6Ze6JOWHXQnz09bg0DLKVwZHWO2oqW+jt1rG3zwIAJzJngUzby
 +IU81I6kRE2BjUupAMF0Nd3AG4FeaacJffhb5YPBAn7/0lAC59Ymqwi4jJiF5JvvP8Mc0gjQw
 zrbLqTrhHOTwZ+pDRrRCgK7cbgbiWiwM+dZLPB0mc9q1PFD5Xy+bO2rYKumH6Caie2V5cbf8o
 lrzyc6vDXmGyEWRyVt7epTxZmuVEz/QSttvgQki8XHZSeypUifhxJgI76Uvkpl5BvBve/1mJ/
 Y1nGOiuSyxiXb6I6OayAWA2iXhz8akrQyezv57H80/zri8SbIV9GNegEiE8MUvUC+pkHYW90B
 zuHk8BH2ASvAnA3h1dxbzLmmF/J+rX82YCSa6FUt+6QzaWbN9sx1UB5URf4ZDlMJsQvUirFc1
 iNTkZOa
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>> @@ -1615,7 +1615,6 @@ static int __init octeon_irq_init_gpio(
>>  		irq_domain_add_linear(
>>  			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
>>  	} else {
>> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
>>  		return -ENOMEM;
>>  	}
> 
> You really should reverse the test here and
> unindent the first block.

Thanks for your improved source code transformation.

I am curious if I will stumble on a similar change possibility once more
for remaining update candidates in other software areas.

Regards,
Markus
