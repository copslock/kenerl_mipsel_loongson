Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 18:50:45 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57578 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903714Ab2D3Qui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2012 18:50:38 +0200
Received: by pbbrq13 with SMTP id rq13so4123551pbb.36
        for <multiple recipients>; Mon, 30 Apr 2012 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VfMcW08VmuzFtR9vJ+ddjJFez2pXG0KT030Bab87pXo=;
        b=W7ZAId5h8GA0/ZX/gK/eroWqfgXKLHXIri4dDK+gVwQrRXDhikPfYZKdXJ8igYyHwD
         KWP/LZUN28O4CkwrlLabhuW/tp1ZMmWtrxMgdaaF35kWWg3tQLNHSNmlSVJg5xLP+HSo
         G4m7hVpS8QwN3i5k4kGXZk4aj4rjPGftOJneYCraBzFAfmELnf6VJQDe/92aQeA80Eck
         GiV+8f5wAJ3qEj38rGpv7Ngw8UpgyzV097LTICNsOaNWMmEREDNDiZpkWZRIFYtC73Wz
         HP5G+N0CH636YIOJV0AuAWQCRpsWRosKyXoV35MRJ6y/7qpPCzLAWVddJe+OwOm/oKEs
         zl1w==
Received: by 10.68.132.69 with SMTP id os5mr39060094pbb.60.1335804631862;
        Mon, 30 Apr 2012 09:50:31 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id u5sm16492819pbu.76.2012.04.30.09.50.29
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 09:50:29 -0700 (PDT)
Message-ID: <4F9EC2D4.90009@gmail.com>
Date:   Mon, 30 Apr 2012 09:50:28 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 04/14] MIPS: Add helper function to allow platforms to
 point at a DTB.
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335785589-32532-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/30/2012 04:32 AM, John Crispin wrote:
> Add __dt_setup_arch() that can be called to load a builtin DT.
> Additionally we add a macro to allow loading a specific symbol
> from the __dtb_* section.
>
> Signed-off-by: Ralf Baechle<ralf@linux-mips.org>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/include/asm/prom.h |   11 +++++++++++
>   arch/mips/kernel/prom.c      |   14 ++++++++++++++
>   2 files changed, 25 insertions(+), 0 deletions(-)
>
[...]
> +
> +void __init __dt_setup_arch(struct boot_param_header *bph)
> +{
> +	unsigned long size;
> +
> +	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
> +		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
> +
> +		return;
> +	}
> +
> +	initial_boot_params = bph;
> +	size = be32_to_cpu(bph->totalsize);

size is unused, you can remove it.

> +}
