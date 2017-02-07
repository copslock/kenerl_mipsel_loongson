Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 10:26:35 +0100 (CET)
Received: from mail-lf0-x232.google.com ([IPv6:2a00:1450:4010:c07::232]:36391
        "EHLO mail-lf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdBGJ01Vl-kq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 10:26:27 +0100
Received: by mail-lf0-x232.google.com with SMTP id z134so59338574lff.3
        for <linux-mips@linux-mips.org>; Tue, 07 Feb 2017 01:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YS97T8HJeBdpa+gtgFH1yQzHyDWyKjzTejC/s2WV5bw=;
        b=n/i4YPoFlDymnYt42vyC4om+pJM7YEexKo6iveoh3RO4wsULVp3ZvY8Zq8bRJiCkja
         CoRJNWYHG92ib/5y0Ki3jSiOK2TqncvD160ewS0TOUoRFE/E2BIQ4+Q2/LvZqhD1F/19
         wG+4MU9/0H9z2ObdC61UwOr1mEArO05a2rMnsKjJ0C0T1artMj5ojAN/OuNRgjmiHwDe
         riiuQiquXxpsgWA3dTjh+GcH/HDZaCAfUCeJwnYyxRZDuDGSbAOgOBFiMNbJpBXcymbq
         fqHaczsAf8+7YS+qkCzyGQwZPBSS54ir9PepBG0IUZJDInI6uLS4QgexT9DruuPUBoRK
         N4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YS97T8HJeBdpa+gtgFH1yQzHyDWyKjzTejC/s2WV5bw=;
        b=tUR06TpUiH5yQp7wPg0N7w0IdpSlLguTd08ocyvqvBvgSm4CrkduS6rF2Aq0RBC8ES
         JaeHzi7sd/02H3r4lt7ooQlpJaPfxe09HOcD52fQOERhCOoKIUkUBnoKa3QFFNELK7QL
         UkKupiSicOjJN2ruRNVJI0SmAuS4yYVsMNXJq1+ldMNcNshSZT4aq8OCcW/SS0V6Fbon
         bjtIdNjQadkQu/MnNcRN5flAunRbm6HLBdWuoND8yF/g22mKkX18paUDMowK57fMjXNd
         XfdZ7yccVW2Zn1K3uh8bBgWm5pB+XV/Au0ZK9VZegLThBn7rViWluwQpdS8EFmrWtZA/
         aLwA==
X-Gm-Message-State: AIkVDXJVCGv2ETDe8Gq+yjgj3caDHdl17pW4JDJsishurrDa6sNg6rT0aDdxHJguq6XfZw==
X-Received: by 10.46.87.92 with SMTP id r28mr1933804ljd.40.1486459581732;
        Tue, 07 Feb 2017 01:26:21 -0800 (PST)
Received: from [192.168.4.126] ([31.173.83.191])
        by smtp.gmail.com with ESMTPSA id w4sm1096172ljd.23.2017.02.07.01.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 01:26:20 -0800 (PST)
Subject: Re: [PATCH v4 1/8] MIPS: Loongson: Merge RPID macro for
 Loongson-1A/1B/1C
To:     Binbin Zhou <zhoubb@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1486452550-10721-1-git-send-email-zhoubb@lemote.com>
 <1486452550-10721-2-git-send-email-zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>, HuaCai Chen <chenhc@lemote.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3d751d79-d60c-e3f1-ebb9-1538820ae8ed@cogentembedded.com>
Date:   Tue, 7 Feb 2017 12:26:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1486452550-10721-2-git-send-email-zhoubb@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56696
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

Hello!

On 2/7/2017 10:29 AM, Binbin Zhou wrote:

> The Loongson-1 series CPUs(1A/1B/1C) share the same RPID macro.

    Maybe PRID?

> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: HuaCai Chen <chenhc@lemote.com>
[...]

MBR, Sergei
