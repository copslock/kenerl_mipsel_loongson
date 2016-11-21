Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 18:21:19 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37416 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993010AbcKURVMGM507 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 18:21:12 +0100
Received: by mail-wm0-f50.google.com with SMTP id t79so156702863wmt.0
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2016 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9s83VHDBsWb9UOBHhjhplRzMRW2nwiV42foSWIcAg2s=;
        b=qbA5F9ObRCjz8Uog9kaU4KPt1iOOsooyb/fi/935D0kTpp7luXhslyOKD7fotzC5nX
         2+TSKnUCmiDJv1KOAXstPavo5PbaZnGff0cOv6oB4M4ePdcoGbYbK/H9qCs/GIlr01ra
         vORf75l3CnzylOcMOnuNXPWtoKQW1YZm/YT5UZz6SRPcnzW1Mk3ZVGQobTZ/BJODJ6GX
         o0XBjXl9FQncPMBhH40ziDZZTbmYWkeCSpPS2e/17BPmS3tzvrhciytquour3KcqPlaM
         o4UQ/uM2P/0XIcug9KiJXXrcRorcRt/Ff1OVikQWBPSWVyVgIUH/bov9sKydhw4qqRsh
         YTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=9s83VHDBsWb9UOBHhjhplRzMRW2nwiV42foSWIcAg2s=;
        b=Vy9S9GfEzfmYxmDrOJ2+mve1n/Bfv1RMZDbg+sRvrwrCUYomHm7nL2HQoB657SIxFE
         ZOwc3kAJler8I9pmZTtOs2Dsz4Do1ujiyGvr9F6tHZL4MXP5ij+sccDWHfj/bmMA2TbV
         5cXMcH5qJ9y1rcdJGGBj6fti2wm+dkg8OIwKVT8I93Ta903g83a3XUs50m290SliZo/m
         DZnpIGEWSw8+PPVldid6rGY2cy597qKcLcrS7rq2KmjwvNr2M8S2ktqFkAiMfsrnjnL1
         SEexibThB8MtXfMKqwihiSdsOo9mU/EVJHvWSnCXqAPVlXDhWWwOdU5NH1qXKNOHIjD4
         NKyw==
X-Gm-Message-State: AKaTC00LFEigAl+aRYcWY+f+kHMhyQF/jtj0JhdOiPnu4/C4865EFYjXUdQ2YGmsDp/hKw==
X-Received: by 10.46.77.17 with SMTP id a17mr9175690ljb.50.1479748865587;
        Mon, 21 Nov 2016 09:21:05 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.172])
        by smtp.gmail.com with ESMTPSA id e94sm5536108lji.40.2016.11.21.09.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2016 09:21:05 -0800 (PST)
Subject: Re: [PATCH 2/2] of: Add check to of_scan_flat_dt() before accessing
 initial_boot_params
To:     Tobias Wolf <t.wolf@vplace.de>, linux-mips@linux-mips.org
References: <3700342.djbc9u0nWG@loki> <2966402.rBqcQZDeOh@loki>
 <2281020.GC1GkRyGht@loki>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a13d095d-cdc9-8deb-82e2-f19b15748a4a@cogentembedded.com>
Date:   Mon, 21 Nov 2016 20:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2281020.GC1GkRyGht@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55842
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

On 11/21/2016 07:23 PM, Tobias Wolf wrote:

> An empty __dtb_start to __dtb_end section might result in initial_boot_params
> being null for arch/mips/ralink. This showed that the boot process hangs
> indefinitely in of_scan_flat_dt().
>
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> ---
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -628,6 +628,9 @@
>  				     void *data),
>  			   void *data)
>  {
> +	if (!initial_boot_params)
> +		return;
> +
>  	const void *blob = initial_boot_params;
>  	const char *pathp;
>  	int offset, rc = 0, depth = -1;

   CC      drivers/of/fdt.o
drivers/of/fdt.c: In function ‘of_scan_flat_dt’:
drivers/of/fdt.c:738:3: warning: ‘return’ with no value, in function returning 
non-void [-Wreturn-type]
drivers/of/fdt.c:740:2: warning: ISO C90 forbids mixed declarations and code 
[-Wdeclaration-after-statement]

MBR, Sergei
