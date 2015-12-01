Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 12:16:20 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36456 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006924AbbLALQSHHBwY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2015 12:16:18 +0100
Received: by lfs39 with SMTP id 39so3369609lfs.3
        for <linux-mips@linux-mips.org>; Tue, 01 Dec 2015 03:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Gu1N8mnjl+4tMq2pqR1OQYobwjYg/VQJj2fvH+gklSw=;
        b=bHOxvmDgr9lzoj6TdgTG2ZaE+4Kbe7rq+dVtjhvKKZRVoTFslTprIjC9uz4dav9MX4
         81ISSnnsuX18AfDB8993+Mg1ozekhISwmhyoCui0s/UuNfQXBBXRX5Jbwjfnx51hrCgp
         CeRL4GjQzzrl6iZ5AvJvdoqVbh9dvkMFKBr39rppl+htiBnFYPqv9XJ6oPuMIrMawyRd
         btsnM4gQJSFHYncccUd2tJtpv1hKqIrLnJl68wWhljmiqxGQihF8Qwq+/8YSrk4+A7gh
         APM1QkCeZ5ENHMA+2asLPH0XayMuEHPe8p7bCkt42Ps7H1Op1bLs2Gds0LhDCi3GGpGx
         8oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Gu1N8mnjl+4tMq2pqR1OQYobwjYg/VQJj2fvH+gklSw=;
        b=X/Grr193EmQIN++Dj8+jXlL4I2M6viXfqQ/Zee/ChEqPkf7lef92qtJuU4w5DiXY6W
         KHplclOiSFZ9eySE91wRDy0P6EiTk1YiEq9ijA5khoSqXV81DqrK3zKDYt8wZKj6zpeZ
         4zO2sCwHKg0P0LG9XJ4BvHSEEuu0Bk/YPP0kxGXHCo3WFGaLYuM+/13U2o8HgwZmosOI
         t1VRUamPbWK/99bV+flVIurSGPDeyXqE3C5VFPRz7TX2Xi/bxGHoYfT0N8bIaxwkSPIC
         WwRmg/9/ExqpyRk2Gk3dNtJ4M0rEEM7oCjeFO1QvlKfiOBqERf//b7UtQbGyq0gthFey
         RcSg==
X-Gm-Message-State: ALoCoQnQ2u3ir+RJsoSn4BZezi1DZ12YJoSiqJmgdKEOmmOXOL4bdEtJf0QUi5RWRBoG1cdaj4wP
X-Received: by 10.25.19.69 with SMTP id j66mr28585046lfi.25.1448968572157;
        Tue, 01 Dec 2015 03:16:12 -0800 (PST)
Received: from [192.168.4.126] ([195.16.110.19])
        by smtp.gmail.com with ESMTPSA id g80sm8240482lfg.44.2015.12.01.03.16.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Dec 2015 03:16:10 -0800 (PST)
Subject: Re: [PATCH 1/2] reset: Add brcm,bcm63xx-reset device tree binding
To:     Simon Arlott <simon@fire.lp0.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <565CB83B.7010000@simon.arlott.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <565D817A.2030607@cogentembedded.com>
Date:   Tue, 1 Dec 2015 14:16:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <565CB83B.7010000@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50251
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

On 11/30/2015 11:57 PM, Simon Arlott wrote:

> Add device tree binding for the BCM63xx soft reset controller.
>
> The BCM63xx contains a soft-reset controller activated by setting
> a bit (that must previously have cleared).
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>   .../bindings/reset/brcm,bcm63xx-reset.txt          | 37 ++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
>
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
> new file mode 100644
> index 0000000..48e9daf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm63xx-reset.txt
> @@ -0,0 +1,37 @@
> +BCM63xx reset controller
> +
> +The BCM63xx contains a basic soft reset controller in the perf register
> +set which resets components using a bit in a register.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm63xx-reset"

     Wildcards (xx) are not allowed here. Please choose a "least common 
denominator" SoC and name the string after it.

[...]

MBR, Sergei
