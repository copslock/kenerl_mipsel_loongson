Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 14:38:21 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33024 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007647AbcCaMiSKg2X- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 14:38:18 +0200
Received: by mail-lb0-f170.google.com with SMTP id u8so51651846lbk.0
        for <linux-mips@linux-mips.org>; Thu, 31 Mar 2016 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kSvU9zQo4CqkxGWWmCk+30EJe+YHbnakbX6rVvvTTIk=;
        b=JX/DpDm5HVVPpGmx6UGZzaxbTPxIBtYVCyH1Ed6I5s9pqjxi2FJiRNL4Wp9KY5Dt9h
         BW7d/Bpvn76zaUCwADcs0WucZ1miYe4qcAkFGqu1ei372DE+G/2iWVXoeS39cG5N1GIB
         YatuimAjeUM5s+wvUIV5WJyITAZYxQNl0UDNfUSBTJiAhap3gb+Df0+Q/DhuQ3IGuHmr
         kwP8NX0nCrzNa2G0TqcUgfAp9DMyxk2T9GwhOLxEEimnF5Ii+XnriaN4W7tqwN0Uslh8
         jA5sngnxvMwj91I2ye895rBIMsb50m9cFbLPofS+ktOCUeyxsaDFmQ1k4YanR2c3X/Kb
         dVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kSvU9zQo4CqkxGWWmCk+30EJe+YHbnakbX6rVvvTTIk=;
        b=JJkzyLG1PyzXzwJLQO3Gv8209T6gg301vEgEz2mrFW8gCLLREm2UQxoCzhCrx8pS2G
         8fK00VwJOmzxtr2i+ttxOjq41ddWSLZebEwCV8YfF3+2VQFSNsvr7ppLnvODG5Nhlbcj
         TEkuRBjVchDEI0ZT1tXPMNgkLwMHEaDws3xBzVikmV1Ys1ZT4edIyj4KXYyuJYvvk/bn
         4v/WXHjUpwyCsU72O3yFnatMOMDYywU4XWC1OKGJ8GSInWMTX/w46oy4XiQDXgmVu+jG
         FHsCuluFqk97PmfhwF9l+Aj3ki9eBhUha+gFZjsuRdwUmQTPq6HXjDUqOdsfw6i+8+XG
         4jCQ==
X-Gm-Message-State: AD7BkJIZpUsZTRyFhIORuLuBIpTqQbo4XYafwWevoxUXprV1s5RQiEGdyvcl00M+ltK2pQ==
X-Received: by 10.112.172.233 with SMTP id bf9mr6338166lbc.121.1459427892736;
        Thu, 31 Mar 2016 05:38:12 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.84.165])
        by smtp.gmail.com with ESMTPSA id j205sm1308207lfd.0.2016.03.31.05.38.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 05:38:11 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] MIPS: KASLR: Print relocation Information on
 boot
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
 <1459415142-3412-12-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, kernel-hardening@lists.openwall.com,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56FD1A32.10204@cogentembedded.com>
Date:   Thu, 31 Mar 2016 15:38:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1459415142-3412-12-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52820
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

On 3/31/2016 12:05 PM, Matt Redfearn wrote:

> When debugging a relocated kernel, the addresses of the relocated
> symbols and the offset applied is essential information. If the kernel
> is compiled with debugging information, then print this information
> during bootup using the same function as the panic notifer.

    Notifier.

> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
> Changes in v2: None
>
>   arch/mips/kernel/setup.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index d8376d7b3345..ae71f8d9b555 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -477,9 +477,18 @@ static void __init bootmem_init(void)
>   	 */
>   	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
>   		unsigned long offset;
> +		extern void show_kernel_relocation(const char *level);
>
>   		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
>   		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> +
> +#if (defined CONFIG_DEBUG_KERNEL) && (defined CONFIG_DEBUG_INFO)

    Not #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)?

[...]

MBR, Sergei
