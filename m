Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 03:51:49 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011181AbbATCvr57rs0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 03:51:47 +0100
Received: from localhost (unknown [203.117.110.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3523C982;
        Tue, 20 Jan 2015 02:51:40 +0000 (UTC)
Date:   Tue, 20 Jan 2015 09:41:59 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150120014159.GA3349@kroah.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
 <20150119230427.GH26493@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150119230427.GH26493@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45348
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

On Mon, Jan 19, 2015 at 11:04:27PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 20, 2015 at 03:01:42AM +0800, Greg Kroah-Hartman wrote:
> > On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > index 39d25a8cb1ad..15cc5902cf89 100644
> > > --- a/drivers/i2c/i2c-core.c
> > > +++ b/drivers/i2c/i2c-core.c
> > > @@ -41,7 +41,6 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/clk/clk-conf.h>
> > > -#include <linux/completion.h>
> > >  #include <linux/hardirq.h>
> > >  #include <linux/irqflags.h>
> > >  #include <linux/rwsem.h>
> > > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> > >  
> > >  static void i2c_adapter_dev_release(struct device *dev)
> > >  {
> > > -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> > > -	complete(&adap->dev_released);
> > > +	/* empty, but the driver core insists we need a release function */
> > 
> > Yeah, it does, but I hate to see this in "real" code as something is
> > probably wrong with it if it happens.
> > 
> > Please move the rest of 'i2c_del_adapter' into the release function
> > (what was after the wait_for_completion() call), and then all should be
> > fine.
> 
> Are you sure about that?  Some drivers do this, eg,
> 
>         i2c_del_adapter(&drv_data->adapter);
>         free_irq(drv_data->irq, drv_data);
> 
> where drv_data was allocated using devm_kzalloc(), and so will be
> released when the ->remove callback (which calls the above
> i2c_del_adapter()) returns... freeing the embedded device struct.

But that will fail today if the memory is freed in i2c_del_adapter(), so
there shouldn't be any change in logic here.

Or am I missing something obvious?

thanks,

greg k-h
