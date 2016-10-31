Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 10:50:53 +0100 (CET)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34925 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbcJaJupNg1r3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 10:50:45 +0100
Received: by mail-lf0-f50.google.com with SMTP id f134so93869485lfg.2
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2016 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=LQwcoeipMxhZlBcN3kmvlg/eNqFZ9JZsRYwps8iqsCw=;
        b=FZsHppmS0uWsinSLn7LdhQLDQb3M8JuCY7n4S58FmMySSgtp+EkKrElhyB/es2O7mN
         t7HbYAlR7k8iDouc+pprkga8kFRkMn/eAaqzqSTB+N7CmRhoQEe8qYIqfSale95NcW07
         /nO9LwOPa4eFHMrsyBkbIHcpWxbGMWcxIAR77AMcSxEZBnL4SEk5ZB5d4cmjtF9GLCMd
         4CE9cr/uxk7BPmCr5BDdOcxO9ZYkH2Y/j44/AqZ+wxCMov2WAfCv6++FMLpEQSpqyYEs
         oxD3sq6uVq+Ydiuk0MrlOKWx32zODMfXeC0T3yozqK1wMdi0lS8hbWjWj6jjn8lwFpxS
         gmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LQwcoeipMxhZlBcN3kmvlg/eNqFZ9JZsRYwps8iqsCw=;
        b=OXFFweii9dcdJED8i6JI9xvDHdDQkV6qA/xj37ItPvJRmcAiT2fdyG6UAH9n+1HzZH
         6ohzUy5q3p789gWKrSEsP1j1QwdUIOn9153YN8UZDpYXPexvDZ22zguZ/pNht1VXImQf
         twR1gixCTSQF1FrrUwtpFk+GCaEuAKLmUtCWfx3o7cv4ln/khqRqZrbLGMUZGByVVngY
         yedvWfo1xAcK0koxOag7hkAbhxSLYIgivsoy05MKd8WWUXcCQjcX9W+/eB5lC9vUowMH
         GPP+UnBwASZvZBm4Z9g23itTNc0Z+Klel3MtbaLToYCOz9dXD8itCvETxzx6V8imToy/
         TpjQ==
X-Gm-Message-State: ABUngvdurw2F0g8Mw2AxlhIaQoDUoPuoMZPxQAHL3cOKipekVInqj8cXMrRZkVtgTT3V3Q==
X-Received: by 10.25.17.88 with SMTP id g85mr1959848lfi.10.1477907438697;
        Mon, 31 Oct 2016 02:50:38 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.80.82])
        by smtp.gmail.com with ESMTPSA id j137sm4377923lfj.40.2016.10.31.02.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 02:50:36 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] MIPS: jz4740: DTS: Probe the jz4740-rtc driver
 from devicetree
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
 <20161030230247.20538-6-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0c9af39c-85e4-5372-2285-620b2c2863ad@cogentembedded.com>
Date:   Mon, 31 Oct 2016 12:50:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161030230247.20538-6-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55607
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

> Now that the jz4740-rtc driver supports devicetree, we can add a
> devicetree node for it.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> v2: Previous patch 5/5 was garbage. This is a new patch.
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index f6ae6ed..c6acd6a 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -44,6 +44,17 @@
>  		#clock-cells = <1>;
>  	};
>
> +	rtc_dev: jz4740-rtc@10003000 {

    Just "rtc@10003000" to comply with the DT spec.

[...]

MBR, Sergei
