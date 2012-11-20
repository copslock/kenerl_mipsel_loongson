Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 23:00:46 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:65098 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825927Ab2KTWApslM3r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2012 23:00:45 +0100
Received: by mail-wi0-f177.google.com with SMTP id c10so1175880wiw.6
        for <linux-mips@linux-mips.org>; Tue, 20 Nov 2012 14:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=Fpr3tzbTo6LD2LdISO2DnxGefo+UXUTol3a3aE2soN8=;
        b=lJIeI8gXgIOK8AvGoE1IIgx34a39/cf7xUu61LKwadciQAmalYmWAnfZ6cx+RvG2uw
         m9NCsD0MgalTrBnD9i1V8bcwFCmzq0mNe+5MRZEVcLzKhYB1AdcWpLQEiLfOR6zj2sZi
         pMzbfMm0rPXY+NmlKtjLkquJBPzHWfdH7Zc8cAlt63GoF5DHHZNB+G4gW/scUaZrLukG
         wIsUnC6T1JKc7rM7ojGLtcMNDZ+gK6crGzBMihKK4m62bCU92UoZeGz6+oV034MxpMhE
         egSVTHNEK4gzTa2MpPJmoBBO6PYEZdFfuOpPGD2KUs5jNXbpWbENLk+B2dbF4B54DByi
         RcwA==
Received: by 10.180.24.193 with SMTP id w1mr16703686wif.22.1353448840412;
        Tue, 20 Nov 2012 14:00:40 -0800 (PST)
Received: from localhost (host86-176-220-160.range86-176.btcentralplus.com. [86.176.220.160])
        by mx.google.com with ESMTPS id n11sm2392104wiw.6.2012.11.20.14.00.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 14:00:38 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 5C8943E1821; Tue, 20 Nov 2012 22:00:32 +0000 (GMT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <50A5350A.3070109@wwwdotorg.org>
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com> <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca> <50A52FEC.4080409@wwwdotorg.org> <CACxGe6tZOjMXR6CNDzDTSUkcERLiX-2+Qoad0bcPum5Z-Jxaaw@mail.gmail.com> <50A5350A.3070109@wwwdotorg.org>
Date:   Tue, 20 Nov 2012 22:00:32 +0000
Message-Id: <20121120220032.5C8943E1821@localhost>
X-Gm-Message-State: ALoCoQl4z+kslTJvmrzxVHCT53Goj86y3maZuVPWfJQU4FNUPrTu5hySO7mAGaGY2JNW7XctGy+c
X-archive-position: 35061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 15 Nov 2012 11:31:38 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/15/2012 11:20 AM, Grant Likely wrote:
> > On Thu, Nov 15, 2012 at 6:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 11/15/2012 04:51 AM, Grant Likely wrote:
> >>> Grant Likely wrote:
> >>>> Or how about: I could pick up the patch with only the MIPS hunk and
> >>>> every other user can be fixed up independently to use the new rule.
> >>>
> >>> Here's a trial patch to fix up ARM. Does this look correct? This patch
> >>> depends on the generic dtb build rule already being applied.
> >>
> >> I think the patch looks OK technically, except for one minor comment below.
> >>
> >> One issue with this patch is that it moves *.dts from arch/arm/boot to
> >> arch/arm/boot/dts, which means everyone has to adjust their scripts/...
> >> that package/install/... the kernel. I guess it's an easy change for
> >> people to make, but could easily catch people unawares if they do
> >> incremental builds so that arch/arm/boot/*.dtb still exists but is stale.
> > 
> > True. We could temporarily remove or rename if the same file exists in
> > the directory below to help people catch that problem. I really would
> > like to clean up that build rule to be consistent though.
> > 
> > The other option is to move all the .dts files into the boot
> > directory, but I don't think that is a good idea at all.
> 
> Maybe we can just add "rm *.dtb" to the following rules in
> boot/Makefile, before calling the child make?
> 
> %.dtb: scripts
> -	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> +	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
> 
>  dtbs: scripts
> -	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> +	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
> 
> >>> +targets += dtbs
> >>
> >> Doesn't that make the "dtbs" target always run by default? Perhaps
> >> that's reasonable though, and doesn't actually affect anything since the
> >> make command for this directory always specifies an explicit target?
> >>
> >> Or, was that meant to be the following that got removed from ../Makefile?
> >>
> >> targets += $(dtb-y)
> > 
> > Yes it is supposed to be the same thing. Doesn't it effectively do the
> > same since dtbs depends on $(dtb-y)?
> 
> Ah, I think so yes.
> 
> I guess anyway that $(targets) is presumably ignored if an explicit
> build target is requested from make.

Can you pull into your series and get it working. The merge window is
going to open this week, so I have to push it back to v3.9 anyway.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
