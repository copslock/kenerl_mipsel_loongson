Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 03:06:15 +0200 (CEST)
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35582 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012505AbbEFBGNRFNEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 03:06:13 +0200
Received: by qkhg7 with SMTP id g7so118693257qkh.2
        for <linux-mips@linux-mips.org>; Tue, 05 May 2015 18:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1r+yxmy9LuZklTsWWS9r4+JUX4L44QGPn7bz1flWPK4=;
        b=PMgMJatRSZBnx71YwTz1IBCIZo5zuvrGxUq/0eXS7ICYAdSl7WUWUL6JqKwJzeOLdx
         NtTJ8NXD6cegTg8Haplkn0jU9r3Qr4bpeXbBSVTvtBnxsee31K+aN/axR+hLv9UK3oVG
         c1+sHvvOn12j6zX66fMtiAogq2BnKbzubX7tHtPAkGFgE/TuPkkovawaKRvXPfFsTnkF
         n68PgRqg0IM/k2ei8jqh5lE/ghW1NSdbfVgNrZl3pAgTrEZti92Z1CdM2suClwmlaX4e
         /KKqhiWc85/Zwu2Mwjo2HU+z1mXQIkNJGTcldcq92/HWS7QqyV1++DeixSSBcwNuw4Xy
         S1fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1r+yxmy9LuZklTsWWS9r4+JUX4L44QGPn7bz1flWPK4=;
        b=e1IgwM858fzysBIFknO5L47QeAopmqBC0AbTApYCZgChLhL//n1aQcmS+fMhToLo4I
         hjADCoI72YL9bQBrcrEjX0ZRZuJ6rn0E/+6V0QjpN2h6r/KiZ7dSd855JObnwqLQa4nC
         rfqAj8maK40/+eO8KMnmMUyIgLvtGMfZObzcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1r+yxmy9LuZklTsWWS9r4+JUX4L44QGPn7bz1flWPK4=;
        b=VnmR490fkssEHAUE+33ND6hxqI2cjCyLxPgTzrjGW9ZR/gWaDACDoFZ3oLoe8IlV5k
         JeGMTrKTnXe+H5ply7aYcOkyMqN9v4K1WFmZR6LDy+DYjfDgD+K4evR4mr90Jn7P4eVq
         XxBIsG46Vpa8sX+/IG2m+Hqy7lGbdqmJrjK/AhpL2jBDxu8U+BDcXvmN2MCDMigCSOAL
         Qt7HT/feTgsqV9wZxlfgb1KXFXC5a0g/C1/reKxOzVrZB3bttY8NgVImFw2BCu4IcMPH
         /wpH8yZLz/72cTiMvuBNEUdMtSHtbsyNNUkz4i07nUHLe+IPgCKV3Uj127Bmm4JO72oK
         YwTw==
X-Gm-Message-State: ALoCoQnGVGO+nRUzL/YyXwZ8YAbxrtD0Evo+3ApHtgkiy8cXrzZzwHVDWg3/QR4ce4I1DLBKlEtN
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr63333125qkh.56.1430874368816;
 Tue, 05 May 2015 18:06:08 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Tue, 5 May 2015 18:06:08 -0700 (PDT)
In-Reply-To: <20150505233534.GB18183@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <1428444258-25852-2-git-send-email-abrestic@chromium.org>
        <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
        <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
        <20150505224352.GA18183@jhogan-linux.le.imgtec.org>
        <CAL1qeaG=O7LYo6RRxEMZw2da=eKAp0Dd+LxhBX32TojyBkr=xA@mail.gmail.com>
        <20150505233534.GB18183@jhogan-linux.le.imgtec.org>
Date:   Tue, 5 May 2015 18:06:08 -0700
X-Google-Sender-Auth: RjLD07mUAN8ru6w7ksSiUFKkKQw
Message-ID: <CAL1qeaE9O3RBNVv9DrZZRu6sebkK2GOnbv6hWQsUR5MHKMcGgA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] phy: Add binding document for Pistachio USB2.0 PHY
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, May 5, 2015 at 4:35 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Tue, May 05, 2015 at 04:09:31PM -0700, Andrew Bresticker wrote:
>> On Tue, May 5, 2015 at 3:43 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> > On Tue, May 05, 2015 at 03:16:23PM -0700, Andrew Bresticker wrote:
>> >> Hi James,
>> >>
>> >> On Tue, May 5, 2015 at 3:01 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> >> > Hi Andrew,
>> >> >
>> >> > On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
>> >> >> Add a binding document for the USB2.0 PHY found on the IMG Pistachio SoC.
>> >> >>
>> >> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >> >> Cc: Rob Herring <robh+dt@kernel.org>
>> >> >> Cc: Pawel Moll <pawel.moll@arm.com>
>> >> >> Cc: Mark Rutland <mark.rutland@arm.com>
>> >> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> >> >> Cc: Kumar Gala <galak@codeaurora.org>
>> >> >> ---
>> >> >> No changes from v1.
>> >> >> ---
>> >> >>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 ++++++++++++++++++++++
>> >> >>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
>> >> >>  2 files changed, 45 insertions(+)
>> >> >>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >> >>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
>> >> >>
>> >> >> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >> >> new file mode 100644
>> >> >> index 0000000..afbc7e2
>> >> >> --- /dev/null
>> >> >> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >> >> @@ -0,0 +1,29 @@
>> >> >> +IMG Pistachio USB PHY
>> >> >> +=====================
>> >> >> +
>> >> >> +Required properties:
>> >> >> +--------------------
>> >> >> + - compatible: Must be "img,pistachio-usb-phy".
>> >> >> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
>> >> >> + - clocks: Must contain an entry for each entry in clock-names.
>> >> >> +   See ../clock/clock-bindings.txt for details.
>> >> >> + - clock-names: Must include "usb_phy".
>> >> >> + - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
>> >> >> + - img,refclk: Indicates the reference clock source for the USB PHY.
>> >> >> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid values.
>> >> >
>> >> > Possibly dumb question: why isn't the reference clock source specified
>> >> > in the normal ways like the "usb_phy" clock is?
>> >> >
>> >> > Does the value required here depend on what usb_phy clock gets muxed
>> >> > from or something?
>> >>
>> >> Right, the value indicates what clock "usb_phy" is: whether it comes
>> >> from the core clock controller, the XO crystal, or is some external
>> >> clock.  It's a mux internal to the PHY.
>> >
>> > Okay. If its a software controllable mux, is there a particular reason
>> > the DT doesn't describe it as such, i.e. have all 3 clock inputs, and
>> > the driver somehow work out which to use?
>>
>> Well, I'm not sure how the driver would determine which clock to use
>> without a device-tree property like the one I've got here :).  Also,
>
> Does it make sense to just look for the "best" usable source clock based
> on the supported rates listed in fsel_rate_map[] (for some definition of
> "best" such as "fastest" / "slowest" / "first usable"), or are things
> just not that simple?
>
> I'm just wondering how the DT writer would decide, since it seems to
> come down to a policy decision rather than a description of the
> hardware, which should probably be avoided in DT bindings if possible.

Ah, sorry if that was unclear - this *is* describing a hardware
property.  The DT author would pick a value by looking at which clock
is connected to the PHY in the schematic.

-Andrew
