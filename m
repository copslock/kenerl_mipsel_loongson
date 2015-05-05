Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 00:16:30 +0200 (CEST)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36138 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012478AbbEEWQ1MdVNB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 00:16:27 +0200
Received: by qgeb100 with SMTP id b100so89131401qge.3
        for <linux-mips@linux-mips.org>; Tue, 05 May 2015 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zYdPbZEw8RqlZ22TbJCRLd3GVrM3tg+B5RqJqspAiyE=;
        b=opwjV8Z+aKPa3UAhY6w8tYD4z9UtQsQp7DThQajAi83uJKw+xxoJt1r77iKh+KfMSS
         TUISdCfRgNM8uLTzDk6+cmMIoFBfbGBs8FjsLWFZAfrcd6oJCmTJoxCRDSRwrHossxbj
         JBlmT2rjffuu6YNIuTyZB5bApU6qp3VzhoBShyXm/JSEt3C+/86M3SzZPHByhCTnlXRt
         9O554FZ1vIqkle/KY6qAZc+r8OnLI/WOYu1LqtiAFRTWhuUC7CbCmajZyb03LqFYcWRU
         DHHvUNpRu9pK7CJZbVt9h+ZAVCG+zGQRAl1hcKuJLBlUpV4WpP3Zd9gtPzqNVfBkqMy+
         M/Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zYdPbZEw8RqlZ22TbJCRLd3GVrM3tg+B5RqJqspAiyE=;
        b=avAOc31mCqaIeyA5mZTpQaud3HM+Zsjs864MzguXbCGNTekqJDjLbFEnA1hjFVWqTG
         CN3D6gRyMydwlCVcNI0pZyDrYK25BAdVUwAhVgOenn2LXm00/jaDQpLEayix5Se2URhe
         XC+ZOlEM7/B63KndKQmbq+axw5ssTjUp8xFs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zYdPbZEw8RqlZ22TbJCRLd3GVrM3tg+B5RqJqspAiyE=;
        b=m5bRBuqEAa34NhQ6tems1wk1IXqwxA7axGj5wx+A4m4ETMCujzvoYSQ8dlqd2Y2quu
         MTHLfzU5/5MtiRkmOXzxoNoN15jAQPXc4rawN7S14vLvnHKFtWuY6g/S4j6GR+afTvji
         Ngg/uKI5hT6x51vZXMDC2f+d/suoJ9t2Vv2LqdlP62EETRtLaactOuUrxh5qqUnAE7oH
         iXvF15jQr5drxwi3I8XiBr8zT4R0sEH85CVIcOyTNKrVBPmFg7kUlJbS5hoP6qnnItd5
         987fnj2Uw/A280BZzLx7bPUyObnS2uAMJyDwYtoakkrGwYpDucyIR2ljY0BXFCsmaaFe
         XEoQ==
X-Gm-Message-State: ALoCoQlT93Te45npSKG+R/m9PPESaK7s/WLePzm8BgTBGgEHKz/ucgKRxeAPbhvupv3KvlGkUfeY
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr62331839qkh.56.1430864183408;
 Tue, 05 May 2015 15:16:23 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Tue, 5 May 2015 15:16:23 -0700 (PDT)
In-Reply-To: <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <1428444258-25852-2-git-send-email-abrestic@chromium.org>
        <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
Date:   Tue, 5 May 2015 15:16:23 -0700
X-Google-Sender-Auth: pF4Q6c-14YsOGpRPK7XkLhjP6cA
Message-ID: <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
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
X-archive-position: 47244
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

Hi James,

On Tue, May 5, 2015 at 3:01 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Andrew,
>
> On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
>> Add a binding document for the USB2.0 PHY found on the IMG Pistachio SoC.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> ---
>> No changes from v1.
>> ---
>>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 ++++++++++++++++++++++
>>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
>>  2 files changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
>>
>> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> new file mode 100644
>> index 0000000..afbc7e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>> @@ -0,0 +1,29 @@
>> +IMG Pistachio USB PHY
>> +=====================
>> +
>> +Required properties:
>> +--------------------
>> + - compatible: Must be "img,pistachio-usb-phy".
>> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
>> + - clocks: Must contain an entry for each entry in clock-names.
>> +   See ../clock/clock-bindings.txt for details.
>> + - clock-names: Must include "usb_phy".
>> + - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
>> + - img,refclk: Indicates the reference clock source for the USB PHY.
>> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid values.
>
> Possibly dumb question: why isn't the reference clock source specified
> in the normal ways like the "usb_phy" clock is?
>
> Does the value required here depend on what usb_phy clock gets muxed
> from or something?

Right, the value indicates what clock "usb_phy" is: whether it comes
from the core clock controller, the XO crystal, or is some external
clock.  It's a mux internal to the PHY.

Thanks,
Andrew
