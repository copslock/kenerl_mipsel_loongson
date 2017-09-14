Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 20:59:40 +0200 (CEST)
Received: from mail-vk0-x244.google.com ([IPv6:2607:f8b0:400c:c05::244]:35397
        "EHLO mail-vk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992982AbdINS7dCvT69 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Sep 2017 20:59:33 +0200
Received: by mail-vk0-x244.google.com with SMTP id t10so67121vke.2;
        Thu, 14 Sep 2017 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cWrRBvQ90NBK3feRtWT7rOtG82ytrcRzONeeeeLvbKM=;
        b=S8UVMbvcBlgU9GDa129uCJLKUE3Go13KMgGgB+iWXeQYVh0+lPlK6fBVP+JP2ZkAy6
         b391WvnRRm4eOroq3DfGCebOg64SS58EPyTGVFAwbjjAWg1VgDUhqr+h6TWUwkadgD7s
         t0Vpau+FcfbynheP+4O/RVBh286NQcQ/h8wC4uLOcI4VkMO0alsqLhja/2drwY+lXk4n
         1i/Wc9A9zpVFTlba9YPXFVgMRw9srLAkdHYHbZAL1f9eHJcWn+YzX/w5LTBMNgIC99Ny
         YH+f27SEhwvFmTvwY+j2ViWgv8gehsk6yNENR9FQiDrjwRxJO+yFB0k1rIc5C9aqAk4f
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cWrRBvQ90NBK3feRtWT7rOtG82ytrcRzONeeeeLvbKM=;
        b=eUA2TP7YyTUr3E9OyE0FrseOgp+OGJYzJvuEyjs6+k0k2R582xyi0Qt37mvUwAfy5f
         BcBlDCTQOJSarvg0b9eLr6Ql7tP7ic9ofjied3vQSUsp51NHYT4fnQh5lQRrL3fxCN0c
         r0KMm3ZMl1hX6A/T69+yNvEgAQ5jIi9gi701vnBQ68RqzQSgB1VsDDMU9fqayiZXIj02
         IDIyhdBTh0I8J/kyPkGz1XgF/y18rBJBa2Etp+Wrx6ZzUooiPEWmKCmKylb3V9lyZM3L
         6/8l4LWhRSBe3TGFjxx7noPXs23JmHzkfPnggRbIYUwVfVTc9ldqP8F0WDJnaPCtQZfK
         jy6g==
X-Gm-Message-State: AHPjjUiAPDHrDV4DSSOf4pa/uqzkjCQkncFysPvqfwPpx0aI0U84vZj4
        LWEvx3c+xNzWXNUYNI/jHpE68aZc4uhDK7/U1v8=
X-Google-Smtp-Source: AOwi7QBDQ+GvufrqvSC4b2K9fPXDZD5wv8VtgVz/ODvaeIBpxIkR2hojElfZitWIRSAAMKNpQZ4NymKLnwYzgsWyOHE=
X-Received: by 10.31.129.193 with SMTP id c184mr16074819vkd.52.1505415565483;
 Thu, 14 Sep 2017 11:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.81 with HTTP; Thu, 14 Sep 2017 11:59:05 -0700 (PDT)
In-Reply-To: <20170914155051.8289-11-alexander.levin@verizon.com>
References: <20170914155051.8289-1-alexander.levin@verizon.com> <20170914155051.8289-11-alexander.levin@verizon.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 14 Sep 2017 20:59:05 +0200
X-Google-Sender-Auth: 8IjkiDKBdRNb_vvZvY3_vWXAAMk
Message-ID: <CA+7wUszvyofkuLPb6K+E5ngJ7=e0CiCh1s+WQUBX0cG_MfnU7w@mail.gmail.com>
Subject: Re: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
To:     "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60004
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

On Thu, Sep 14, 2017 at 5:51 PM, Levin, Alexander (Sasha Levin)
<alexander.levin@verizon.com> wrote:
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
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
> ---
>  arch/mips/kernel/setup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index f66e5ce505b2..38697f25d168 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -589,6 +589,10 @@ static int __init early_parse_mem(char *p)
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

Does not work on MIPS Creator CI20. See:

https://www.spinics.net/lists/stable/msg187229.html
