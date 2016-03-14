Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 19:27:31 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36831 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007808AbcCNS13m9cpH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Mar 2016 19:27:29 +0100
Received: by mail-lb0-f174.google.com with SMTP id x1so251110508lbj.3
        for <linux-mips@linux-mips.org>; Mon, 14 Mar 2016 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyzlK+NtjOr0lVZalQ2oOfLiwwuYWZZxP/6ybMbd+Fs=;
        b=IcUGbmV4UBQZ+Z1Jpi1wvXX8Jb8Tg0tIFgOjbe4BKO0b4wo+uFOqskW2h/UrQoZUN0
         PYIsCfiRQEbDeuq1brvOlMWj2HCrdH69j6H9oj6X+nTypGmCBTi+fGfg3DdiRZj2Su6w
         lCoRIpd66WRpS8dn9lyuBOg8AGzN1wP50apvFYk6vx9XpLUjEEDhOrRkOraah24kZcC/
         RTttVuwwDKgGzs4BypcBi1jHcA5TXaJwTqoISJAKLHZQMQy5rHeKw2IgzY4eBmBRNeK3
         ngDq4OoiXW988EnC0ZT1qeYOrtOqjDSMZSU5tuPWf2ToU1ULaCjhbiPMG9EqErMv8fUB
         Xa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyzlK+NtjOr0lVZalQ2oOfLiwwuYWZZxP/6ybMbd+Fs=;
        b=P5yr/5tJQbiiJSTR+va34LFDaby/aNVUduT9hgndRpV7X36nKJF7o2wHsezC9KiKtQ
         eT6wxmBBvZMhv80NLSAfFuHKsxmRMZLg+YcquSQdjn6NC3ai7k8vEaLcZstT1XALEIu3
         SfdcYYc5Zf4B8JeaX2627w/70Te37yET/xpFLrSqlWCcKWdfZwyQYrUECUWo6oBiJlvL
         lR/OcB6hr2eUg3LLGx2F6IAShmXapDmkc0x8w4nk4JncfPKI1aSCRjyeB0u+qqW4x1X0
         P3BQ3u8dlhzvtg5rmRAlG2pMiyXi8Fgf3b5C+qo4i27S7ctviQSTPScSZzdxPp36rVls
         fzeg==
X-Gm-Message-State: AD7BkJJ/4utcELYYTjH49fZDCDmjuVpU8FhXZiWgcbC+hCOpTh/cgFAjf54YGgQMdznE7w==
X-Received: by 10.25.168.67 with SMTP id r64mr6549351lfe.104.1457980044182;
        Mon, 14 Mar 2016 11:27:24 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id td7sm3678650lbb.6.2016.03.14.11.27.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2016 11:27:23 -0700 (PDT)
Date:   Mon, 14 Mar 2016 21:53:45 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 08/14] MIPS: dts: qca: introduce AR9331 devicetree
Message-Id: <20160314215345.00df3fa56c363061e730572e@gmail.com>
In-Reply-To: <20160125234630.16098b7f@tock>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-9-git-send-email-antonynpavlov@gmail.com>
        <20160125234630.16098b7f@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Mon, 25 Jan 2016 23:46:30 +0100
Alban <albeu@free.fr> wrote:

> On Sat, 23 Jan 2016 23:17:25 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > This patch introduces devicetree for Atheros AR9331 SoC (AKA Hornet).
> > The AR9331 chip is a Wi-Fi System-On-Chip (WiSOC),
> > typically used in very cheap Access Points and Routers.
> > 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Gabor Juhos <juhosg@openwrt.org>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/boot/dts/qca/ar9331.dtsi | 123 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> > 
> > diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
> > new file mode 100644
> > index 0000000..bf128a2
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/qca/ar9331.dtsi
> > @@ -0,0 +1,123 @@
> > +#include <dt-bindings/clock/ath79-clk.h>
> > +
> > +/ {
> > +	compatible = "qca,ar9331";
> > +
> 
> [...]
> 
> > +
> > +	extosc: oscillator {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +	};
> 
> This oscillator is on the board and not in the SoC, so it should
> be in the board DTS.

However oscillator is inside SoC!

Please see https://en.wikipedia.org/wiki/Electronic_oscillator

    An electronic oscillator is an electronic circuit that produces a periodic,
    oscillating electronic signal, often a sine wave or a square wave.

Please see AR9331 data sheet: the SoC has no input for external oscillator,
only two pins (XTALO and XTALI) for connecting 25 MHz or 40 MHz quartz crystal.
The crystal can't produce a square wave itself! The crystal is only a part
of a complete oscillator.

So we have a good reason to put basic oscillator node into the SoC dtsi-file.

-- 
Best regards,
  Antony Pavlov
