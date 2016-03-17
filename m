Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 14:05:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:40299 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013685AbcCQNFJfAr-I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 14:05:09 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 7D51E2034A;
        Thu, 17 Mar 2016 13:05:06 +0000 (UTC)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A21D20364;
        Thu, 17 Mar 2016 13:05:03 +0000 (UTC)
Received: by mail-yw0-f169.google.com with SMTP id g3so98852241ywa.3;
        Thu, 17 Mar 2016 06:05:03 -0700 (PDT)
X-Gm-Message-State: AD7BkJL2s8574Pr+HU3Itb/hxtscWPLi7MqBnNwX+Krg5yT5y8ee3stQPm3M+p4jR4Aq1t7S6q0h2We6POLzhA==
X-Received: by 10.129.157.2 with SMTP id u2mr3813016ywg.198.1458219902885;
 Thu, 17 Mar 2016 06:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.229.68 with HTTP; Thu, 17 Mar 2016 06:04:43 -0700 (PDT)
In-Reply-To: <20160317060223.e14ebbdf05224845279843c3@gmail.com>
References: <20160317060223.e14ebbdf05224845279843c3@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Mar 2016 08:04:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLGKW1beZET0brr7DDXbrz1ufi8i=OT-+drUu5cPkYLCw@mail.gmail.com>
Message-ID: <CAL_JsqLGKW1beZET0brr7DDXbrz1ufi8i=OT-+drUu5cPkYLCw@mail.gmail.com>
Subject: Re: WARNING: DT compatible string vendor "mips" appears un-documented
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52646
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

On Wed, Mar 16, 2016 at 10:02 PM, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> Hi all,
>
> checkpatch.pl notes that DT compatible string vendor "mips" appears un-documented.
>
> On the one hand there are several users of this vendor string:
>
>     linux$ git grep \"mips,
>     Documentation/devicetree/bindings/mips/img/xilfpga.txt: - compatible: Must be "mips,m14Kc".
>     Documentation/devicetree/bindings/mips/img/xilfpga.txt:                 compatible = "mips,m14Kc";
>     arch/mips/boot/dts/lantiq/danube.dtsi:                  compatible = "mips,mips24Kc";
>     arch/mips/boot/dts/qca/ar9132.dtsi:                     compatible = "mips,mips24Kc";
>     arch/mips/boot/dts/ralink/mt7620a.dtsi:                 compatible = "mips,mips24KEc";
>     arch/mips/boot/dts/ralink/rt2880.dtsi:                  compatible = "mips,mips4KEc";
>     arch/mips/boot/dts/ralink/rt3050.dtsi:                  compatible = "mips,mips24KEc";
>     arch/mips/boot/dts/ralink/rt3883.dtsi:                  compatible = "mips,mips74Kc";
>     arch/mips/boot/dts/xilfpga/microAptiv.dtsi:                     compatible = "mips,m14Kc";
>
> On the other hand we already have the "mti" vendor string:
>
>     linux$ grep MIPS Documentation/devicetree/bindings/vendor-prefixes.txt
>     mti    Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>
> Can we add an another one vendor string for MIPS?

No.

It is called checkpatch.pl, not checkfile.pl (yes, I know it can check
files too). There are many warnings if you look at the tree as a
whole. The main point of the checks (at least for DT) is to not
introduce new warnings.

So mips is deprecated and shouldn't be used for new bindings (perhaps
mti is too as img? should be used now). Continuing to use the existing
strings is fine.

Rob
