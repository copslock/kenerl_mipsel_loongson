Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 19:30:13 +0200 (CEST)
Received: from smtp-out-079.synserver.de ([212.40.185.79]:1042 "EHLO
        smtp-out-079.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835108Ab3FJRaKhydKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 19:30:10 +0200
Received: (qmail 23931 invoked by uid 0); 10 Jun 2013 17:30:08 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 23871
Received: from ppp-93-104-174-180.dynamic.mnet-online.de (HELO ?192.168.178.26?) [93.104.174.180]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 10 Jun 2013 17:30:07 -0000
Message-ID: <51B60D25.2000302@metafoo.de>
Date:   Mon, 10 Jun 2013 19:30:13 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 4/6] MIPS: jz4740: Register jz4740 DMA device
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-5-git-send-email-lars@metafoo.de> <51A78B45.1060604@cogentembedded.com>
In-Reply-To: <51A78B45.1060604@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36814
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

On 05/30/2013 07:24 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/30/2013 08:25 PM, Lars-Peter Clausen wrote:
> 
>> Register a device for the newly added jz4740 dmaengine driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> [...]
>>   3 files changed, 23 insertions(+)
>> diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
>> index e9348fd..35a9d8c 100644
>> --- a/arch/mips/jz4740/platform.c
>> +++ b/arch/mips/jz4740/platform.c
>> @@ -329,3 +329,24 @@ struct platform_device jz4740_pwm_device = {
> [...]
>> +struct platform_device jz4740_dma_device = {
>> +    .name    = "jz4740-dma",
>> +    .id    = -1,
> 
>    Why not align all = in this structure?
> 

Will fix that in the next version, thanks.

- Lars
