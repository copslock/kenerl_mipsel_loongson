Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 00:17:12 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32921 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbcHJWREb8tPs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 00:17:04 +0200
Received: by mail-oi0-f66.google.com with SMTP id s207so5013761oie.0;
        Wed, 10 Aug 2016 15:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckzlcAVrF/CqnTai35aouQ1H5OuwCOq7zPd3V0AGC4Y=;
        b=LWYyhFFLfQx+dk5/uhlV1rCG2Y5C9y+VF9Zp9jqyX1uKxGwY3uQrRWiXC+Gby8m7Px
         RIl5tU8qT51/Jfr6ZPXZ52UOnMlgcq0ArhEkpWZbT+P1NVcyfPS+FHfqOdY+yTypDDbX
         Sj7I3tuTKfg9U11t7iDTyxdz1M5uW1ANe8vHpriPFBgKsw3OaJtkX0KnBm0xGVhwbhw8
         8KvVb+yjO4O5EQZW/pDFUO5hDzCFnqakhtpvV+RwE46Tpb8Ciff0HnCm0nDipFhNQPwF
         +N9CzrpjlqH9t5XUKjEXr+GnUVBox+3QHExMuhoT7Jf1KK2E/eFHuntf6cG00TqM7JoN
         q0yA==
X-Gm-Message-State: AEkoouvR9Lerm16A9IXZkONhMmcXf0ZgBD9bbAJCF6OtW2PTQkrddLSMvH3c+6chmiX7xQ==
X-Received: by 10.157.12.10 with SMTP id 10mr95975otr.18.1470867418627;
        Wed, 10 Aug 2016 15:16:58 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id n39sm86476otn.10.2016.08.10.15.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2016 15:16:58 -0700 (PDT)
Date:   Wed, 10 Aug 2016 17:16:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 17/20] dt-bindings: img-ascii-lcd: Document a binding for
 simple ASCII LCDs
Message-ID: <20160810221657.GA20008@rob-hp-laptop>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-18-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160809123546.10190-18-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54474
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

On Tue, Aug 09, 2016 at 01:35:42PM +0100, Paul Burton wrote:
> Add documentation for a devicetree binding for the simple ASCII LCD
> displays found on development boards such as the MIPS Boston, MIPS Malta
> & MIPS SEAD3 from Imagination Technologies.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  .../devicetree/bindings/auxdisplay/img-ascii-lcd.txt    | 17 +++++++++++++++++
>  MAINTAINERS                                             |  5 +++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt b/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
> new file mode 100644
> index 0000000..b69bb68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
> @@ -0,0 +1,17 @@
> +Binding for ASCII LCD displays on Imagination Technologies boards
> +
> +Required properties:
> +- compatible : should be one of:
> +    "img,boston-lcd"
> +    "mti,malta-lcd"
> +    "mti,sead3-lcd"
> +
> +Required properties for "img,boston-lcd":
> +- reg : memory region locating the device registers
> +
> +Required properties for "mti,malta-lcd" or "mti,sead3-lcd":
> +- regmap: phandle of the system controller containing the LCD registers
> +- offset: offset in bytes to the LCD registers within the system controller
> +
> +The layout of the registers & properties of the display are determined
> +from the compatible string, making this binding somewhat trivial.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20bb1d0..d08cf6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1971,6 +1971,11 @@ S:	Maintained
>  F:	Documentation/hwmon/asc7621
>  F:	drivers/hwmon/asc7621.c
>  
> +ASCII LCD DRIVER
> +M:	Paul Burton <paul.burton@imgtec.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/ascii-lcd.txt

Wrong path and filename.

> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> -- 
> 2.9.2
> 
