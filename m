Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 01:28:41 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35775 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010761AbbGVX2kFh6Ss (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 01:28:40 +0200
Received: by pabkd10 with SMTP id kd10so74096050pab.2
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2015 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=klSHRIHjhoAZc7EYUp2wUkQpkJiWbmVHlIhJF0HtXfU=;
        b=CTNPABarPRbXVlRFhmCCiyHBANx65Z+48D5Fqxum2x8Zt2XWXd/ZxjzMKUMyHEbm+1
         YLl8r/Vk1sumxJlKvLDtb0J3mBnE+QonTTcxeol0TWhHxagZG7qVw4bdB5YHt6d/59Ud
         PgMVN5dyXSgX3iaS1L2cJUkEE2Zx1FyWl0K+nFY9Wd8dk8Cvp1yZWCUJQ4KDJcSoZaD+
         9/iLKXFqL/7NZlq1lpUt2Iank5LjPG1E2I/QNDGxuQUPXHICwuD1SS02kc3kCU4fKGX9
         DvfOU76DSWfMwnIkEsqrVrBJmkLb8mmSiRMldsh4r75LPfPCZJXmAFSgXfND05/4RuSF
         G23A==
X-Received: by 10.66.253.40 with SMTP id zx8mr11277091pac.56.1437607714217;
        Wed, 22 Jul 2015 16:28:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:fce7:c526:3cec:8586])
        by smtp.gmail.com with ESMTPSA id lj7sm4561455pab.38.2015.07.22.16.28.33
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:28:33 -0700 (PDT)
Date:   Wed, 22 Jul 2015 16:28:31 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Fainelli <fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to
 irq_chip
Message-ID: <20150722232831.GC8876@google.com>
References: <20150619224123.GL4917@ld-irv-0074>
 <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
 <alpine.DEB.2.11.1506201605290.4107@nanos>
 <55AE8E5D.8020700@gmail.com>
 <alpine.DEB.2.11.1507212316530.18576@nanos>
 <55AEB91C.1020202@broadcom.com>
 <alpine.DEB.2.11.1507212343270.18576@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507212343270.18576@nanos>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Tue, Jul 21, 2015 at 11:58:01PM +0200, Thomas Gleixner wrote:
> On Tue, 21 Jul 2015, Florian Fainelli wrote:
> > On 21/07/15 14:23, Thomas Gleixner wrote:
> > > I just read back on the problem report which was mentioned in the
> > > changelog:
> > > 
> > > "It's not a problem with patch 7, exactly, it's a problem with the
> > >  irqchip driver which handles the UART interrupt mask (irq-bcm7120-l2.c).
> > >  The problem is that with a trimmed down device tree (such as the one
> > >  found at arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb), none of the child
> > >  interrupts of the 'irq0_intc' node are described -- we don't have device
> > >  tree nodes for them yet -- but we still require saving and restoring the
> > >  forwarding mask (see 'brcm,int-fwd-mask') in order for the UART
> > >  interrupts to continue operating."
> > > 
> > > So you are trying to work around a flaw in the device tree by adding
> > > random callbacks to the core kernel?
> > 
> > Not quite, you could have your interrupt controller node declared in
> > Device Tree, but have no "interrupts" property referencing it because:
> > 
> > - the hardware is just not there, but you inherit a common Device Tree
> > skleten (*.dtsi)
> > - you could have Device Tree overlays which may or may not be loaded as
> > a result of finding expansion boards etc...
> 
> So if no hardware is there which uses any of those interrupts, then
> WHY is it a problem at all?

This particular badly-designed L2 interrupt controller not only
configures its own constituent interrupts, but it controls whether some
interrupts are seen at level 1 (e.g., GIC), rather than L2. So some
interrupts are affected, but not owned, by this hardware (and driver).

> If it's a requirement that these registers must be restored (once, not
> per irq), then I can see that it'd be nice to do that from the core.

Right, they must be restored for the whole chip.

> Though that core suspend/resume function is generic chip specific. So
> it does not make any sense to force it into struct irq_chip because we
> have no core infrastructure to deal with it.

Right, and that's what v2 does.

Thanks for the comments.

Brian
