Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 22:55:33 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32893 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009741AbcADVzbgA-xb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 22:55:31 +0100
Received: by mail-lf0-f49.google.com with SMTP id p203so285777863lfa.0
        for <linux-mips@linux-mips.org>; Mon, 04 Jan 2016 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TdXDHcTR3JGAMW7JhBV+tYw6JaxsLz4QssrOzODBsDA=;
        b=xe+D/xYrFUnMVzZHDN4HibYEhcd6AnW3f25pr4+aAfrKpmXFO2d0/G9IVSd5qbcow8
         VqEzKBRaqmMV2Ea/Eo3j+R+lipCE/VAmKNHfHvbh+6JgM90Bnu8P1hOj0bCO8qeG3uF1
         zglvXm/2yG1uWGhUBMCgfY7Fbgxe39QVHtXU+bG9NTHfF74l4xm/6HypXEg+lvwdLY1G
         tFL0NqMBuSAzJ34ujDLwkYpens7lGX04DbvUP+M3GfUVwfRohWvY0FfIzh/ctMn3FlHd
         s5/Qvvms0l7PREpHjx3iXAmLqp/bu+dXQxoSLtQMpGehiINvO9LzZjvoF9xl16hOejK4
         NKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TdXDHcTR3JGAMW7JhBV+tYw6JaxsLz4QssrOzODBsDA=;
        b=cwsrw4wiZ9TrrsC7MfopV8rHFhUY7auBloDTMgSQFJ6Yv4LrMclFDVT5b4qtJxb7+/
         /csgsdc6S/uu9Ai+qcybaKKv9+o2fX3ChuIutcaZFM5Q/7PyZHJKPQr1e+qUM8uh9LIB
         FZG89WgbAAtNfVXoAx1Kqpk5tjjueFhPGHId++psjCoR0h5Fk2cc8X7U6GsqZ4Sj5WIu
         AJ2SFgtWFVjhAEQpQhhsWlbE0Qi9GBYzHmoaS5YhM5G59uXw+/PbL2cnXGLw2WkZNCf5
         Ea/VC2nx5Ra5UGB/hBZ3CabpRmZLwBeuC0W9l9gU9x7z2pCjIvHH7kUzQ5ilaIweQPRB
         EmOQ==
X-Gm-Message-State: ALoCoQkqjkuJuSXo7IAL60Ufic58WevK+gi+HyxVdVPjAyer0FIcWV+f4+xG0+po/1BF8DLa6gtxNadUEOyP+QdGwUBF/x4h1Q==
X-Received: by 10.25.165.133 with SMTP id o127mr23105738lfe.105.1451944526091;
        Mon, 04 Jan 2016 13:55:26 -0800 (PST)
Received: from wasted.cogentembedded.com ([83.149.9.222])
        by smtp.gmail.com with ESMTPSA id ki2sm15805732lbc.15.2016.01.04.13.55.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jan 2016 13:55:25 -0800 (PST)
Subject: Re: [PATCH 1/2] MAINTAINERS: add myself as Lantiq MIPS architecture
 maintainer
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1451935693-40889-1-git-send-email-blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <568AEA4C.10803@cogentembedded.com>
Date:   Tue, 5 Jan 2016 00:55:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1451935693-40889-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50888
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

On 01/04/2016 10:28 PM, John Crispin wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 018f8c7..1456890 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
>   # the comments on that file.
>   #
>   ifndef CONFIG_CPU_MIPSR6
> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
> +  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)

    What?

[...]

MBR, Sergei
