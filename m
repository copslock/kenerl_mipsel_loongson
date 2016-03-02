Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 18:33:04 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013021AbcCBRdC5S804 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 18:33:02 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90488C26;
        Wed,  2 Mar 2016 17:32:56 +0000 (UTC)
Date:   Wed, 2 Mar 2016 09:32:56 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     linux-pcmcia@lists.infradead.org,
        Linux-MIPS <linux-mips@linux-mips.org>, arnd@arndb.de,
        linus.walleij@linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] pcmcia: db1xxx_ss: fix last irq_to_gpio user
Message-ID: <20160302173256.GD3594@kroah.com>
References: <1456911283-158809-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456911283-158809-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Mar 02, 2016 at 10:34:43AM +0100, Manuel Lauss wrote:
> remove the usage of removed irq_to_gpio() function.  On pre-DB1200
> boards, pass the actual carddetect GPIO number instead of the IRQ,
> because we need the gpio to actually test card status (inserted or
> not) and can get the irq number with gpio_to_irq() instead.
> 
> Tested on DB1300 and DB1500, this patch fixes PCMCIA on the DB1500,
> which used irq_to_gpio().
> 
>  stable@vger.kernel.org # v4.3
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: "Fixes" line, and CC stable, and added Arnd's ack.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
