Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 00:01:33 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:37680 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994696AbeCFXB00Rmno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 00:01:26 +0100
To:     James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 07 Mar 2018 00:01:25 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Subject: 
In-Reply-To: <20180306091932.GM4197@saruman>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com>
 <20180306091932.GM4197@saruman>
Message-ID: <788bf0bf0d0aaa97f59bc908ebf34ebf@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62826
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

Le 2018-03-06 10:32, James Hogan a écrit :
> On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan 
> wrote:
>> Add RNG node to jz4780 dtsi. This driver uses registers that are part 
>> of
>> the register set used by Ingenic CGU driver. Use regmap in RNG driver 
>> to
>> access its register. Create 'simple-bus' node, make CGU and RNG node 
>> as
>> child of it so that both the nodes are visible without changing CGU
>> driver code.
>> 
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> Better late than never:
> Acked-by: James Hogan <jhogan@kernel.org>
> 
> (I presume its okay for the reg ranges to overlap, ISTR that being an
> issue a few years ago, but maybe thats fixed now).
> 
> Cheers
> James

What bothers me is that the CGU code has not been modified to use 
regmap, so the
registers area is actually mapped twice (once in the CGU driver, once 
with regmap).

Besides, regmap would be useful if the RNG registers were actually 
located in the
middle of the register area used by the CGU driver, which is not the 
case here.
The CGU block does have some registers after the RNG ones on the X1000 
SoC, but
I don't think they will ever be used (and if they are it won't be by the 
CGU driver).

Regards,
-Paul
