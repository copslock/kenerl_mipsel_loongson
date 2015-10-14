Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 17:57:29 +0200 (CEST)
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1054 "EHLO
        smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010412AbbJNP51nYySw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 17:57:27 +0200
Received: (qmail 26085 invoked by uid 0); 14 Oct 2015 15:57:26 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 26047
Received: from p4fde7f29.dip0.t-ipconnect.de (HELO ?192.168.2.127?) [79.222.127.41]
  by 217.119.54.96 with AES128-SHA encrypted SMTP; 14 Oct 2015 15:57:25 -0000
Message-ID: <561E7B65.3090704@metafoo.de>
Date:   Wed, 14 Oct 2015 17:57:25 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     ralf@linux-mips.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-mips@linux-mips.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com> <20151014151813.GL15287@xsjsorenbubuntu>
In-Reply-To: <20151014151813.GL15287@xsjsorenbubuntu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49551
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

On 10/14/2015 05:18 PM, Sören Brinkmann wrote:
> On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:
>> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>> ---
>>  drivers/gpio/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 8949b3f..58e9afd 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -508,7 +508,7 @@ config GPIO_XGENE_SB
>>  
>>  config GPIO_XILINX
>>  	tristate "Xilinx GPIO support"
>> -	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
>> +	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86 || MIPS)
> 
> Hmm, in general, this driver is hopefully generic enough that it doesn't
> have any real architecture dependencies. And I suspect, we want to
> enable this driver for ARM64 for ZynqMP soon too. Should we probably
> drop these arch dependencies completely? It seems to become quite a long list.

I've been thinking about this a while ago. This is certainly not the only
driver affected by this problem. But the thing is people always complain if
new symbols become visable in Kconfig that don't apply to their platform.

Maybe we should introduce a HAS_REPROGRAMABLE_LOGIC (or similar) feature
Kconfig symbol and let platforms which have a FPGA select it and let drivers
for FPGA peripherals depend on it.

- Lars
