Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 16:54:35 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994728AbeHHOybeVwO9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 16:54:31 +0200
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C71921A0D
        for <linux-mips@linux-mips.org>; Wed,  8 Aug 2018 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533740064;
        bh=Pahyq1tM2+wFi1p1aQch8rJ41izJQ8sVjNLwI7RmDUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NMTgIVCUBa+7M82LNHE+1IQyo5Ow9Hi/DcPoY8zD3dED/ONewNCjpV1kst1r7K0gJ
         7CTPaAc3xI/jbBZgFh0mkBaY9gZ65bECp9YHRXIrJ3gnVO/DiBtaaNeA2CFS2YW8o0
         OiegRBm6D3apMheW5mKL54oSOZtopJs22u/mHqNM=
Received: by mail-qt0-f178.google.com with SMTP id e19-v6so2709910qtp.8
        for <linux-mips@linux-mips.org>; Wed, 08 Aug 2018 07:54:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlHB8+x7kAA+ryGDwr4y3v36Gno9HJ+MfQwjLeLRGcnhd+m3Ocfh
        gaLMWreggttAG/sg0+m8rWfjH75vwOTkBEQKIw==
X-Google-Smtp-Source: AA+uWPyrOaU3fCUVzxL9e1rXhV+dyXeTkuu+WpHRIeVRW1jtuiC4ogihILdCk4NZgty8mN1fTWAQ8PEv0ufLz4pC6Ys=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr2937972qtp.22.1533740063752;
 Wed, 08 Aug 2018 07:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-4-songjun.wu@linux.intel.com> <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
 <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
In-Reply-To: <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 08:54:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5=a9nhvaZOsuDZ7YFhvZs23QT-jbDd4m7wPFviGU1CQ@mail.gmail.com>
Message-ID: <CAL_JsqL5=a9nhvaZOsuDZ7YFhvZs23QT-jbDd4m7wPFviGU1CQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] dt-bindings: clk: Add documentation of grx500
 clock controller
To:     yixin zhu <yixin.zhu@linux.intel.com>
Cc:     Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Tue, Aug 7, 2018 at 9:08 PM yixin zhu <yixin.zhu@linux.intel.com> wrote:
>
>
>
> On 8/6/2018 11:18 PM, Rob Herring wrote:
> > On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> >> From: Yixin Zhu <yixin.zhu@linux.intel.com>
> >>
> >> This patch adds binding documentation for grx500 clock controller.
> >>
> >> Signed-off-by: YiXin Zhu <yixin.zhu@linux.intel.com>
> >> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> >> ---
> >>
> >> Changes in v2:
> >> - Rewrite clock driver's dt-binding document according to Rob Herring's
> >>    comments.
> >> - Simplify device tree docoment, remove some clock description.
> >>
> >>   .../devicetree/bindings/clock/intel,grx500-clk.txt | 39 ++++++++++++++++++++++
> > Please match the compatible string: intel,grx500-cgu.txt
> Will update to use same name.
>
> >
> >>   1 file changed, 39 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >> new file mode 100644
> >> index 000000000000..e54e1dad9196
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >> @@ -0,0 +1,39 @@
> >> +Device Tree Clock bindings for grx500 PLL controller.
> >> +
> >> +This binding uses the common clock binding:
> >> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +The grx500 clock controller supplies clock to various controllers within the
> >> +SoC.
> >> +
> >> +Required properties for clock node
> >> +- compatible: Should be "intel,grx500-cgu".
> >> +- reg: physical base address of the controller and length of memory range.
> >> +- #clock-cells: should be 1.
> >> +
> >> +Optional Propteries:
> >> +- intel,osc-frequency: frequency of the osc clock.
> >> +if missing, driver will use clock rate defined in the driver.
> > This should use a fixed-clock node instead.
> Yes, This is a fixed clock node registered in driver code.
> The frequency of the fixed clock is designed to be overwritten by device
> tree in case some one verify
> clock driver in the emulation platform or in some cases frequency other
> than driver defined one is preferred.

Emulation platforms often need several hacks that shouldn't be upstream...

> These kinds of cases are very rare. But I feel it would be better to
> have a way to use customized frequency.
> The frequency defined in device tree will overwritten driver defined
> frequency before registering fixed-clock node.

I don't think you understand what I meant. Add a DT node with
"fixed-clock" compatible and have this node refer to it with "clocks"
property. The frequency is still in DT, but uses the clock binding.

Rob
