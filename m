Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 10:52:46 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32786 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009835AbcAEJwiZOE-h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 10:52:38 +0100
Received: by mail-lf0-f46.google.com with SMTP id p203so293078328lfa.0
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 01:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=AIZHUlFlL5qU7rH5/TaHWU8W7wl+auIIXtRj9EWRPAY=;
        b=NinoMZrY+ejIVHI9HxtpVF9xZzI1krVk+QfEb3kjC0helLEnLA+mBlLFnPHqEaGxg5
         9nRKYyqhSfQZPfUD294of1jb94amGTBoSb+qUwygsxZC3D6OVazmpdvvZRboDVKn+s+A
         7sznulETvdGeSSAF4Hz8jf5u4ZXGaFXozy6dpLFWpn6JSPOfKPv4/zdZYYirMlmtM+6+
         GpXCXi4azq40MLq9bJv1r2JSfHezDDUmJmWM0kdukLu1hju0EWJJwQAHfWS2d5wLdltu
         laV7cVPVTx8C8y5+aKUkodMQohBJ0S/ymGQAClcwZC0nGQYTGFfHBErtApCNkE23RQq9
         f3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AIZHUlFlL5qU7rH5/TaHWU8W7wl+auIIXtRj9EWRPAY=;
        b=OnY38LiEpAa7eObg5aNbXUS/k7Mpgp4Wiq49RcpT/sIqz8lqbZfJZVbfVcQc/g8Lad
         Rqv6LLx50Ph47W/HXoohuDetvA1E9+s8m/5eL6NcKixUlmydsAmOpddxbCZafTSBrb0u
         RLi8LjDpZEyL/jI3XiRpLUJr75hmLwNZrUfYLV9e6fNjM/U9pOR373XysetbUUsOJKQu
         FOXlCDbrrc4GJWfINcfpIBpI2WFbXE/iF9YEXBPx2kw0BJq2O0jU/sYe5zoBdhfhu2Sq
         O/KAyvHC4fDa0a/zfCtUW24clyuQmLoLGxNVv7iX+Eqr8HzMsDpmWwfBaV8DqMEHLsWg
         rCDw==
X-Gm-Message-State: ALoCoQmY9FB9i9FV1fxCiE5xS5kaiat2E+HLroUB7eMczcrnbAXafF6qHg2wr5nG8LIziuD2zYpf/MjWSYCo7WhyZ8uuSHKE7A==
X-Received: by 10.25.17.89 with SMTP id g86mr9168892lfi.82.1451987552924;
        Tue, 05 Jan 2016 01:52:32 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.203])
        by smtp.gmail.com with ESMTPSA id t9sm11284559lfd.13.2016.01.05.01.52.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 01:52:31 -0800 (PST)
Subject: Re: [PATCH 6/6] MIPS: Fix some missing CONFIG_CPU_MIPSR6 definitions
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
 <1451973549-16198-7-git-send-email-chenhc@lemote.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <568B925E.4020401@cogentembedded.com>
Date:   Tue, 5 Jan 2016 12:52:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1451973549-16198-7-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50909
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

On 1/5/2016 8:59 AM, Huacai Chen wrote:

> Commit be0c37c985eddc4 (MIPS: Rearrange PTE bits into fixed positions.)
> defines fixed PTE bits for MIPS R2. Then, commit d7b631419b3d230a4d383
> (MIPS: pgtable-bits: Fix XPA damage to R6 definitions.) adds the MIPS
> R6 definitions in the same way as MIPS R2. But some R6 definitions in
> the later commit is missing, so in this patch I fix that.

    You're adding #ifdef's, not definitions.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
[...]

MBR, Sergei
