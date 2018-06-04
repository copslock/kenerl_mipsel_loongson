Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 21:43:37 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:38398
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994661AbeFDTn3jlfOa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2018 21:43:29 +0200
Received: by mail-qt0-x242.google.com with SMTP id x34-v6so28667838qtk.5;
        Mon, 04 Jun 2018 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Zbfko+XTXjlDFWcJSh9l7gWh7KRB+6vqv/PNwKg84A=;
        b=kN5LjvrpgCJj22DdYEtnZAmigDiFo3ugjqMmZtwvfTDKXk6J4WVzd+9L/lkzoHG1ZP
         8vuS7YYTnJmvcIoP0BGYiRHkIjNm9sMoPWVGO/PsA077rEBio0P++aXPiQSF+TFb/aj+
         mHAP6CuOfJXjd/+/7+2DUshK+KH8PSkkdcWVFo9H5qcQtYbRF0uZGFilmNc05Ds6ToQS
         u5HF2hX5rKcvv6Cpz0fsDDkPu0WuLUTw5efxUvTEj4TDmljUqtpdUdGxEJXn9/CEjVTX
         qdE8cRStPl4kyXq6iCKlrPZlMU36ErneLyMNApoXuvz4JJtvl+vQnuUBGzRUxAD673Qw
         Ny7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/Zbfko+XTXjlDFWcJSh9l7gWh7KRB+6vqv/PNwKg84A=;
        b=dU3SW+ng10BN9nfNME5dLftH0Wi5PAOpa68/NMur4Tpzg4EEW0CN7SE5d0uWUQ4Rmm
         xcJIWC9lO+rCmg9+F5MD89lizQYhX986QhgpjGaa9QU4l+mhKEEasGXd795bTlOo+4To
         Wn0VprRDBhcoVmBiR3IzqJ/MtJdaoYSh/bd8+glgDML5/U0yOZ55AeazvVm7neW2EDGU
         +M8hG0uBbBIR4pzZHcFQqp8jEj3wJ8UxLq5juvvwa4U7UbCogzjY7MSGp/Dq/7MQUHnK
         /l2H5HEqY5YN33dPYsB/rMOeCwgfJW8i4ZH79BvmbR82qPnhkF2c+kXtODYTqOLAw3+q
         H0nQ==
X-Gm-Message-State: APt69E2ZXmQV5kTYxZbP9C8WUawVEVO3a0+TCTJkTp9KVutIWxm1y7+N
        g+L1OYWBvbqE3FykA0mR2vI=
X-Google-Smtp-Source: ADUXVKLug3/wJC8J+J+waiIoswF7ezXBlSbVh38q7sYM3BTZMhnPtgFRv8WfvgF/sAFMc414GSXsjQ==
X-Received: by 2002:ac8:2cb5:: with SMTP id 50-v6mr17243218qtw.64.1528141403385;
        Mon, 04 Jun 2018 12:43:23 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id p51-v6sm2606986qtc.43.2018.06.04.12.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 12:43:22 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Paul Burton as MIPS co-maintainer
To:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W . Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>
References: <20180604165656.11589-1-jhogan@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <19329fd5-c834-cf71-19c6-d58424ced4c1@gmail.com>
Date:   Mon, 4 Jun 2018 12:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180604165656.11589-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/04/2018 09:56 AM, James Hogan wrote:
> I soon won't have access to much MIPS hardware, nor enough time to
> properly maintain MIPS on my own, so add Paul Burton as a co-maintainer.
> 
> Also add a link to a new shared git repository on kernel.org for
> linux-next branches and pull request tags.

Paul has been a long time contributor, so really no objections:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Maciej W. Rozycki <macro@mips.com>
> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Steven J. Hill <Steven.Hill@cavium.com>
> Cc: linux-mips@linux-mips.org
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bceccf9c1997..6122e3986c81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9320,10 +9320,12 @@ F:	drivers/usb/image/microtek.*
>  
>  MIPS
>  M:	Ralf Baechle <ralf@linux-mips.org>
> +M:	Paul Burton <paul.burton@mips.com>
>  M:	James Hogan <jhogan@kernel.org>
>  L:	linux-mips@linux-mips.org
>  W:	http://www.linux-mips.org/
>  T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
>  Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
>  S:	Supported
>  F:	Documentation/devicetree/bindings/mips/
> 


-- 
Florian
