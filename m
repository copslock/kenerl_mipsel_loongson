Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2016 08:39:40 +0100 (CET)
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33819 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990552AbcL1HjdPJsLg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Dec 2016 08:39:33 +0100
Received: by mail-pg0-f65.google.com with SMTP id b1so14913587pgc.1;
        Tue, 27 Dec 2016 23:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e4G1FHv/NQsqYqrkO6EIWdCElBqeN8spQPGza3YPSwg=;
        b=r/wHT6wRPgDYWWNZ0twiteIJGf49pWpI131sU49mYYZk9Y4XX/1WbMDhSOIB9vigiM
         4z/VRxqggqufHOFNqALOVUlbhw7vza7WEUUxfoEmwvMJWEPLHtefVSCjlbkusIsyGDjz
         h8iJd4qBYs525Ux5E94sQv/YGLK4/4c50C2IJEWSnUN4wCWwVssdftqwdWjbQsB409py
         JkU8CZNqw9GL3lL/D2r8ZFQkoIcl+87uATeB3C8FpDwpac9kyZ5USybhORGS8b9n1Scz
         URE6zhlRAXoYqLYSRqwjBNyrSVjTyU9RPADf0hv8HZkuPR2GSF0rz9XbYCMvfT4zlZVN
         ivyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e4G1FHv/NQsqYqrkO6EIWdCElBqeN8spQPGza3YPSwg=;
        b=etiRBc7etcRoMO5fd67sVPafdE62TgvYeGjC3pe98MRrtAAnVOZQQxm56gjMegnxhg
         4+cRanBPH1wxFG637NwRPFyxQp1hfgHVz/acdutjiTUIMb75X9mZvLgW+NoVbFVJdWrt
         k/NLmT+ibKac8UWGpY/nVhzXTI0BuTyKYlqorhbXf0qPFuFzq/L4JJ4FPmjyrycIgkAk
         9QuDG3qSt/8RqikTheiKTtG7OjD5NX6FqJ0d7PMgqw8+l5V/c+jNltLhHd0s7u8XapcL
         r3WGWRxStkGNZNbaoc8gc3MJy1O9SNoAhMToCooCOjcrjl14VCRcJ7NRSPIg9Oewz8Iz
         8mOg==
X-Gm-Message-State: AIkVDXK7L3Qr3rE/YD63SoyPixHpMUh7NfH2XNVWpl3iqrJIpg7ggEEr2MEB0C3mcUPwBw==
X-Received: by 10.99.112.66 with SMTP id a2mr65362022pgn.43.1482910765640;
        Tue, 27 Dec 2016 23:39:25 -0800 (PST)
Received: from [192.168.10.100] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q2sm95191395pga.8.2016.12.27.23.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 23:39:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 2/2] MIPS: BMIPS: Add support SPI device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <0dffeca2-68bf-bacd-7eff-8b966c721dde@gmail.com>
Date:   Wed, 28 Dec 2016 16:39:20 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8BB6A4C9-96EF-42E1-8144-808B9C70E8EE@gmail.com>
References: <20161227015923.882-1-jaedon.shin@gmail.com>
 <20161227015923.882-3-jaedon.shin@gmail.com>
 <0dffeca2-68bf-bacd-7eff-8b966c721dde@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3259)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56130
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


> On 28 Dec 2016, at 7:12 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 12/26/2016 05:59 PM, Jaedon Shin wrote:
>> Adds SPI device nodes to BCM7xxx MIPS based SoCs.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> arch/mips/boot/dts/brcm/bcm7125.dtsi      | 55 +++++++++++++++++++++++++++++--
>> arch/mips/boot/dts/brcm/bcm7346.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7358.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7360.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7362.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7420.dtsi      | 55 +++++++++++++++++++++++++++++--
>> arch/mips/boot/dts/brcm/bcm7425.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7435.dtsi      | 49 +++++++++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
>> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
>> arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 ++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 ++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
>> arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
>> arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 ++++++++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
>> 16 files changed, 526 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/mips/boot/dts/brcm/bcm7125.dtsi b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> index bbd00f65ce39..c1e19e57f64a 100644
>> --- a/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> +++ b/arch/mips/boot/dts/brcm/bcm7125.dtsi
>> @@ -46,6 +46,12 @@
>> 			#clock-cells = <0>;
>> 			clock-frequency = <27000000>;
>> 		};
>> +
>> +		spi_clk: spi_clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <27000000>;
>> +		};
> 
> Nit, this should actually be upg_clk, since this is the clock that the
> SPI controller uses, and it is a fixed-clock with a 27Mhz frequency.
> 
> Other than that, the rest looks good to me, thanks!
> -- 
> Florian

I will change the qspi uses upg_clk in v2.

Thanks,
Jaedon
