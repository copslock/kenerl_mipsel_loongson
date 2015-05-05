Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 01:09:40 +0200 (CEST)
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33011 "EHLO
        mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012478AbbEEXJfveBLQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 01:09:35 +0200
Received: by qgdy78 with SMTP id y78so89752909qgd.0
        for <linux-mips@linux-mips.org>; Tue, 05 May 2015 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=75gVt8bOlaAZhhYxz2tcD7PSBDO0Wx7YBrTydgRKdew=;
        b=ND3U+0zsTfJ9oM5jHe+J3mXpwZd74BV7DMRLJ+iJ1j+FAXeUodqQySReKjulpHkok3
         lMtfpU46cBIUwwQ0K6o7J2UnSioOREKE1n0djKAkaaIsJvmQQxKYsgcNgVlRfjqCFy+A
         GfYBFi9xcFNt/lmlibX6WzyTnKSgLoZNy5J32bG9u4NoIvCwV7nGdklVTtQToOMtZPTl
         0qyv0DWrpUSSH0wj4utotuZhFbYMmzUUtB1TUQTVbDP5g3x7Hsvd4j/UOA1jvEk8uepx
         iihN+z+y26OfB3GexNSOHf1i+gBXl0tu0YJ97J9q24nDJKoP2O41aHYeBQp4bOnWCJhs
         6OfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=75gVt8bOlaAZhhYxz2tcD7PSBDO0Wx7YBrTydgRKdew=;
        b=OkKDnibaUXlo+kT/4IcUY4YFs6rsg5S2uaHBc9UEJHBsx9Y4Py76RNpnmVOAtAoWVN
         uplUiaQgghnE+mf2FA77iAcgw/gM3d7ZFOaAhb0b1zluCKaueM7Ydj3J133TE/C5RX3J
         AaHvcM22lDtmVNUHgCqo0Oz+k+q7OLEtNi2kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=75gVt8bOlaAZhhYxz2tcD7PSBDO0Wx7YBrTydgRKdew=;
        b=VYDoJS+of++3kjtqwNFuO2XLkEIqUBLxS5VVXAkz2l0DG+j3uwSHuNavdHL2EBvtgs
         J8WxtwttZgssfmAXkFXQbxRJ31CYiTeBjavstvoUAYUm6YpCv4kR4YuZEuHuQog99ZBj
         +T+80dHRDuF/1hWotQheF24qRCISeELcDSMKQbn68cEuHNZmmwZzzXYkqDIE7oPrUh6t
         RnSgtVyIoQw4+vC4otiD6s87p1YifULanmVveQNPq9ElKO/FHCuZnleiBMgHNnYcwcmP
         ESHOmkXiqNS+8/Xb7IoL0CoJYOX2qQPNFxSBarP68D8QEqDyTKAJmh3JO0U/nDMBoKF0
         /uqA==
X-Gm-Message-State: ALoCoQmQ/seVAAeqjY3gMrJHEqVwNt5Yyka5+0C87c6lwmWxToUFHsDjG7iyGHPBWfAy6l+ksDMF
MIME-Version: 1.0
X-Received: by 10.140.164.145 with SMTP id k139mr9376520qhk.15.1430867372007;
 Tue, 05 May 2015 16:09:32 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Tue, 5 May 2015 16:09:31 -0700 (PDT)
In-Reply-To: <20150505224352.GA18183@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <1428444258-25852-2-git-send-email-abrestic@chromium.org>
        <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
        <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
        <20150505224352.GA18183@jhogan-linux.le.imgtec.org>
Date:   Tue, 5 May 2015 16:09:31 -0700
X-Google-Sender-Auth: lnv3u0F9G8WIACK1PsBCzQ5fcwQ
Message-ID: <CAL1qeaG=O7LYo6RRxEMZw2da=eKAp0Dd+LxhBX32TojyBkr=xA@mail.gmail.com>
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
X-archive-position: 47246
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

On Tue, May 5, 2015 at 3:43 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Tue, May 05, 2015 at 03:16:23PM -0700, Andrew Bresticker wrote:
>> Hi James,
>>
>> On Tue, May 5, 2015 at 3:01 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> > Hi Andrew,
>> >
>> > On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
>> >> Add a binding document for the USB2.0 PHY found on the IMG Pistachio SoC.
>> >>
>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >> Cc: Rob Herring <robh+dt@kernel.org>
>> >> Cc: Pawel Moll <pawel.moll@arm.com>
>> >> Cc: Mark Rutland <mark.rutland@arm.com>
>> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> >> Cc: Kumar Gala <galak@codeaurora.org>
>> >> ---
>> >> No changes from v1.
>> >> ---
>> >>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 ++++++++++++++++++++++
>> >>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
>> >>  2 files changed, 45 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >> new file mode 100644
>> >> index 0000000..afbc7e2
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> >> @@ -0,0 +1,29 @@
>> >> +IMG Pistachio USB PHY
>> >> +=====================
>> >> +
>> >> +Required properties:
>> >> +--------------------
>> >> + - compatible: Must be "img,pistachio-usb-phy".
>> >> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
>> >> + - clocks: Must contain an entry for each entry in clock-names.
>> >> +   See ../clock/clock-bindings.txt for details.
>> >> + - clock-names: Must include "usb_phy".
>> >> + - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
>> >> + - img,refclk: Indicates the reference clock source for the USB PHY.
>> >> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid values.
>> >
>> > Possibly dumb question: why isn't the reference clock source specified
>> > in the normal ways like the "usb_phy" clock is?
>> >
>> > Does the value required here depend on what usb_phy clock gets muxed
>> > from or something?
>>
>> Right, the value indicates what clock "usb_phy" is: whether it comes
>> from the core clock controller, the XO crystal, or is some external
>> clock.  It's a mux internal to the PHY.
>
> Okay. If its a software controllable mux, is there a particular reason
> the DT doesn't describe it as such, i.e. have all 3 clock inputs, and
> the driver somehow work out which to use?

Well, I'm not sure how the driver would determine which clock to use
without a device-tree property like the one I've got here :).  Also,
all three clock need not be present.

-Andrew
