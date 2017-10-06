Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 11:11:02 +0200 (CEST)
Received: from mail-vk0-x243.google.com ([IPv6:2607:f8b0:400c:c05::243]:32996
        "EHLO mail-vk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdJFJKiH6rHo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 11:10:38 +0200
Received: by mail-vk0-x243.google.com with SMTP id j189so4909274vka.0;
        Fri, 06 Oct 2017 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rY0Nk+O7BlqMbwNjxoNdJdE+KCsPhaj16iii0hOCIj0=;
        b=AMoOaeqyRCEfPsuC7xkfHWmX9eSDnvfLUvouwCQv1ODw20zj5WYdwwbQ1UveCR3PqS
         PP1eY+1cvR6tBc1yvt6/mr1pmvdnNk9jpuhGPxrFvGDx+BZSueqPYqt0Fi8sixVzqyny
         zPUUpXYGN5ZUjCZ/B+ks+Ez/wn5M6/c2ue7qbcMyrLrAGVQwTOxL9R7Q+zeYSMsI7B11
         /BPkA5mwTjnln7LHTLtwlrU0Zyl/2ruqMWdWVXsOsn6imTv8F/T2Q2HzxHwP95wUKxQw
         itW7xlE51bON9Dx3n5JkI9W7mfUgcI9ZGUHJar7IQyOer+YhJuIDOwnR6SLIQKZmJWNW
         ev8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rY0Nk+O7BlqMbwNjxoNdJdE+KCsPhaj16iii0hOCIj0=;
        b=VWgDodbZdmUy2x7mjJD0xgJ9BObllOGXHudDdNF+nbQ6OtBVmK2gkN8sXAabLXb60Q
         jM574mBanxN3A8VV0RLsvvxrPzMaz9w65opbXVU0MM8wQgagx+Ko+qbdKERIBRhAox+r
         TfLpQnAFzLPyzNh+IvrdPwV4BqS08JlS35sWKk6F6R04pchrirCiBRYLWLhzRyIssxpl
         gtRFauMSviAn5/4AHqiPBSYR7NR/4t4XI/iy/X971eSgGoyebuTOMxf6T+ToOd5BfnOT
         vn4PcVvJnvf0BoU4FzrtZrQIcm8j1ttjWsYp66dohpnjIYbkJuMurjBuTJYk2PLz2ZoJ
         GkCQ==
X-Gm-Message-State: AMCzsaWkGyq34MYPZkuVaX7hYRH2JcuiVaCDN7r4B21ELv8M9WpAP1DG
        O4sAwaLzK6BsRVhe8jKtsS2L6RfTDgqEmPNuk6Q=
X-Google-Smtp-Source: AOwi7QAo5p5Tl5qQDt0SmJEnhKhQIVELD2pS4597L6oDsSr1Jit2Q/r4eipW1/RrTZqY/6EVNUOQhSDHmP9ZAUUTypU=
X-Received: by 10.31.172.78 with SMTP id v75mr714328vke.75.1507281031649; Fri,
 06 Oct 2017 02:10:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.199 with HTTP; Fri, 6 Oct 2017 02:10:11 -0700 (PDT)
In-Reply-To: <20171006083842.248091756@linuxfoundation.org>
References: <20171006083840.743659740@linuxfoundation.org> <20171006083842.248091756@linuxfoundation.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 6 Oct 2017 11:10:11 +0200
X-Google-Sender-Auth: MOWgFtFjzvVZQCBkleHW1K15b2o
Message-ID: <CA+7wUszpNtwje0kPs07nDD2aSeYafSuW1dpX8+Z5HKOBSNC0eA@mail.gmail.com>
Subject: Re: [PATCH 4.9 010/104] MIPS: fix mem=X@Y commandline processing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi Greg,

Please do not apply to stable.

See: https://patchwork.linux-mips.org/patch/17235/

Thanks

On Fri, Oct 6, 2017 at 10:50 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>
>
> [ Upstream commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 ]
>
> When a memory offset is specified through the commandline, add the
> memory in range PHYS_OFFSET:Y as reserved memory area.
> Otherwise the bootmem allocator is initialised with low page equal to
> min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
> starting from min_low_pfn instead of PFN(Y).
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/14613/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/kernel/setup.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -589,6 +589,10 @@ static int __init early_parse_mem(char *
>                 start = memparse(p + 1, &p);
>
>         add_memory_region(start, size, BOOT_MEM_RAM);
> +
> +       if (start && start > PHYS_OFFSET)
> +               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> +                               BOOT_MEM_RESERVED);
>         return 0;
>  }
>  early_param("mem", early_parse_mem);
>
>
>
