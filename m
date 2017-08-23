Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 16:51:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35414 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993892AbdHWOvRArvll (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Aug 2017 16:51:17 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7NEpBVt012762;
        Wed, 23 Aug 2017 16:51:11 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7NEp9Rm012761;
        Wed, 23 Aug 2017 16:51:09 +0200
Date:   Wed, 23 Aug 2017 16:51:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, malat@debian.org, noloader@gmail.com
Subject: Re: [PATCH v2 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
Message-ID: <20170823145109.GA7433@linux-mips.org>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-4-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823025707.27888-4-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Aug 23, 2017 at 08:27:06AM +0530, PrasannaKumar Muralidharan wrote:

> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
> the register set used by Ingenic CGU driver. Make RNG node as child of
> CGU node.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
> Changes in v2:
> * Add "syscon" in CGU node's compatible section
> * Make RNG child node of CGU.
> 
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 6 +++++-

This barely touched arch/mips so probably should be funnelled along with
the rest of the series:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Or I can take everything.

  Ralf
