Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 12:49:44 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34848 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010918AbaJIKtnTAEml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 12:49:43 +0200
Received: by mail-ig0-f171.google.com with SMTP id h15so11995805igd.16
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 03:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VOEUqRhutNv4JOTU1TKR0XMZmavVbzA4G92j+CPJoYY=;
        b=Hkd14FC5eMEC3D0qyah0d3RLEy7Zk1KKL/dTRtjMDAaeA3gF3IM4XwzXlvUhh0o7s/
         LmVOPDlXFOLW6EvE8EGSQAuffQpPAtohBeVbf9FoWnnVE6ikttL1gghSnEh8oNjdVp4u
         N61c030JuRFMrj4FiG6t+omRmSzSo92UC5zt74COTO0hVuz246TZPMm8z51AFSRVnoRZ
         TuhP9+5CA2mP5NBVq3uMIOdBvsQwq2wY8gQszs27oou0leWDcXdHmtEiqcGO1eKwFb6K
         MalN1MpDc01QMc/deSGjfEBXiXauOGt4eVicLLqlBHKEOg50xUjxJf28QEbcuUiTUmaE
         efZQ==
X-Gm-Message-State: ALoCoQn88hmCk3/sLvrT7Gd/67I8OctG+MOCaR5wpmz/rUlG8P039Wf79FHbwXNGdOG4w/W9Yfsr
X-Received: by 10.50.79.132 with SMTP id j4mr55127359igx.9.1412851776888;
        Thu, 09 Oct 2014 03:49:36 -0700 (PDT)
Received: from lee--X1 (host109-148-233-9.range109-148.btcentralplus.com. [109.148.233.9])
        by mx.google.com with ESMTPSA id e7sm7827780igi.18.2014.10.09.03.49.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 03:49:36 -0700 (PDT)
Date:   Thu, 9 Oct 2014 11:49:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20141009104927.GN20647@lee--X1>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
 <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Thu, 09 Oct 2014, Catalin Marinas wrote:

> On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
> > On Mon, 06 Oct 2014, Guenter Roeck wrote:
> > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > @@ -6,6 +6,7 @@
> > 
> > [...]
> > 
> > > +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> > > +			    void *unused2)
> > >  {
> > >  	sigset_t old;
> > >  	sigset_t all;
> > > @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
> > >  	struct power_supply *psy;
> > >  	int ret;
> > >  
> > > -	if (sysctrl_dev == NULL) {
> > > -		pr_err("%s: sysctrl not initialized\n", __func__);
> > > -		return;
> > > -	}
> > 
> > Can you explain the purpose of this change please?
> 
> I guess it's because the sysctrl_dev is already initialised when
> registering the power_off handler, so there isn't a way to call the
> above function with a NULL sysctrl_dev. Probably even with the original
> code you didn't need this check (after some race fix in
> ab8500_sysctrl_remove but races is one of the things Guenter's patches
> try to address).

Sounds reasonable, although I think this change should be part of
another patch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
