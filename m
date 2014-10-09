Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 12:37:13 +0200 (CEST)
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:53756 "EHLO
        foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010927AbaJIKhMbcLv2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 12:37:12 +0200
Received: from foss-smtp-na-1.foss.arm.com (unknown [10.80.61.8])
        by foss-mx-na.foss.arm.com (Postfix) with ESMTP id 06DE4136;
        Thu,  9 Oct 2014 05:37:05 -0500 (CDT)
Received: from collaborate-mta1.arm.com (highbank-bc01-b06.austin.arm.com [10.112.81.134])
        by foss-smtp-na-1.foss.arm.com (Postfix) with ESMTP id AF48D5FAD7;
        Thu,  9 Oct 2014 05:37:02 -0500 (CDT)
Received: from e104818-lin.cambridge.arm.com (e104818-lin.cambridge.arm.com [10.1.203.37])
        by collaborate-mta1.arm.com (Postfix) with ESMTPS id 5E09013F717;
        Thu,  9 Oct 2014 05:36:58 -0500 (CDT)
Date:   Thu, 9 Oct 2014 11:36:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20141009103656.GF17836@e104818-lin.cambridge.arm.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
 <20141007080048.GB25331@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141007080048.GB25331@lee--X1>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
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

On Tue, Oct 07, 2014 at 09:00:48AM +0100, Lee Jones wrote:
> On Mon, 06 Oct 2014, Guenter Roeck wrote:
> > --- a/drivers/mfd/ab8500-sysctrl.c
> > +++ b/drivers/mfd/ab8500-sysctrl.c
> > @@ -6,6 +6,7 @@
> 
> [...]
> 
> > +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> > +			    void *unused2)
> >  {
> >  	sigset_t old;
> >  	sigset_t all;
> > @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
> >  	struct power_supply *psy;
> >  	int ret;
> >  
> > -	if (sysctrl_dev == NULL) {
> > -		pr_err("%s: sysctrl not initialized\n", __func__);
> > -		return;
> > -	}
> 
> Can you explain the purpose of this change please?

I guess it's because the sysctrl_dev is already initialised when
registering the power_off handler, so there isn't a way to call the
above function with a NULL sysctrl_dev. Probably even with the original
code you didn't need this check (after some race fix in
ab8500_sysctrl_remove but races is one of the things Guenter's patches
try to address).

-- 
Catalin
