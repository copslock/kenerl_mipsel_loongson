Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 21:34:38 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35564 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcAaUegenv77 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2016 21:34:36 +0100
Received: by mail-lb0-f172.google.com with SMTP id bc4so64633811lbc.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wkSI4eih72Ht8b/4Bc05Ij8XLGMkyLsBEiiw8BcZO84=;
        b=QuBR2yA/N/b702wkand482TEsHY99dRvWvIdOOIxKsYQ9484dnIRie7DosxANz0WqX
         Vr3MpwXY1xEWqZ1/+4xrW4BGLpsi7CCr5FOaZ1vyhaKBNOy8SxALO7+tHrqG7xd0BXuX
         /w70iq9u/P7iCm246WldNZUo9vtILmYMJ7NTStoRB2QSYDiESuHFTUU9u5K7aMG86CHd
         1dTsMefl1Vbd+3a1uo6Swn9X8QxgH7OKXaAhBI/itxH5vHV4NTIGLkiC89nMHfoKj1l5
         YhgREbu3cEML2iljE3TnNuFitqfUFypxwfaVP7HM7sRKTte6TGUrTNOz5LCI2uErwVNk
         Faqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=wkSI4eih72Ht8b/4Bc05Ij8XLGMkyLsBEiiw8BcZO84=;
        b=a/nPE7xPuIIQTZH7y4GnCJ32mL8jwju0Rz1Uc24jmzYpZzIm7n4vTNXRkjmI8ObMVM
         FxjFYWMUUBGmw9uJyWchtVdGmIRYwAf+dFScu9ekmo84bIHhXXz4qhu3tQ8om/LjaLF0
         8fLl3TXFMGmarpV6eej8k5Gn5yZs0Gmw0SkvUuHEsyg5xhUjhZ/qHsAZUOEkj+VtQ9m7
         BzAh9JD+P2uXQhiz9h+htbLJrWpyVwTCZVoeZHXMKa1Ov7DUkm1HIv70ywyIBPEp92kq
         Gk58mV0oUPOnn0SD9pWhL0SoFdYB3ZsJorZBHoZHMI+zslFWZE9QodrobcuZgicHvK9n
         pEcQ==
X-Gm-Message-State: AG10YOTRXonxYXiyT8RgcS/qj3O768Lx3XrmJDJA1omqSFdkQsieqxy+D+GKGXPwEUU5gA==
X-Received: by 10.112.140.71 with SMTP id re7mr5932012lbb.73.1454272471123;
        Sun, 31 Jan 2016 12:34:31 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id k3sm3591635lbp.9.2016.01.31.12.34.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jan 2016 12:34:30 -0800 (PST)
Date:   Sun, 31 Jan 2016 23:59:54 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC v3 08/14] MIPS: dts: qca: introduce AR9331 devicetree
Message-Id: <20160131235954.255ec9cb48ab36f6dc64a67f@gmail.com>
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
X-archive-position: 51556
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

This oscillator is always has to be connected to the SoC, it's abligatory thing.
So there no logic incosistency in adding this oscillator node template to SoC's dtsi file.

This oscillator node is not describes oscillator completely but this node
makes it possible to introduce oscillator early so we can make reference on
it just in ar9331.dtsi file. So we have no need to make full oscillator description
in every board dts file.
Futher is we make full oscillator' description in a board dts file then we have
to additionally describe binding of the oscillator to SoC's clk block.



-- 
Best regards,
  Antony Pavlov
