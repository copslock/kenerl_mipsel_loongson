Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 19:16:37 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33950 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011972AbcBASQgA24HS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2016 19:16:36 +0100
Received: by mail-lf0-f46.google.com with SMTP id j78so32392931lfb.1
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2016 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hI/NNEesXWhXQ2MTLdCND/0m4CmJ4DKVhILlX6WW6kk=;
        b=oxw4dfozVHviO5o9aA3zHWNJMlYM8d6fLTGVlI/L0XLjAWpS84VKrjMzq3Y4VHe3CG
         r9bOZ8rEDfL5H4VNpwbNk1qnMLDxsDfUbWoiHK/YjcItWXQm/Df9K/k3gUqpBkCYxly3
         46M6+8kX9od5YUm6jCewAh61tUhRy9M8fxxgzZexUQwOXV3mDaQ+k18WITLiVwo2gGJj
         klGxPCg+nihLmc9ra6pTCyoVybe4doADKHqSdK/7gzJ3fXDQS3+LK9wTS9JBnOFOPRPg
         tMUcVqbD0NQejHz9y4Pxikq85Fx8EejNqVyHBzCmgmiQRZok7pM/1reir4tHqs0268fl
         nvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=hI/NNEesXWhXQ2MTLdCND/0m4CmJ4DKVhILlX6WW6kk=;
        b=ObZBPX78tsrlfUoHWdy8rJdkY2ouTb9stC2DJovGIT/CD9CMzIbTBEeAU+M46RkQkn
         +wWPVuD9I1Oq+IVMirK8V3ZZO3GX7RRL5RBQGM02T7TE7ZmtQkCR0w3kAf8J0FliS5be
         E8QUPj0i1zFt5yYwA3PBjxueu/jWqRtMLZwtIW8BYHdjnO7LokdVop6Y6FAh+DQFFg6V
         KdmW6njOUPVPA15t0qqTvzIK1wuLQyKpDqTlo7g5XKnyGanu6m3BnWqab4e1L/163iCQ
         KPjTRGa2CCG29HOfQ41lMth4QftHQV85EvdfU+5ietjUTC310j1sj1t8YfpRBCzUSPCI
         Ln7A==
X-Gm-Message-State: AG10YOTXHm6GJcA2YP2pR4hGonFRUHUoKpUhe3iy/6dzCQCHm2tvlKazQDqadKkXmpv63g==
X-Received: by 10.25.40.139 with SMTP id o133mr7394286lfo.10.1454350590457;
        Mon, 01 Feb 2016 10:16:30 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id m21sm4204384lfe.29.2016.02.01.10.16.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Feb 2016 10:16:29 -0800 (PST)
Date:   Mon, 1 Feb 2016 21:41:54 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [RFC v3 06/14] MIPS: dts: qca: ar9132: use short references for
 uart and spi nodes
Message-Id: <20160201214154.d4242555ea8e9f5da6a7abfa@gmail.com>
In-Reply-To: <20160125233148.4951e311@tock>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-7-git-send-email-antonynpavlov@gmail.com>
        <20160125233148.4951e311@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51592
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

On Mon, 25 Jan 2016 23:31:48 +0100
Alban <albeu@free.fr> wrote:

> On Sat, 23 Jan 2016 23:17:23 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> I personally prefer the version without aliases :) Is there any
> guidelines on this?

Here are some Sascha Hauer's arguments for using aliases in the dts files:

 - Using aliases reduces the number of indentations in dts files;

 - dts files become independent of the layout of the dtsi files (it
   becomes possible to introduce another bus {} hierarchy between a
   toplevel bus and the devices when you have to);

 - less chances for typos. if &i2c2 does not exist you get an error. If
   instead you duplicate the whole path in the dts file a typo in the
   path will just create another node.

And here is a Marek Vasut's additional argument:

 - Aliases allow you to introduce some sort of ordering. For example if you have
   gmac0 and gmac1 and you want to have them ordered correctly, you use aliases.
   (in case we're talking about the /aliases node).


> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  arch/mips/boot/dts/qca/ar9132.dtsi               |  4 +-
> >  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 70 +++++++++++-------------
> >  2 files changed, 35 insertions(+), 39 deletions(-)
> > 
> > diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
> > index cd1602f..a14f6f2 100644
> > --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> > +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> > @@ -61,7 +61,7 @@
> >  				#qca,ddr-wb-channel-cells = <1>;
> >  			};
> >  
> > -			uart@18020000 {
> > +			uart: uart@18020000 {
> >  				compatible = "ns8250";
> >  				reg = <0x18020000 0x20>;
> >  				interrupts = <3>;
> > @@ -134,7 +134,7 @@
> >  			};
> >  		};
> >  
> > -		spi@1f000000 {
> > +		spi: spi@1f000000 {
> >  			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
> >  			reg = <0x1f000000 0x10>;
> >  
> > diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > index 9618105..f22c22c 100644
> > --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > @@ -14,43 +14,6 @@
> >  		reg = <0x0 0x2000000>;
> >  	};
> >  
> > -	ahb {
> > -		apb {
> > -			uart@18020000 {
> > -				status = "okay";
> > -			};
> > -		};
> > -
> > -		spi@1f000000 {
> > -			status = "okay";
> > -			num-cs = <1>;
> > -
> > -			flash@0 {
> > -				#address-cells = <1>;
> > -				#size-cells = <1>;
> > -				compatible = "s25sl064a";
> > -				reg = <0>;
> > -				spi-max-frequency = <25000000>;
> > -
> > -				partition@0 {
> > -					label = "u-boot";
> > -					reg = <0x000000 0x020000>;
> > -				};
> > -
> > -				partition@1 {
> > -					label = "firmware";
> > -					reg = <0x020000 0x7D0000>;
> > -				};
> > -
> > -				partition@2 {
> > -					label = "art";
> > -					reg = <0x7F0000 0x010000>;
> > -					read-only;
> > -				};
> > -			};
> > -		};
> > -	};
> > -
> >  	gpio-keys {
> >  		compatible = "gpio-keys-polled";
> >  		#address-cells = <1>;
> > @@ -100,3 +63,36 @@
> >  &extosc {
> >  	clock-frequency = <40000000>;
> >  };
> > +
> > +&uart {
> > +	status = "okay";
> > +};
> > +
> > +&spi {
> > +	status = "okay";
> > +	num-cs = <1>;
> > +
> > +	flash@0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "s25sl064a";
> > +		reg = <0>;
> > +		spi-max-frequency = <25000000>;
> > +
> > +		partition@0 {
> > +			label = "u-boot";
> > +			reg = <0x000000 0x020000>;
> > +		};
> > +
> > +		partition@1 {
> > +			label = "firmware";
> > +			reg = <0x020000 0x7D0000>;
> > +		};
> > +
> > +		partition@2 {
> > +			label = "art";
> > +			reg = <0x7F0000 0x010000>;
> > +			read-only;
> > +		};
> > +	};
> > +};
> 


-- 
-- 
Best regards,
  Antony Pavlov
