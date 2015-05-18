Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 23:41:09 +0200 (CEST)
Received: from nn-mx.auriga.ru ([81.19.133.66]:55548 "EHLO nn-mx.auriga.ru"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013022AbbERVlIO-0CM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 May 2015 23:41:08 +0200
Received: from [IPv6:::1] (unknown [192.168.150.24])
        by nn-mx.auriga.ru (Postfix) with ESMTP id D384F1FFF9;
        Tue, 19 May 2015 00:40:44 +0300 (MSK)
Message-ID: <555A5C5C.9090903@auriga.com>
Date:   Mon, 18 May 2015 14:40:44 -0700
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com> <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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



On 05/18/2015 02:05 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Mar 16, 2015 at 06:06:00PM +0300, Aleksey Makarov wrote:
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> eMMC, MMC and SD devices are supported.
>>
>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>> Signed-off-by: Peter Swain <pswain@cavium.com>
>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>> ---
>
> Any updates on this patch? Are you still working on it for
> the mainline kernel inclusion?
>
> A:
> .

We are working on it.  It will also be used in ARM ThunderX arch.  So we 
will send a new version soon.

We need to decide on what to do with the objections to the way we use 
device tree.

Thank you
Aleksey Makarov
