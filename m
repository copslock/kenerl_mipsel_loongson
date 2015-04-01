Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 12:03:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36566 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014868AbbDAKD3G6tNm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 12:03:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t31A3Swl020631;
        Wed, 1 Apr 2015 12:03:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t31A3QHv020630;
        Wed, 1 Apr 2015 12:03:26 +0200
Date:   Wed, 1 Apr 2015 12:03:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 0/2] pinctrl: Support for IMG Pistachio
Message-ID: <20150401100326.GA20157@linux-mips.org>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
 <CACRpkdbCOHNPs5Y58h--X6pOVvYyxTrgcFhFyk5dWE+JLo=rhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbCOHNPs5Y58h--X6pOVvYyxTrgcFhFyk5dWE+JLo=rhg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46682
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

On Fri, Mar 06, 2015 at 12:29:55PM +0100, Linus Walleij wrote:
> Date:   Fri, 6 Mar 2015 12:29:55 +0100
> From: Linus Walleij <linus.walleij@linaro.org>
> To: Andrew Bresticker <abrestic@chromium.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>, Ralf Baechle
>  <ralf@linux-mips.org>, "devicetree@vger.kernel.org"
>  <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
>  <linux-gpio@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ezequiel
>  Garcia <ezequiel.garcia@imgtec.com>, James Hartley
>  <james.hartley@imgtec.com>, James Hogan <james.hogan@imgtec.com>
> Subject: Re: [PATCH 0/2] pinctrl: Support for IMG Pistachio
> Content-Type: text/plain; charset=UTF-8
> 
> On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
> 
> >  I'd like this to go through the MIPS tree with
> > Linus'/Alex's ACKs if possible.
> 
> Why? It will only help creating merge conflicts.
> There seem to be no compile-related dependencies, just Kconfig
> symbols, so patches using this can go in orthogonally.

It would mean all the bits for Pistachio support go through a single tree
which simplifies testing and possibly fixing significantly.  The
conflict potencial for this series is fairly low, I think.

  Ralf
