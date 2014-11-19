Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 11:12:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35082 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012949AbaKSKMGH5AMG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 11:12:06 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAJAC0C0008264;
        Wed, 19 Nov 2014 11:12:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAJABwSk008263;
        Wed, 19 Nov 2014 11:11:58 +0100
Date:   Wed, 19 Nov 2014 11:11:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH V4 2/6] MIPS: Move Loongson GPIO driver to drivers/gpio
Message-ID: <20141119101157.GB7213@linux-mips.org>
References: <1415891560-8915-1-git-send-email-chenhc@lemote.com>
 <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
 <CAAVeFuJoo3X9aNYdrn5TJ-PjTzvFuEm5QTPmKYMy9NyWFy1_WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVeFuJoo3X9aNYdrn5TJ-PjTzvFuEm5QTPmKYMy9NyWFy1_WA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44286
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

On Wed, Nov 19, 2014 at 05:21:56PM +0900, Alexandre Courbot wrote:

> > On Fri, Nov 14, 2014 at 12:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
> >> Move Loongson-2's GPIO driver to drivers/gpio and add Kconfig options.
> >
> > Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> >
> > Guess this should go through the GPIO tree once the platform
> > maintainers have acked this?
> 
> Ouch. After looking at this driver's implementation I think I have to
> take my Ack back. This driver comes with custom definitions of
> gpio_get_value() and other functions, which we will want to get rid of
> before moving this into drivers/gpio. Can you port this to a proper
> gpiolib driver before doing the move?

As the arch maintainer I'm happy to say farewell to driver code in arch/mips.

Also, can we split the whole procedure into two patches, one for the cleanup
and one for the move?  I don't care in which order.

  Ralf
