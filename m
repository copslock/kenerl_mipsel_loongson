Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 12:30:40 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbeHCKagZmYEo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2018 12:30:36 +0200
Received: from localhost (ip-213-127-46-170.ip.prioritytelecom.net [213.127.46.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFDD6720;
        Fri,  3 Aug 2018 10:30:26 +0000 (UTC)
Date:   Fri, 3 Aug 2018 12:30:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Wu, Songjun" <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
Message-ID: <20180803103023.GA6557@kroah.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
 <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65387
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

On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
> 
> 
> On 8/3/2018 1:56 PM, Greg Kroah-Hartman wrote:
> > On Fri, Aug 03, 2018 at 11:02:33AM +0800, Songjun Wu wrote:
> > > Previous implementation uses platform-dependent API to get the clock.
> > > Those functions are not available for other SoC which uses the same IP.
> > > The CCF (Common Clock Framework) have an abstraction based APIs for
> > > clock. In future, the platform specific code will be removed when the
> > > legacy soc use CCF as well.
> > > Change to use CCF APIs to get clock and rate. So that different SoCs
> > > can use the same driver.
> > > 
> > > Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> > > ---
> > > 
> > > Changes in v2: None
> > > 
> > >   drivers/tty/serial/lantiq.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> > > index 36479d66fb7c..35518ab3a80d 100644
> > > --- a/drivers/tty/serial/lantiq.c
> > > +++ b/drivers/tty/serial/lantiq.c
> > > @@ -26,7 +26,9 @@
> > >   #include <linux/clk.h>
> > >   #include <linux/gpio.h>
> > > +#ifdef CONFIG_LANTIQ
> > >   #include <lantiq_soc.h>
> > > +#endif
> > That is never how you do this in Linux, you know better.
> > 
> > Please go and get this patchset reviewed and signed-off-by from other
> > internal Intel kernel developers before resending it next time.  It is
> > their job to find and fix your basic errors like this, not ours.
> Thank you for your comment.
> Actually, we have discussed this issue internally.
> We put the reason why we use "#ifdef CONFIG_LANTIQ" preprocessor in commit
> message in "[PATCH v2 08/18] serial: intel: Get serial id from dts".
> Please refer the commit message below.
> 
> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> macro is defined in lantiq_soc.h.
> lantiq_soc.h is in arch path for legacy product support.
> 
> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> 
> If "#ifdef preprocessor" is changed to
> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> code using LTQ_EARLY_ASC is compiled.
> Compilation will fail for no LTQ_EARLY_ASC defined.

Sorry, but no.  Why is this one tiny driver/chip somehow more "special"
than all of the tens of thousands of other devices we support to warrent
it getting some sort of special exception to do things differently?
What happens to the next device that wants to do it this way?

Our coding style and rules are there for a reason, do not violate them
thinking your device is the only one that matters.

Do it properly, again, you all know better than this.

greg k-h
