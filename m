Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 03:44:35 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33276 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992685AbcHIBo2EMD4y convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Aug 2016 03:44:28 +0200
Received: by mail-pa0-f66.google.com with SMTP id vy10so21826pac.0;
        Mon, 08 Aug 2016 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pvt5XTcNzJY0DPmbaaB7wegp7exzr/t7HK3mg8ZuJEk=;
        b=GwewY0lQeH+6lF4bvE2qfTSNloZm2IdsfwERw0xWNwUdZtlNI6FlNgaGWFGsW11MBQ
         eMfSvr3PuCI/fWAHrFVLu7jzbaZcs5N1sL4+wYzQ6rCJikCiSjV+tBQ/s9np2/jhDHdA
         uMFU6Fkg/k7op5RwVXcyXcj10CNsk0MoFACCYFe28micMEQb10tSivJQDPvg1JyM3dWA
         1UDoNrxOEx+YboXAOKztIQ1nJeYHZBJPu6+89KY8EttgYPKd38GC6wn9y6Ek0/FlP2CL
         GOqsgw6uFN8noI6JDgpSAXWvggOSmq6hn4ZNJLKSPTU0fjwnyMHERpxT4wKb8G1hErmj
         T4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pvt5XTcNzJY0DPmbaaB7wegp7exzr/t7HK3mg8ZuJEk=;
        b=gTtSSIqiOxOVsrLusHElOp9sRZt05vp6FRI710QOpiT47CAxNAXnSrePuKdJP5kKBL
         9hqURYv2oRYCeQX7lvMLaP7YBbmTH9j85asMb+A3uVYU6sQE+fXgI0Y1QWopD9HWCKiH
         aofuZOce82NEf3AX1rgbsrCxHfzbtsKxOKL+y8gzMZIDTKyStvAvS38cPA+4eitbiKoH
         pwcbFzYJik3o1hWBR3nQDVzeeZ9q55aNSk532mVbGG+z5lID3Eggop+VDflqM6uF7H5w
         nXksknPmZwtJMRdVqqHTAjo/d1792N9x8LDDSMtTfaFKDzDIzm18pMszOlq5rDQi9lN2
         8lXw==
X-Gm-Message-State: AEkoouuGHycarQwTECgFVcd7wjhPfcA2b6jfBpMTuhFoc0qrLml9VgWcwVx46Cd5PM68Gw==
X-Received: by 10.66.16.97 with SMTP id f1mr10095254pad.39.1470707061451;
        Mon, 08 Aug 2016 18:44:21 -0700 (PDT)
Received: from [172.16.1.101] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q1sm50976229pfd.48.2016.08.08.18.44.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 18:44:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] MIPS: BMIPS: Add support GPIO device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAOiHx=kxjXiYm_4S3rLOjB0wM-UpQsqfXn+EVq6+FGOH4whuuQ@mail.gmail.com>
Date:   Tue, 9 Aug 2016 10:44:14 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D5F26D94-8312-4CAC-8577-205A1AAFB0E5@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com> <20160808021719.4680-3-jaedon.shin@gmail.com> <CAOiHx=kxjXiYm_4S3rLOjB0wM-UpQsqfXn+EVq6+FGOH4whuuQ@mail.gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Jonas,

On Aug 8, 2016, at 11:06 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> 
> Hi,
> 
> please always include devicetree for any dts(i) related changes.
> 
> On 8 August 2016 at 04:17, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Adds GPIO device nodes to BCM7xxx MIPS based SoCs.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> arch/mips/boot/dts/brcm/bcm7125.dtsi      | 12 ++++++++++
>> arch/mips/boot/dts/brcm/bcm7346.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7358.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7360.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7362.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7420.dtsi      | 12 ++++++++++
>> arch/mips/boot/dts/brcm/bcm7425.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7435.dtsi      | 37 +++++++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 ++++
>> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++++++
>> arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 +++++++
>> arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++++++
>> arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++++++
>> arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 ++++
>> arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 +++++++
>> arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 +++++++
>> 16 files changed, 302 insertions(+)
>> 
>> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> index 97191f6bca28..746ed06c85de 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> @@ -197,6 +197,18 @@
>>                        status = "disabled";
>>                };
>> 
>> +               upg_gio: gpio@406700 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406700 0x80>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 18>;
>> +               };
>> +
>>                ehci0: usb@488300 {
>>                        compatible = "brcm,bcm7125-ehci", "generic-ehci";
>>                        reg = <0x488300 0x100>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
>> index eb7b19a32e3e..1ef7540238be 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
>> @@ -232,6 +232,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408440 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408440 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <52>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406700 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406700 0x60>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 16>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@408c00 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x408c00 0x60>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <27 32 2>;
>> +               };
>> +
>>                enet0: ethernet@430000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
>> index b2276b1e12d4..bb099ee046a1 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
>> @@ -216,6 +216,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408240 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408240 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <49>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406500 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406500 0xa0>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 29 4>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@408c00 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x408c00 0x60>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <21 32 2>;
>> +               };
>> +
>>                enet0: ethernet@430000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
>> index e414af1e14ff..0aeb3de7fbc2 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
>> @@ -208,6 +208,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408440 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408440 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <49>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406500 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406500 0xa0>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 29 4>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@408c00 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x408c00 0x60>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <21 32 2>;
>> +               };
>> +
>>                enet0: ethernet@430000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
>> index 3bd1c0111d43..9a1f6ffc343d 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
>> @@ -204,6 +204,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408440 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408440 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <49>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406500 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406500 0xa0>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 29 4>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@408c00 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x408c00 0x60>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <21 32 2>;
>> +               };
>> +
>>                enet0: ethernet@430000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7420.dtsi b/arch/mips/boot/dts/brcm/bcm7420.dtsi
>> index 27c3d45556b9..0d391d77c780 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7420.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7420.dtsi
>> @@ -213,6 +213,18 @@
>>                        status = "disabled";
>>                };
>> 
>> +               upg_gio: gpio@406700 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406700 0x80>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 27>;
>> +               };
>> +
>>                enet0: ethernet@468000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
>> index 9ab65d64e948..04306a92b8eb 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
>> @@ -231,6 +231,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408440 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408440 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <48>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406700 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406700 0x80>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 21>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@4094c0 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x4094c0 0x40>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <18 4>;
>> +               };
>> +
>>                enet0: ethernet@b80000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
>> index 7801169416e7..c4883643ab61 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
>> @@ -246,6 +246,43 @@
>>                        status = "disabled";
>>                };
>> 
>> +               aon_pm_l2_intc: aon_pm_l2_intc@408440 {
> 
> interrupt-controller@
> 
>> +                       compatible = "brcm,l2-intc";
>> +                       reg = <0x408440 0x30>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-parent = <&periph_intc>;
>> +                       interrupts = <53>;
>> +                       brcm,irq-can-wake;
>> +               };
>> +
>> +               upg_gio: gpio@406700 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x406700 0x80>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       brcm,gpio-bank-widths = <32 32 32 21>;
>> +               };
>> +
>> +               upg_gio_aon: gpio@4094c0 {
>> +                       compatible = "brcm,brcmstb-gpio";
>> +                       reg = <0x4094c0 0x40>;
>> +                       #gpio-cells = <2>;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-controller;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&upg_aon_irq0_intc>;
>> +                       interrupts = <6>;
>> +                       interrupts-extended = <&upg_aon_irq0_intc 6>,
>> +                                             <&aon_pm_l2_intc 5>;
>> +                       wakeup-source;
>> +                       brcm,gpio-bank-widths = <18 4>;
>> +               };
>> +
>>                enet0: ethernet@b80000 {
>>                        phy-mode = "internal";
>>                        phy-handle = <&phy1>;
>> diff --git a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
>> index 5c24eacd72dd..91590ff55d52 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97125cbmb.dts
>> @@ -49,6 +49,10 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set its status in the dtsi, it will be enabled by default,
> and you can drop this change.
> 
>> /* FIXME: USB is wonky; disable it for now */
>> &ehci0 {
>>        status = "disabled";
>> diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
>> index 2c55ab094a29..e91a21f75a13 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
>> @@ -57,6 +57,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
>> index 757fe9d5f4df..d475a152eb2a 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
>> @@ -53,6 +53,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
>> index 496e6ed9fae3..a445a45f51cb 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
>> @@ -49,6 +49,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> index b880c018f3d8..22b1b506594f 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> @@ -45,6 +45,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97420c.dts b/arch/mips/boot/dts/brcm/bcm97420c.dts
>> index e66271af055e..428c36da91b6 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97420c.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97420c.dts
>> @@ -59,6 +59,10 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set its status in the dtsi, it will be enabled by default,
> and you can drop this change.
> 
>> /* FIXME: MAC driver comes up but cannot attach to PHY */
>> &enet0 {
>>        status = "disabled";
>> diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> index f091e91b11c5..6adfcd505a03 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
>> @@ -59,6 +59,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
>> diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> index 9db84f2a6664..dd8b8fb97053 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>> @@ -59,6 +59,14 @@
>>        status = "okay";
>> };
>> 
>> +&upg_gio {
>> +       status = "okay";
>> +};
>> +
>> +&upg_gio_aon {
>> +       status = "okay";
>> +};
>> +
> 
> You don't set their status in the dtsi, they will be enabled by
> default, and you can drop this change.
> 
>> &enet0 {
>>        status = "okay";
>> };
> 
> 
> Regards
> Jonas

The status="disabled" has been missing. It will be added in v2.
The interrupt-controller@ will also be changed.

Thanks,
Jaedon
From jaedon.shin@gmail.com Tue Aug  9 03:52:41 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 03:52:47 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36527 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992776AbcHIBwkxATDy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Aug 2016 03:52:40 +0200
Received: by mail-pa0-f68.google.com with SMTP id ez1so24477pab.3;
        Mon, 08 Aug 2016 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jf+N09uu9v2ZtEAv1jF++dgYHzTOIVR8bSXHlkR+yTE=;
        b=y+lXD65D5FS9hZ6z/kdSV6vTnFbEKKSctHm+N1S3qq07+NrxoKhOg+gXSngYYG2MzV
         jQdWdCZbcdayce26H46afyAbKmBI6+tBse6Sdk26OAOD+XJNgHoyUKFQgHdZCS3FK64A
         9+iAqmFuXqnuoBExh2unmR8+o4cBjissgGFu8aiJG7W/Mc3AtJKu/AXLPPC+e8KuSfb9
         YqjLHSuiOJ9V6cYxZBQfPU+CE0XGsUfVtEmZa+jHTv6RehIEsuGjK87JXMzP5gDjvdx6
         D5XP8xUB+ELclTFtXJhaBX830z1/TFbGNpOCsCFatEI2Q5A3RlNddxveo30NdP6IEnlG
         PyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jf+N09uu9v2ZtEAv1jF++dgYHzTOIVR8bSXHlkR+yTE=;
        b=mkp+6kk1YBBvCsE6Uw4AgzmV9THJTC8ZtFA1mWjS0OW1eSyvkFIwOLGwovk8kZxL2g
         m+4yA5MP7lBGGmwoL3XDETZ00+GsY7FcGxfBgWT4XTzbuXGZYPQSQlTHRU1BWhAcNRik
         1KX8vKZ4rg6nyi05osZH4Wjt06gVHVPy3O57YJF/Mc+bG6bv0oIFc9G6y9g6MsfKV7YI
         1XKPDyEgZ+1wI881tnd0TEXHchT6WtQJE7WJta5RIwDKARyv6mkwpyTN684s5ORYfIdw
         w70pZGEfFbKP68k85ESUb0onkP9x0Yu0ZV0Gz3vV7Y1YMH77s4INwzmi7N0RS/Rx6LCs
         Gj1w==
X-Gm-Message-State: AEkoouuPCC0kRNRFsl8Ab30YNrxnAvyWkiGXGCL7HsJ6+S0ePLyj3xq5+DE6hqNeTJF5Ag==
X-Received: by 10.66.8.163 with SMTP id s3mr69077510paa.142.1470707555079;
        Mon, 08 Aug 2016 18:52:35 -0700 (PDT)
Received: from [172.16.1.101] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ty6sm51103798pac.18.2016.08.08.18.52.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 18:52:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/4] MIPS: BMIPS: Add support NAND device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <b6df94ac-9e29-f52d-c44e-f096a8735901@gmail.com>
Date:   Tue, 9 Aug 2016 10:52:30 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E3ECFDC4-D1E8-4282-8151-D0289E198209@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com> <20160808021719.4680-5-jaedon.shin@gmail.com> <bbc4731f-7d67-435b-0249-c823b8d158bb@gmail.com> <b6df94ac-9e29-f52d-c44e-f096a8735901@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Florian,

On Aug 9, 2016, at 7:40 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 08/08/2016 03:35 PM, Florian Fainelli wrote:
>> On 08/07/2016 07:17 PM, Jaedon Shin wrote:
>>> Adds NAND device nodes to BCM7xxx MIPS based SoCs.
>>> 
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> ---
>>> arch/mips/boot/dts/brcm/bcm7125.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7346.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7358.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7360.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7362.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7420.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7425.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7435.dtsi               | 20 ++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi | 24 ++++++++++++++++++++++
>>> arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97420c.dts              |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  5 +++++
>>> arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  5 +++++
>>> 17 files changed, 224 insertions(+)
>>> create mode 100644 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi
>>> 
>>> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>>> index 746ed06c85de..8642631a8451 100644
>>> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
>>> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>>> @@ -226,5 +226,25 @@
>>> 			interrupts = <61>;
>>> 			status = "disabled";
>>> 		};
>>> +
>>> +		hif_l2_intc: hif_l2_intc@411000 {
>>> +			compatible = "brcm,l2-intc";
>>> +			reg = <0x411000 0x30>;
>>> +			interrupt-controller;
>>> +			#interrupt-cells = <1>;
>>> +			interrupt-parent = <&periph_intc>;
>>> +			interrupts = <0>;
>>> +		};
>>> +
>>> +		nand: nand@412800 {
>>> +			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			reg-names = "nand";
>>> +			reg = <0x412800 0x400>;
>>> +			interrupt-parent = <&hif_l2_intc>;
>>> +			interrupts = <24>;
>>> +			status = "disabled";
>>> +		};
>> 
>> This is a NAND v3.3 controller here not a v5.0 and it uses the EDU
>> registers for DMA transfers which is not supported in the mainline
>> driver, so with that dropped, the series looks fine. At any rate this
>> would require additional brcmnand changes to be supported.
> 
> The same applies to the 7420 DTS, it's also a v3.3 NAND controller
> -- 
> Florian

The NAND device nodes of v3.3 NAND controller will be removed in v2.

Thanks,
Jaedon
From keguang.zhang@gmail.com Tue Aug  9 10:22:50 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 10:22:56 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34814 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992466AbcHIIWuW7mIG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 10:22:50 +0200
Received: by mail-pf0-f194.google.com with SMTP id g202so497753pfb.1;
        Tue, 09 Aug 2016 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=q1roB8jVF1/KfHkylfVPI2m6WlVgKtzJUM6/06CST3A=;
        b=SQ2yC0DWxdwlvnKuNgfgCrrPXmf6LJ1lQ6qwFM0Nd5suiMPiBaGU4v2fnBwhYtkvYr
         cOEAxb8dGAco4hqSfPmiL03QJ4XvvUA+RySmPVjGBUwumDjaBxO0cF06neAfNYlm2W0g
         XTQT3T/bHq4v+ZIEV1jXmgH7RA68PoFQ2Ns0jEG95vrQpwB9YvEiM3msnHppB3SIvuLs
         snNOv50jJLxx1/V2HNYSQq4VCiiMTpwNOWInyeePeGp96muFpPJpTGwr3Y6gx8bQeSQ0
         32u6UYiRpVUpqKYucPTRVB27vVRJ0SEtAZAFWtLTOv8und3v/MxzZSrqQtNjhv8RPXMn
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q1roB8jVF1/KfHkylfVPI2m6WlVgKtzJUM6/06CST3A=;
        b=REIt3gsot/1IwGdYJCb/t51oxhmvLeonWiR1u0W4M7ljyjYqQQRfGyvGAk6Y29p4SL
         VrYZ3lIwydsQ86nyamkksM3v5d6IOGdEuld/OooGmL3/nFOZE1/rzESQ2t3i7OuSqOef
         V9gwL3hP02Lzy5TWkVTJ/wp9qCbd3F7UNnjqQhzTWY9urlXQkT5OOe19sWqqfy67DFxD
         megWLoRNPLlBXr02izm+g8SFns+I+ZIONdGwHuyiRX1VQTvjFaUByS4NnwYDcp3Y8v88
         wu07k0lAJ83IPQu8JwZeIx/PbPIFZOyV9adVI/VAFCA+kPSuu6rQdf4LGlib5eP0/K7z
         STZg==
X-Gm-Message-State: AEkooutUu+3pJa0YKzPdSyoNdvXRm24Y8SJp+i6f8Mr4vZnGXDlAJHoChF4H4hyPo5yAHA==
X-Received: by 10.98.64.93 with SMTP id n90mr171095863pfa.29.1470730964063;
        Tue, 09 Aug 2016 01:22:44 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id ty6sm53812507pac.18.2016.08.09.01.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 01:22:43 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1] MIPS: Loongson1B: Provide DMA filter callbacks via platform data
Date:   Tue,  9 Aug 2016 16:22:25 +0800
Message-Id: <1470730945-24456-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch provides DMA filter callbacks via platform data
to make NAND driver independent of single DMA engine driver.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
v1:
   Fix the build error
---
 arch/mips/include/asm/mach-loongson32/dma.h  | 4 ++++
 arch/mips/include/asm/mach-loongson32/nand.h | 3 +--
 arch/mips/loongson32/ls1b/board.c            | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
index ad1dec7..d3ae391 100644
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ b/arch/mips/include/asm/mach-loongson32/dma.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_MACH_LOONGSON32_DMA_H
 #define __ASM_MACH_LOONGSON32_DMA_H
 
+#include <linux/dmaengine.h>
+
 #define LS1X_DMA_CHANNEL0	0
 #define LS1X_DMA_CHANNEL1	1
 #define LS1X_DMA_CHANNEL2	2
@@ -22,4 +24,6 @@ struct plat_ls1x_dma {
 
 extern struct plat_ls1x_dma ls1b_dma_pdata;
 
+bool ls1x_dma_filter(struct dma_chan *chan, void *param);
+
 #endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
index e274912..a1f8704 100644
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ b/arch/mips/include/asm/mach-loongson32/nand.h
@@ -21,10 +21,9 @@ struct plat_ls1x_nand {
 
 	int hold_cycle;
 	int wait_cycle;
+	bool (*dma_filter)(struct dma_chan *chan, void *param);
 };
 
 extern struct plat_ls1x_nand ls1b_nand_pdata;
 
-bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
-
 #endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 38a1d40..dac1cbb 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -38,6 +38,9 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
 	.nr_parts	= ARRAY_SIZE(ls1x_nand_parts),
 	.hold_cycle	= 0x2,
 	.wait_cycle	= 0xc,
+#ifdef CONFIG_LOONGSON1_DMA
+	.dma_filter	= ls1x_dma_filter,
+#endif
 };
 
 static const struct gpio_led ls1x_gpio_leds[] __initconst = {
-- 
1.9.1
