Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:54:17 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52272 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010966AbaJIPyQZrH2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:54:16 +0200
Received: by mail-pd0-f173.google.com with SMTP id g10so12447pdj.32
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yTHPn6FXE9DCZLPDU0xnaAN7oKKZ0p3HDnJX2zJudGk=;
        b=a8hdupblssG+OYy2DtvfEv1Vq+JRlB3PoxRYDmE/CJ1tsmvGfHN0RGLImT80BVJFHm
         q1gbyW+BRFVKRsdsErApbeYGJU/E2WCPnZ3M1TJGAvcCcilrM1xiIstXEjJEIeumeZou
         W8AJn3rYi0UfUL7KV3kFJaTqdzP4r+aNORpaWq4YgA/P9dHjb56VxMUyerQYA8fFvIaY
         VG5FDpelavOY4fwSgrYqqxTDKrMtlw4ZSTMa9yg4yBun+v/9uO64yBBFjb+Jek5Q7tf7
         m13jnF0bscDjGj8Qd4zOa7IH/6DWBdBLQe18mbd3ca1zkjzFYrDSKvDsC1siSQfVJKsO
         T5GA==
X-Received: by 10.70.95.104 with SMTP id dj8mr567497pdb.84.1412870049428;
        Thu, 09 Oct 2014 08:54:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id od12sm852957pdb.96.2014.10.09.08.54.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 08:54:08 -0700 (PDT)
Date:   Thu, 9 Oct 2014 08:54:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
Message-ID: <20141009155404.GC31987@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
 <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
 <20141009104927.GN20647@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141009104927.GN20647@lee--X1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Oct 09, 2014 at 11:49:27AM +0100, Lee Jones wrote:
> On Thu, 09 Oct 2014, Catalin Marinas wrote:
> 
> > On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
> > > On Mon, 06 Oct 2014, Guenter Roeck wrote:
> > > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > > @@ -6,6 +6,7 @@
> > > 
> > > [...]
> > > 
> > > > +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> > > > +			    void *unused2)
> > > >  {
> > > >  	sigset_t old;
> > > >  	sigset_t all;
> > > > @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
> > > >  	struct power_supply *psy;
> > > >  	int ret;
> > > >  
> > > > -	if (sysctrl_dev == NULL) {
> > > > -		pr_err("%s: sysctrl not initialized\n", __func__);
> > > > -		return;
> > > > -	}
> > > 
> > > Can you explain the purpose of this change please?
> > 
> > I guess it's because the sysctrl_dev is already initialised when
> > registering the power_off handler, so there isn't a way to call the
> > above function with a NULL sysctrl_dev. Probably even with the original
> > code you didn't need this check (after some race fix in
> > ab8500_sysctrl_remove but races is one of the things Guenter's patches
> > try to address).
> 
> Sounds reasonable, although I think this change should be part of
> another patch.
> 
Turns out the options are to either drop the check or to use the device
managed function to register the poweroff handler. I decided to keep
the check and use the device managed function.

Guenter
