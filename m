Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 22:07:22 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbcJKUHNy9S7t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Oct 2016 22:07:13 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 712522038F;
        Tue, 11 Oct 2016 20:07:09 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com [209.85.161.176])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613B52037F;
        Tue, 11 Oct 2016 20:07:07 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id t192so20785273ywf.0;
        Tue, 11 Oct 2016 13:07:07 -0700 (PDT)
X-Gm-Message-State: AA6/9Rns6wU2ZVwox1I6Rnk1VMqh5SIYmY8kLXfCiNHMHRxCrQ+EXxzLUcJHI2gU7Xg3aR3gGmTCv2HfYvDwqQ==
X-Received: by 10.13.210.67 with SMTP id u64mr5709630ywd.135.1476216426614;
 Tue, 11 Oct 2016 13:07:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.212.143 with HTTP; Tue, 11 Oct 2016 13:06:46 -0700 (PDT)
In-Reply-To: <2468748.fALFhzhDcI@np-p-burton>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
 <20161005171824.18014-17-paul.burton@imgtec.com> <20161010130121.GA31827@rob-hp-laptop>
 <2468748.fALFhzhDcI@np-p-burton>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Oct 2016 15:06:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+PkQmkkLMjiurmHegewpc6n_ntUMsik8oMZdM2nXHQ6g@mail.gmail.com>
Message-ID: <CAL_Jsq+PkQmkkLMjiurmHegewpc6n_ntUMsik8oMZdM2nXHQ6g@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] dt-bindings: Document img,boston-clock binding
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55391
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

On Tue, Oct 11, 2016 at 11:00 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Monday, 10 October 2016 08:01:21 BST Rob Herring wrote:
>> On Wed, Oct 05, 2016 at 06:18:22PM +0100, Paul Burton wrote:
>> > Add device tree binding documentation for the clocks provided by the
>> > MIPS Boston development board from Imagination Technologies, and a
>> > header file describing the available clocks for use by device trees &
>> > driver.
>> >
>> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> > Cc: Michael Turquette <mturquette@baylibre.com>
>> > Cc: Stephen Boyd <sboyd@codeaurora.org>
>> > Cc: linux-clk@vger.kernel.org
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Cc: devicetree@vger.kernel.org
>> >
>> > ---
>> >
>> > Changes in v3: None
>> > Changes in v2:
>> > - Add BOSTON_CLK_INPUT to expose the input clock.
>> >
>> >  .../devicetree/bindings/clock/img,boston-clock.txt | 27
>> >  ++++++++++++++++++++++ include/dt-bindings/clock/boston-clock.h
>> >   | 14 +++++++++++ 2 files changed, 41 insertions(+)
>> >  create mode 100644
>> >  Documentation/devicetree/bindings/clock/img,boston-clock.txt create mode
>> >  100644 include/dt-bindings/clock/boston-clock.h
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>> > b/Documentation/devicetree/bindings/clock/img,boston-clock.txt new file
>> > mode 100644
>> > index 0000000..c01ea60
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
>> > @@ -0,0 +1,27 @@
>> > +Binding for Imagination Technologies MIPS Boston clock sources.
>> > +
>> > +This binding uses the common clock binding[1].
>> > +
>> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> > +
>> > +Required properties:
>> > +- compatible : Should be "img,boston-clock".
>> > +- #clock-cells : Should be set to 1.
>> > +  Values available for clock consumers can be found in the header file:
>> > +    <dt-bindings/clock/boston-clock.h>
>> > +- regmap : Phandle to the Boston platform register system controller.
>> > +  This should contain a phandle to the system controller node covering
>> > the
>> > +  platform registers provided by the Boston board.
>>
>> Can you just make the clock node a child of the system controller and
>> drop this?
>>
>> Rob
>
> Hi Rob,
>
> (Apologies to anyone who received my last; my mail client seems to be
> misconfigured & previously sent HTML mail.)
>
> As I mentioned before technically that could be done, but it would really not
> be at all reflective of the hardware & so seems somewhat contrary to the
> purpose of a device tree.

Given that you need a reference back to the system controller, it does
match the h/w. The system controller h/w contains various functions,
therefore the system controller node should contain nodes for those
functions (or the sys ctrlr itself could be the clock provider node
with no child nodes). Otherwise, what is the parent of the clock node?
Root? Root should generally be the top level devices of the SoC,
though it gets used for things which have no good parent.

Rob
