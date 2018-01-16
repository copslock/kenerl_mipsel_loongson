Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 09:23:06 +0100 (CET)
Received: from mail-wm0-x233.google.com ([IPv6:2a00:1450:400c:c09::233]:35641
        "EHLO mail-wm0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeAPIW7pWPSV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 09:22:59 +0100
Received: by mail-wm0-x233.google.com with SMTP id r78so6736244wme.0
        for <linux-mips@linux-mips.org>; Tue, 16 Jan 2018 00:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pH6HtlovRR8oWlm7VvT8AazU5Jd5SPB9hHbZaSBAfvg=;
        b=EDO7+sYBK5paqHupAauLC5fcPtG8OzFiR81d+8VV3cYl28Dq0OrA7Ch8YhiSboetaY
         g6eTewEGW/kzzPxcIHNzEevKQn8V8ru/QRqhuRJtJKsnTVMqCoHGrBDBFbyMMZW8N18k
         mehS2QjhpPDQnjG0Sysi3ewRcKM1QJT+esMBkFxpx/oBMQkIdubh7u3XNCk8Fw4guCMe
         45koVTAnhE4pyWjg8ismKr/BC8CG7Tny/MXKXX6Cvdvw9mkW929HpkDjs2iCApAnr/Bs
         cUP+7RzSzn88bWpmmwSB1Y7VGtyw9UJKVk6A/+Pc4yNBCmlM/NvwsE4glv/0sfT00B+T
         qq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=pH6HtlovRR8oWlm7VvT8AazU5Jd5SPB9hHbZaSBAfvg=;
        b=SRuv1I5gjeiJLaYbkkg5AlecFyf1Hq61S4d6awDLz4MgvgyyeVO/1znJSA6dpWVlWR
         JDNMcIbhboEoBxQHRMfatO4oo+m/jwkfRXwkD8IPSBePrU77Z5adOt04speFgqwUMnuN
         UhxTbX/WGftbB/6jlvoyeSkyq3yxeFRoAaLjc22dc0HcwB6UkJs7WgwrXpiTm9czLtNR
         o8T+dDeUK3v6bsnz5VtZI5iVRSxZqqa0htw9YA484WSi9Q7QHiderFmFPJ5B4Sx2v3g3
         Ojtkn/fBKRVWblHEkrI1Ipq9G22ZO2gqf+8nDo2AhXr8FZAMchttvnpjckiOdJs9NKS4
         i2sw==
X-Gm-Message-State: AKGB3mIcAUbso9x45opyrM7Z0JKVO1bvRc9LregXFW6OcD0KM8zmtMST
        JyWc52Zy33iI0/lRMQm3gJ0=
X-Google-Smtp-Source: ACJfBou4SDHVZHXGT+karKwsnvfj081d+vT1PPRXnc7hiR59K7G8MX+Jdtbprtbx8CtjsOn1vQ+Y5g==
X-Received: by 10.80.135.8 with SMTP id i8mr51135425edb.87.1516090974346;
        Tue, 16 Jan 2018 00:22:54 -0800 (PST)
Received: from ?IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88? ([2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88])
        by smtp.gmail.com with ESMTPSA id h16sm1021611edj.34.2018.01.16.00.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 00:22:53 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: consolidate swiotlb dma_map implementations
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180116075338.GB12693@infradead.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
Date:   Tue, 16 Jan 2018 09:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180116075338.GB12693@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <ckoenig.leichtzumerken@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ckoenig.leichtzumerken@gmail.com
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

Hi Konrad,

can you send the first patch to Linus for inclusion in 4.15 if you 
haven't already done so?

I'm still getting reports from people complaining about the error message.

Thanks,
Christian.

Am 16.01.2018 um 08:53 schrieb Christoph Hellwig:
> I've pulled this into the dma-mapping for-next tree, including the
> missing free_pages noted.  I'd be fine to rebase another day or two
> for additional reviews or important fixes.
