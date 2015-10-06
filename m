Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 13:42:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46433 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009649AbbJFLmbGumyb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 13:42:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96BgRqT026600;
        Tue, 6 Oct 2015 13:42:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96BgRMt026599;
        Tue, 6 Oct 2015 13:42:27 +0200
Date:   Tue, 6 Oct 2015 13:42:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: qi_lb60: Remove unused linux/leds_pwm.h
 include
Message-ID: <20151006114226.GD26251@linux-mips.org>
References: <1444048957-29486-1-git-send-email-thierry.reding@gmail.com>
 <561272EC.2080602@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561272EC.2080602@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49448
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

On Mon, Oct 05, 2015 at 02:54:04PM +0200, Lars-Peter Clausen wrote:

> On 10/05/2015 02:42 PM, Thierry Reding wrote:
> > The board code never sets up a leds-pwm device, so including the header
> > is not necessary.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Somehow your email with the Ack got duplicated and patchwork being not
that clever counted that for two Acks ...

Anyway, just as with the previous patch this one only applied with fuzz
probably due to the gpio.h fix.

Thanks,

  Ralf
