Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 10:05:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58776 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028570AbcEJIF0kPf0v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 10:05:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4A85Pg0017979;
        Tue, 10 May 2016 10:05:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4A85OHM017978;
        Tue, 10 May 2016 10:05:24 +0200
Date:   Tue, 10 May 2016 10:05:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 10/23] MIPS: do away with
 ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Message-ID: <20160510080524.GC16402@linux-mips.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
 <1461142701-21096-11-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1461142701-21096-11-git-send-email-linus.walleij@linaro.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53335
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

On Wed, Apr 20, 2016 at 10:58:08AM +0200, Linus Walleij wrote:

> This replaces:
> 
> - "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
>   now be selected directly.
> 
> - "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
>   is now selectable by everyone, so we need not declare our
>   intent to select it.
> 
> When ordering the symbols the following rationale was used:
> if the selects were in alphabetical order, I moved select GPIOLIB
> to be in alphabetical order, but if the selects were not
> maintained in alphabetical order, I just replaced
> "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".
> 
> Cc: Michael Büsch <m@bues.ch>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Various arch maintainers:
> 
> either ACK this and I will merge it into the GPIO tree for v4.7
> anticipating no clashes, or you wait until I have the enabling patch
> upstream (patch 1 in this series, removing deps on
> ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
> merge it to your arch trees yourselves for late v4.7
> (post GPIO tree merge) or for v4.8.
> 
> You can also ask me for an immutable branch if you prefer that, I
> will put the enabling patch on a branch and the patch for your arch
> on top and ask you to pull it.
> 
> Select your option from the menu, silence probably means I will
> merge it to the GPIO tree. Unless you are X86 or ARM in which case
> I will be cautious.

Warning of the snappish maintainer ;-)

For this one:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
