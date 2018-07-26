Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 21:35:44 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:52692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993008AbeGZTfjr7vN5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jul 2018 21:35:39 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7CBDD20922; Thu, 26 Jul 2018 21:35:32 +0200 (CEST)
Received: from localhost (unknown [88.128.80.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32A7E20908;
        Thu, 26 Jul 2018 21:35:22 +0200 (CEST)
Date:   Thu, 26 Jul 2018 21:35:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: TXx9: remove useless RTC definitions
Message-ID: <20180726193522.GA3074@piout.net>
References: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
 <20180726174015.2brsh3x5abcdqh27@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726174015.2brsh3x5abcdqh27@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 26/07/2018 10:40:15-0700, Paul Burton wrote:
> Hi Alexandre,
> 
> On Thu, Jul 26, 2018 at 06:40:54PM +0200, Alexandre Belloni wrote:
> > The RTC definitions were moved to the driver, remove them from the platform
> > header.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  arch/mips/include/asm/txx9/tx4939.h | 27 ---------------------------
> >  1 file changed, 27 deletions(-)
> 
> Thanks - applied to mips-next for 4.19, with a small change to also
> remove the tx4939_rtc_reg macro.
> 

Ah, thanks, I missed that one as it was not used.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
