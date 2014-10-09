Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:45:28 +0200 (CEST)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:59683 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010963AbaJIPp07IttP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:45:26 +0200
Received: by mail-oi0-f49.google.com with SMTP id a3so3379444oib.36
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4eIxMi56Qx395xF6i1ZJJ06CAEoCKtzjsOOfm6px7Og=;
        b=u+3eovar+KmWaFVC9lG3lkLtq/pTW2yOhv9rOY31R3SVeXnCUxdhKIvstExL/A1NFI
         tBJQwX29iYGr54NpDzaOVU9HDj4a1ElKUFqaQV9m01sl0lAsge3eqsApa8SdN7CljbFF
         FFqoYgFykGGu5XzZUkwjE+l8hBh8G3ywLQ5DQ0+AXKbHvNKq37EnyfrM8rc45gPZ04ES
         bFTPHmBo3uuwKFNQ0kj0YLYl5Un4wzztLXHevmbNokokQeg/Q/S+RPQ5E1XDcY6xLdAV
         BocWTKzC0hf+7Q58hKjrcRfXnWu/FgdhaesjBmJP+iGMbHn804a2Yi/gUCFsraMUMI1R
         IqIQ==
X-Received: by 10.68.215.67 with SMTP id og3mr636738pbc.30.1412869520469;
        Thu, 09 Oct 2014 08:45:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id cl1sm15338pbb.92.2014.10.09.08.45.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 08:45:19 -0700 (PDT)
Date:   Thu, 9 Oct 2014 08:45:15 -0700
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
Message-ID: <20141009154515.GB31987@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
 <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
 <20141009104927.GN20647@lee--X1>
 <54368D16.40404@roeck-us.net>
 <20141009133355.GQ20647@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141009133355.GQ20647@lee--X1>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43148
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

On Thu, Oct 09, 2014 at 02:33:55PM +0100, Lee Jones wrote:
> On Thu, 09 Oct 2014, Guenter Roeck wrote:
> 
> > On 10/09/2014 03:49 AM, Lee Jones wrote:
> > >On Thu, 09 Oct 2014, Catalin Marinas wrote:
> > >
> > >>On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
> > >>>On Mon, 06 Oct 2014, Guenter Roeck wrote:
> > >>>>--- a/drivers/mfd/ab8500-sysctrl.c
> > >>>>+++ b/drivers/mfd/ab8500-sysctrl.c
> > >>>>@@ -6,6 +6,7 @@
> > >>>
> > >>>[...]
> > >>>
> > >>>>+static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> > >>>>+			    void *unused2)
> > >>>>  {
> > >>>>  	sigset_t old;
> > >>>>  	sigset_t all;
> > >>>>@@ -34,11 +36,6 @@ static void ab8500_power_off(void)
> > >>>>  	struct power_supply *psy;
> > >>>>  	int ret;
> > >>>>
> > >>>>-	if (sysctrl_dev == NULL) {
> > >>>>-		pr_err("%s: sysctrl not initialized\n", __func__);
> > >>>>-		return;
> > >>>>-	}
> > >>>
> > >>>Can you explain the purpose of this change please?
> > >>
> > >>I guess it's because the sysctrl_dev is already initialised when
> > >>registering the power_off handler, so there isn't a way to call the
> > >>above function with a NULL sysctrl_dev. Probably even with the original
> > >>code you didn't need this check (after some race fix in
> > >>ab8500_sysctrl_remove but races is one of the things Guenter's patches
> > >>try to address).
> > >
> > >Sounds reasonable, although I think this change should be part of
> > >another patch.
> > >
> > Sure, no problem. I'll split this into two patches.
> > 
> > Since we are at it, any idea what to do with the restart function
> > in the same file ? It is not used anywhere.
> 
> You can strip it out with Linus Walleij's Ack.  Or I'll be happy to do
> it?
> 
I'll strip it out in a 3rd patch.

Guenter
