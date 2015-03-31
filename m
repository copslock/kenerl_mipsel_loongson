Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 16:00:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57310 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014819AbbCaOAfqVFBW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 16:00:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VE0ZH9022138;
        Tue, 31 Mar 2015 16:00:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VE0YO4022134;
        Tue, 31 Mar 2015 16:00:34 +0200
Date:   Tue, 31 Mar 2015 16:00:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH V2 0/3] pinctrl: Support for IMG Pistachio
Message-ID: <20150331140034.GE28951@linux-mips.org>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46649
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

On Mon, Mar 30, 2015 at 04:16:53PM -0700, Andrew Bresticker wrote:

> This series adds support for the system pin and GPIO controller on the IMG
> Pistachio SoC.  Pistachio's system pin controller manages 99 pins, 90 of
> which are MFIOs which can be muxed between multiple functions or used
> as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
> of 16.  Pistachio also has a second pin controller, the RPU pin controller,
> which will be supported by a future patchset through an extension to this
> driver.
> 
> Test on an IMG Pistachio BuB.  Based on mips-for-linux-next which inluces my
> series adding Pistachio platform support [1].  A branch with this series is
> available at [2].

Does this mean you want me to funnel this through the MIPS tree?  If so,
could I have an Ack from the maintainers?

Thanks,

  Ralf
