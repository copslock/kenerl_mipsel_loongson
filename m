Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 10:48:51 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36800 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbcJaJsnsbyJ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 10:48:43 +0100
Received: by mail-lf0-f47.google.com with SMTP id t196so12585156lff.3
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2016 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=675JJEib1VaDDjql4fVGKkXXejEOyMdjW5odH1LVERQ=;
        b=iqfcn5euSVvWABVB2LOorqmD5tox3a3f42iWbgq8tYl/ltZHH5og0cHP0SZQ2STZxj
         r1C0dpl/F/I/UzbKzV8Kp5OKrPwBK/s830XP3CepjYT6zUI/mZWBDvoQgqRyy/2f27GA
         Yxh2nPJvC12LQ3MiT6ygmepiuGchkq1PqPNgk46yCoRojzcrj2vt8oH6jezsxEe+Rwcl
         OziI8QwiEWY6rkK77cv0efdk6kOSf8SG1cx4tTBWXlRSNBQb1xrEVAYnrmAsKJuo0WB6
         GpGoF9lnufYqQbdVqxyIxf92jmq+dOkDhF8So68epxKLMwonmHXHQ9KMGznObINbbU1H
         q0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=675JJEib1VaDDjql4fVGKkXXejEOyMdjW5odH1LVERQ=;
        b=HgrXC+KMuzX5YAxsq0xHHH+OVdB3JPpFfa0VoOoti1UF202wa8zBDsKTSacSVPAfZt
         dsK9YWsEHsR6GaVv2CE1atUvrjiqo+5yu0xrUwKMGWrS7NzyEwFlhEyUNJtF/xSfsYwy
         wgVbvaUrPLXuwqgHeEHWfni3t3IaGH+j88KyG3CJDuv0500emfdh19Euz6pLEmKfrszJ
         hp/aBsQRWHDr/iIhvtlFFUf3cicRpCsdqVcJ2g2iVfzdZkXQMqONboQrHsFOnJwqE0ot
         iy4sxWM1WP+s2f4nI+z92/kH4XTAXr3caiZjpFrur3qQOxlg0zXhiPW8EpBxgnPt6Ymg
         2BLw==
X-Gm-Message-State: ABUngvdEIbAiu6mYIAePVwpTfh0fafpIWeL7qxN4PkSGbnmdV+0ToRlsjLqEVSU30jt4mA==
X-Received: by 10.25.31.199 with SMTP id f190mr13858194lff.49.1477907318237;
        Mon, 31 Oct 2016 02:48:38 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.80.82])
        by smtp.gmail.com with ESMTPSA id 127sm2164973ljf.27.2016.10.31.02.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 02:48:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] Documentation: dt: Add binding info for jz4740-rtc
 driver
To:     Paul Cercueil <paul@crapouillou.net>, rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161030230247.20538-3-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <27537b7b-2485-d51c-b2e1-cfd6ba29e5bf@cogentembedded.com>
Date:   Mon, 31 Oct 2016 12:48:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161030230247.20538-3-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 10/31/2016 2:02 AM, Paul Cercueil wrote:

> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>
> v2:
> - Remove 'interrupt-parent' of the list of required properties
> - Add the -msec suffix for the DT entries that represent time
>
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> new file mode 100644
> index 0000000..df97594
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -0,0 +1,37 @@
[...]
> +Example:
> +
> +rtc@10003000 {
> +	compatible = "ingenic,jz4740-rtc";
> +	reg = <0x10003000 0x3F>;

    Are you sure it's not 0x40? It's a size, not a limit...

[...]

MBR, Sergei
