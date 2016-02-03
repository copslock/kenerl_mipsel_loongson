Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 11:36:10 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35783 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011397AbcBCKgHlYkFO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 11:36:07 +0100
Received: by mail-lf0-f46.google.com with SMTP id l143so10709831lfe.2
        for <linux-mips@linux-mips.org>; Wed, 03 Feb 2016 02:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=mRbhrxjKtz7/lhNBLN4T7aJeITM5LMIz7Egt7JQbM0U=;
        b=pW2qgQ5gX55o3I1Aqi+TbExJs6BUAaxYKOK8JunyZVjFFWuewMDO2UELkM4XyCsFT8
         pVt0HTKrDPg4NKxKE9RoYMY1NAzNVra3c2SavftUQsfccD39Eez8G8NpKCAUt2iAAQzs
         U6DXB/KQY9LKlYTzqh8mu8kH4Ng7Up3wGuFFOgeebzqKVQGwHASkvne44rPyWO331pbh
         Epyt/q1eieDaABES7s4IlxF9KTJht8Noa/uE1/lKO7nFmof/ShQx/n93OVUHorcXelID
         sLGbEcPEh9G6aSJHoxpJX+NU+mmaAkUogSTfR9xNZJV/Jz+4t0LweRUYumvdAgD4mNv9
         Tm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mRbhrxjKtz7/lhNBLN4T7aJeITM5LMIz7Egt7JQbM0U=;
        b=XXLdoFKykRFMxiO9HtrZQZt6JYBDzR++OHn+KkjHbhxhZlw7bJuePia1sothQfGTn6
         ddgOOkLDdoq3xo9w5wEEtWY3A+/Vw6U9lzuyQwkExJsJUoWazsr0N6Y+kUeNtJ8SEuOi
         PZqc1YMTkCqfrkLsCsCrLxdmb3JeNgL/JaFitJu1SU03v1r+Ru0l3f0oUaFLzKSsltpg
         VPEXDVLFOUnYvfFwQrMQz+0poasFcghAZ9U+HHcrjhD/hJq7rATg752abfpqB9xojN4/
         7OdVvu6BMgP1q4ERJG4+tigd7dks49LMzgYiQKmyFOJy76IpnAtYd5yqBtCCgXpaefoQ
         qr/w==
X-Gm-Message-State: AG10YOTwgmlSy8vRwA6LLCIArRjIIk6RhmyxU8ANYdv8dzdx3jUtTM7XyDG/QIHzMyXAMg==
X-Received: by 10.25.5.6 with SMTP id 6mr324949lff.3.1454495762276;
        Wed, 03 Feb 2016 02:36:02 -0800 (PST)
Received: from [192.168.4.126] ([83.149.9.191])
        by smtp.gmail.com with ESMTPSA id ra6sm793819lbb.33.2016.02.03.02.36.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 02:36:01 -0800 (PST)
Subject: Re: [PATCH 4/5] MIPS: Support R_MIPS_PC16 rel-style reloc
To:     Paul Burton <paul.burton@imgtec.com>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
 <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
 <56B1D5B5.6050208@cogentembedded.com> <20160203103255.GA21157@NP-P-BURTON>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B1D810.4040606@cogentembedded.com>
Date:   Wed, 3 Feb 2016 13:36:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160203103255.GA21157@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51658
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

On 2/3/2016 1:32 PM, Paul Burton wrote:

>>> MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include the
>>> R_MIPS_PC16 relocation. We thus need to support R_MIPS_PC16 rel-style
>>> relocations in order to load MIPS32r6 kernel modules. This patch adds
>>> such support, which is similar to the rela-style R_MIPS_PC16 support but
>>
>>      R_MIPS_LO16, you mean?
>
> Hi Sergei,
>
> No, I mean it's similar to the R_MIPS_PC16 code in module-rela.c. That
> is, its rela-style equivalent (rather than rel-style as here).

    But you're *adding* R_MIPS_PC16, no?

> Thanks,
>      Paul

MBR, Sergei
