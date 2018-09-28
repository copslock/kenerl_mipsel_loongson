Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2018 17:42:01 +0200 (CEST)
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40218 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeI1Pl6VLdFl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2018 17:41:58 +0200
Received: by mail-ot1-f68.google.com with SMTP id e23-v6so2213162otl.7;
        Fri, 28 Sep 2018 08:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Awlj99FgZ/YEXpgjtWqB9fdQVuQH2oVxCsOpG+r2+7E=;
        b=kluPNMPTzVhvfXpD3+siN0ZBaGYuS53cLGxj5oniP+hyHHvTy/BNlEbk9vNe58cUBp
         F0Xg/ydu+19JmjrQjOOsFTRVlyA1jk4zQXfHT5Ar70rHW8dxQbdLK5pXNqacOFfM9Uq3
         YlM0NG9DbJvgp+cnlTQwFtFqtjct1fIiA0VDwTBCGn6MXD3RRpL6iLCE5SSYIs/hJYFx
         G6zB9m+QWQfpxVsF10B3WvlcSiQXDJ5wkKUCCuIeniYx8V1aTayAdo02iuIDnqpUt8ZW
         QGe9Qu5pk7zvRb//303DXBfuWoEDnVtQhn8T42R353S0v2LLixbqcJScZE9kA3oAZWbP
         8wUg==
X-Gm-Message-State: ABuFfohYWYoCOoJXCZmUnFfOMYoGIliQny1hC45KhrU9TwnrcY2Q6LH4
        7V3MnuKNWxj3bdzk8UYisg==
X-Google-Smtp-Source: ACcGV63Srp0ldQSrIctZT4UQV6IqBMA8o6ihwirFprd6xuVCSZCJqUWFTEixZBqscIfRTKuidGdkCQ==
X-Received: by 2002:a9d:3cb9:: with SMTP id z54-v6mr9422754otc.22.1538149312058;
        Fri, 28 Sep 2018 08:41:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r3-v6sm662372oih.44.2018.09.28.08.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:41:51 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:41:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
Message-ID: <20180928154150.GA25013@bogus>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Sep 23, 2018 at 06:31:14AM -0400, Masahiro Yamada wrote:
> 2018-09-13 11:51 GMT-04:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > Hi Yamada-san,
> >
> > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> >> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
> >> >> There is nothing arch specific about building dtb files other than their
> >> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> >> >> The dependencies and supported targets are all slightly different.
> >> >> Also, a cross-compiler for each arch is needed, but really the host
> >> >> compiler preprocessor is perfectly fine for building dtbs. Move the
> >> >> build rules to a common location and remove the arch specific ones. This
> >> >> is done in a single step to avoid warnings about overriding rules.
> >> >>
> >> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> >> >> These pull in several dependencies some of which need a target compiler
> >> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> >> >> All that is really needed is dtc, so adjust the dependencies to only be
> >> >> dtc.
> >> >>
> >> >> This change enables support 'dtbs_install' on some arches which were
> >> >> missing the target.
> >> >
> >> > [...]
> >> >
> >> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
> >> >>                 $(srctree)/tools/testing/selftests/*/config
> >> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >> >>
> >> >> +# ---------------------------------------------------------------------------
> >> >> +# Devicetree files
> >> >> +
> >> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> >> >> +dtstree := arch/$(SRCARCH)/boot/dts
> >> >> +endif
> >> >> +
> >> >> +ifdef CONFIG_OF_EARLY_FLATTREE
> >> >
> >> > This can be true when dtstree is unset. So this line should be this
> >> > instead to fix the 0-day reported error:
> >> >
> >> > ifneq ($(dtstree),)
> >> >
> >> >> +
> >> >> +%.dtb : scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >> >> +
> >> >> +PHONY += dtbs dtbs_install
> >> >> +dtbs: scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
> >> >> +
> >> >> +dtbs_install: dtbs
> >> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> >> >> +
> >> >> +all: dtbs
> >> >> +
> >> >> +endif
> >>
> >>
> >> Ah, right.
> >> Even x86 can enable OF and OF_UNITTEST.
> >>
> >>
> >>
> >> Another solution might be,
> >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> >>
> >>
> >>
> >> This is actually what ACPI does.
> >>
> >> menuconfig ACPI
> >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >>         depends on ARCH_SUPPORTS_ACPI
> >>          ...
> >
> > ACPI is a real platform feature, as it depends on firmware.
> >
> > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > even if it has ACPI ;-)
> >
> 
> OK, understood.

Any other comments on this? I'd like to get the series into linux-next 
soon.

There was one other problem 0-day reported when building with 
CONFIG_OF=n while setting CONFIG_OF_ALL_DTBS=y on the kernel command 
line. The problem is dtc is not built as setting options on the command 
line doesn't invoke kconfig select(s). This can be fixed by also 
adding CONFIG_DTC=y to the command line, always building dtc regardless 
of Kconfig, or making 'all' conditionally dependent on 'dtbs'. I've gone 
with the last option as that is how this problem was avoided before. 

So the hunk in question with the 2 fixes now looks like this:

@@ -1215,6 +1215,35 @@ kselftest-merge:
                $(srctree)/tools/testing/selftests/*/config
        +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
+# 
---------------------------------------------------------------------------
+# Devicetree files
+
+ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
+dtstree := arch/$(SRCARCH)/boot/dts
+endif
+
+ifneq ($(dtstree),)
+
+%.dtb : scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
+PHONY += dtbs dtbs_install
+dtbs: scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree)
+
+dtbs_install: dtbs
+       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
+
+ifdef CONFIG_OF_EARLY_FLATTREE
+all: dtbs
+endif
+
+endif
+
+PHONY += scripts_dtc
+scripts_dtc: scripts_basic
+       $(Q)$(MAKE) $(build)=scripts/dtc
+
 # 
---------------------------------------------------------------------------
 # Modules
 
