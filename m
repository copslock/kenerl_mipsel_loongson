Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 20:08:51 +0200 (CEST)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34875 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033624AbcEXSIshSObP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 20:08:48 +0200
Received: by mail-pf0-f176.google.com with SMTP id g64so9399947pfb.2;
        Tue, 24 May 2016 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=YgW0PiLodsK4Yoc+Ww1BWx5sEKxidGXBr6UAtNnA9QI=;
        b=ap+rRAHUaKkytTTxLNEH6tHpReCof+i7qm2689u8AqJtCbtdFZzDVH3fCgi10iZUBp
         uEjE9MkEsU7NRRGifufYaGnFILmqOmrSIgoZydqwDLzoTxRu+/LU168iLAIbjgK0z3/z
         xLsMP5QH8QHGyWcwymLmhaF/XytsrfnQI4eUOpML+zRgHQprEYDcNbogtd+93fuBmI7y
         9bR/eejmP2vcwO8kFggA0Yh2Ianfba3jrrrl9j3VVcuYkcv4+jIjMlmClP4NS7Qrq0kR
         3z+z0GjLSJLd2f0YsldAZA3AvemSTdeZdvd5gJ+rKTLu0zmlaWBlXjtcIKXf1UdoD3HT
         BRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=YgW0PiLodsK4Yoc+Ww1BWx5sEKxidGXBr6UAtNnA9QI=;
        b=IVklsx86w1+A5pNaFxDUhXLnAq/05f8Nqa82OS4B2XCCNpGL5o/+3lRdkQlvvs7Uor
         DBqYsadzhXq8IqpmzVk0VMB6UcDfUXUckg6GrD0rQ4kWlGuILPpK2268nICl830r7rU6
         37dqA13CDML6EylFtZH8ujc9VFeCt0mxKneBPJKxPvUyK5dz412b0Lq3G6qmGoX881bW
         vuoaQIHqK66CkeBdvnuf+GSQWdsuoSVfUu9PYEu7hcjG8s/mLMFJrhZh5l01Ev5Gw0Dr
         QTH0W1rjAzqqABHonUDk/X9VrB9qNUFNfhuueqhUWA7N+uI2s+vuyAHt3b1L2l+5zR5T
         GOYw==
X-Gm-Message-State: ALyK8tIM186RN2sDBWAL7DnYI6mPVN9lT8Dm1EWNY0d0+b/kN3IoLfFMvG3RqHbSW8GlbA==
X-Received: by 10.98.30.131 with SMTP id e125mr8951135pfe.32.1464113319175;
        Tue, 24 May 2016 11:08:39 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id dh4sm6808334pad.37.2016.05.24.11.08.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 11:08:38 -0700 (PDT)
Message-ID: <574498A4.7050002@gmail.com>
Date:   Tue, 24 May 2016 11:08:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Subject: Re: [PATCH 2/2] MIPS: OCTEON: setup: rename upper case variables
References: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com> <1464098971-9362-2-git-send-email-aaro.koskinen@nokia.com>
In-Reply-To: <1464098971-9362-2-git-send-email-aaro.koskinen@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/24/2016 07:09 AM, Aaro Koskinen wrote:
> Rename upper case variables.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/cavium-octeon/setup.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
>
[...]
