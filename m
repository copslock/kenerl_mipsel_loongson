Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 22:20:41 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011718AbbASVUjRx3MS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 22:20:39 +0100
Received: from localhost (unknown [203.117.110.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48C2DA5B;
        Mon, 19 Jan 2015 21:20:31 +0000 (UTC)
Date:   Tue, 20 Jan 2015 03:01:42 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Jean Delvare <jdelvare@suse.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150119190142.GA9451@kroah.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45335
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

On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> Back in the days, sysfs seemed to have refcounting issues and subsystems
> needed a completion to be safe. This is not the case anymore, so I2C can
> get rid of this code. There is noone else besides I2C doing something
> like this currently (checked with the attached coccinelle script which
> checks if a release function exists and if it contains a completion).
> 
> I have been digging through the history of linux.git and
> linux-history.git and found that e.g. w1 used to have such a mechanism
> and also simply removed it later.
> 
> Some more info from Greg Kroah-Hartman:
> "Having that call "wait" for the other release call to happen is really
> old, as Jean points out, from 2003.  We have "fixed" sysfs since then to
> detach the files from the devices easier, we used to have some nasy
> reference count issues in that area."
> 
> And some testing from Jean Delvare which matches my results:
> "However I just tested unloading an i2c bus driver while its adapter's
> new_device attribute was opened and rmmod returned immediately. So it
> doesn't look like accessing sysfs attributes actually takes a reference
> to the underlying i2c_adapter."
> 
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.
> 
> Reported-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> ---
> 
> Of course, more testing is appreciated. Here is the coccinelle script:
> 
> ===
> 
> @has_type@
> identifier d_type, rel_f;
> @@
> 
> struct device_type d_type = {
> 	.release = rel_f,
> };
> 
> @has_device@
> struct device *d;
> identifier rel_f, p;
> @@
> 
> (
> 	p->dev.release = &rel_f;
> |
> 	d->release = &rel_f;
> )
> 
> @find_type depends on has_type@
> identifier has_type.rel_f, d;
> @@
> 
> void rel_f(struct device *d)
> {
> 	...
> *	complete(...);
> 	...
> }
> 
> @find_device depends on has_device@
> identifier has_device.rel_f, d;
> @@
> 
> void rel_f(struct device *d)
> {
> 	...
> *	complete(...);
> 	...
> }
> 
> ===
> 
>  drivers/i2c/i2c-core.c | 10 +---------
>  include/linux/i2c.h    |  1 -
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8cb1ad..15cc5902cf89 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -41,7 +41,6 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/clk/clk-conf.h>
> -#include <linux/completion.h>
>  #include <linux/hardirq.h>
>  #include <linux/irqflags.h>
>  #include <linux/rwsem.h>
> @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
>  
>  static void i2c_adapter_dev_release(struct device *dev)
>  {
> -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> -	complete(&adap->dev_released);
> +	/* empty, but the driver core insists we need a release function */

Yeah, it does, but I hate to see this in "real" code as something is
probably wrong with it if it happens.

Please move the rest of 'i2c_del_adapter' into the release function
(what was after the wait_for_completion() call), and then all should be
fine.

thanks,

greg k-h
