Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 00:04:39 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37187 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbbASXEh0ksw1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 00:04:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2xynZsilm4kfiLPoBtfr1Mxb2vbYUoFSrOakDb6quPQ=;
        b=lv7raJoR6UMSrMa/I65sAqubvMjIa9e9qTliy3jWqSv16kk0Eb29AHX9rChQwCsKXZE1Kiq43dTwk9TcHdOiq0/JeWxBgx8+KgUifWBmSHRv5OJEfw2K5S5MlJog5pNjry9LF1q5NcFA+D3sPCCTJSHMj7RKhhhUkuMnue6L3Us=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:35001)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YDLN1-00015c-Ch; Mon, 19 Jan 2015 23:04:31 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YDLMy-0002hn-CR; Mon, 19 Jan 2015 23:04:28 +0000
Date:   Mon, 19 Jan 2015 23:04:27 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150119230427.GH26493@n2100.arm.linux.org.uk>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150119190142.GA9451@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Tue, Jan 20, 2015 at 03:01:42AM +0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 39d25a8cb1ad..15cc5902cf89 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -41,7 +41,6 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/clk/clk-conf.h>
> > -#include <linux/completion.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/irqflags.h>
> >  #include <linux/rwsem.h>
> > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> >  
> >  static void i2c_adapter_dev_release(struct device *dev)
> >  {
> > -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> > -	complete(&adap->dev_released);
> > +	/* empty, but the driver core insists we need a release function */
> 
> Yeah, it does, but I hate to see this in "real" code as something is
> probably wrong with it if it happens.
> 
> Please move the rest of 'i2c_del_adapter' into the release function
> (what was after the wait_for_completion() call), and then all should be
> fine.

Are you sure about that?  Some drivers do this, eg,

        i2c_del_adapter(&drv_data->adapter);
        free_irq(drv_data->irq, drv_data);

where drv_data was allocated using devm_kzalloc(), and so will be
released when the ->remove callback (which calls the above
i2c_del_adapter()) returns... freeing the embedded device struct.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
