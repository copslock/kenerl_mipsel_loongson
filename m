Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:45:07 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:65242 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824782Ab3E3SpB6eut7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:45:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id B9D10BFC;
        Thu, 30 May 2013 20:44:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4V3P3dUVL7Ca; Thu, 30 May 2013 20:44:56 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-155-156.dynamic.mnet-online.de [188.174.155.156])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 6795CBF8;
        Thu, 30 May 2013 20:44:55 +0200 (CEST)
Message-ID: <51A79EE3.4040403@metafoo.de>
Date:   Thu, 30 May 2013 20:48:03 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Vinod Koul <vinod.koul@intel.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 6/6] MIPS: jz4740: Remove custom DMA API
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-7-git-send-email-lars@metafoo.de> <20130530172050.GB3767@intel.com>
In-Reply-To: <20130530172050.GB3767@intel.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36655
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

On 05/30/2013 07:20 PM, Vinod Koul wrote:
> On Thu, May 30, 2013 at 06:25:05PM +0200, Lars-Peter Clausen wrote:
>> Now that all users of the custom jz4740 DMA API have been converted to use
>> the dmaengine API instead we can remove the custom API and move all the code
>> talking to the hardware to the dmaengine driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> No changes since v1
>> ---
>>  arch/mips/include/asm/mach-jz4740/dma.h |  56 ------
>>  arch/mips/jz4740/Makefile               |   2 +-
>>  arch/mips/jz4740/dma.c                  | 307 --------------------------------
>>  drivers/dma/dma-jz4740.c                | 258 +++++++++++++++++++++++----
>>  4 files changed, 222 insertions(+), 401 deletions(-)
>>  delete mode 100644 arch/mips/jz4740/dma.c
> only dma.c, you should remove the dma.h or relocate it to linux/

As I said the header only contains the slave ids at this point and the
dmaengine driver doesn't need it anymore. So I should remove the #include from
the driver as well.

> 
> 
> rest of the series looks fine, and once we have acks from repsective subsystem
> mainatiners, we should be good to merge

We already have acks from the maintainers.

- Lars
