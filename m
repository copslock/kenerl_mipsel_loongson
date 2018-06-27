Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2018 23:37:00 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:56854 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993081AbeF0VguTS0Be (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jun 2018 23:36:50 +0200
Subject: Re: Applied "spi: ath79: drop pdata support" to the spi tree
To:     Paul Burton <paul.burton@mips.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20180625171823.4782-1-john@phrozen.org>
 <20180626145959.C26D7440070@finisterre.ee.mobilebroadband>
 <20180627160723.bhdiz5xmuuuz6fnr@pburton-laptop>
From:   John Crispin <john@phrozen.org>
Message-ID: <d09b22ce-8805-cf26-7d4e-be127ad15a0a@phrozen.org>
Date:   Wed, 27 Jun 2018 23:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627160723.bhdiz5xmuuuz6fnr@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 27/06/18 18:07, Paul Burton wrote:
> Hi Mark,
>
> On Tue, Jun 26, 2018 at 03:59:59PM +0100, Mark Brown wrote:
>> The patch
>>
>>     spi: ath79: drop pdata support
>>
>> has been applied to the spi tree at
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> This is going to be problematic if it goes in before the corresponding
> conversion of the MIPS platform code to use device tree, which is
> currently being reviewed.
>
> To quote John's patch email:
>
>> Hi Mark,
>> Once Acked, this patch should ideally go upstream via the mips tree to
>> avoid merge order conflicts with the series converting the target to
>> OF.
>>          John
> Could you possibly drop this from your tree & ack it to go through the
> MIPS tree along with the relevant platform/board changes?
>
> Thanks,
>      Paul

Hi Paul,
Mark dropped the patch and Ack'ed it for being merged via the LMO tree
     John
