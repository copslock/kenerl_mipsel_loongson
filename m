Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 23:52:35 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:35260
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993955AbdH1VwWpXK7I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 23:52:22 +0200
Received: by mail-io0-x243.google.com with SMTP id c18so1579620ioj.2
        for <linux-mips@linux-mips.org>; Mon, 28 Aug 2017 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pU3QM1wFOSWktliB00fJ0WzBmux66Sm+5rZHJt8+UZ4=;
        b=T/k1aAGhmmp6EqzL4v1yDfTDn0UQTg1p+SUTpc3IarB9MsPC2kUcUi6SDB2DC3gOg3
         ToFpEv16rf4s+BOfHR36Nn+QmXPU/LPYpi167Qj5dwynThNOGRKe3oF3qWDIcJKmbw86
         YChL/uhZ72WFL0etq1vt9ja8anv3Ysld3AHDt8CKxAK9ikTHIVL4iiInTY/6Ey7Bhc/1
         oXvDBSC1yzF5jVjHWQMEvTxFfj+I1RUAB7Mb8ZIpumDWQo+qrcbCpTCZt3s0L92D1Wrm
         IqyoQ31wBiUJEy5DjvCTpgxtJGtXAtIh+M+b2s/hH+qnxx65pXfi9RSzhKPA3B3EW19f
         RhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pU3QM1wFOSWktliB00fJ0WzBmux66Sm+5rZHJt8+UZ4=;
        b=Y35X0cqEnwvaCTJ2rYyKLNTJgtLwZzDXPgIkgpOWUjXZZv7qjTF+RQW4ROSgOv0EKc
         plXmcc/CTd0fOlAMK2gkpQZ89u8yZyNjC1/DqB/zRqXD/5KqqviYqZRWaA+9ysrkq2y5
         7eUjhT5xXfyLQp1TEZJQgV+bKEGT2qNsdDrlre6oRV4CQ07nJeT3Hbe/xVjJZaUWUdk5
         PS0jmM/0qPSUpIf/py/4p1N2EBXk5JMltL0zXBPsIoIHnjZJeMOHHN7LYMFhvtNSXlGI
         506RaqOurSMFjXnyHXr5SmYQ9AROhF+30D0xtF1JmP+RIHuqsJQgEcNcMhC0yx2qFYu7
         g0UA==
X-Gm-Message-State: AHYfb5hgnvQTatszGwefP5C+SjE8g3FCbLGlSabzaD4NGlHhVtE0cVIb
        8tLXSWfG3fFqWGOq
X-Received: by 10.36.249.65 with SMTP id l62mr2069276ith.88.1503957136810;
        Mon, 28 Aug 2017 14:52:16 -0700 (PDT)
Received: from ddl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id y200sm616431itc.34.2017.08.28.14.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 14:52:16 -0700 (PDT)
Subject: Re: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>
Cc:     linux-mips@linux-mips.org
References: <20170827195613.904715064@cogentembedded.com>
From:   David Daney <ddaney.cavm@gmail.com>
Message-ID: <d414cf99-2e53-eef8-9372-3900b0543a46@gmail.com>
Date:   Mon, 28 Aug 2017 14:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170827195613.904715064@cogentembedded.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/27/2017 12:55 PM, Sergei Shtylyov wrote:
> The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
> using  of_{find|get}_property() calls in its  probe() method.  Using the
> modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).
> 
> Signed-off-by: Sergei Shtylyov<sergei.shtylyov@cogentembedded.com>

It still works with this applied, so:

Acked-by: David Daney <david.daney@cavium.com>

> 
> ---
>   drivers/ata/pata_octeon_cf.c |   10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Index: libata/drivers/ata/pata_octeon_cf.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_octeon_cf.c
> +++ libata/drivers/ata/pata_octeon_cf.c
> @@ -840,7 +840,6 @@ static int octeon_cf_probe(struct platfo
>   	struct property *reg_prop;
>   	int n_addr, n_size, reg_len;
>   	struct device_node *node;
> -	const void *prop;
>   	void __iomem *cs0;
>   	void __iomem *cs1 = NULL;
>   	struct ata_host *host;
> @@ -850,7 +849,7 @@ static int octeon_cf_probe(struct platfo
>   	void __iomem *base;
>   	struct octeon_cf_port *cf_port;
>   	int rv = -ENOMEM;
> -
> +	u32 bus_width;
>   
>   	node = pdev->dev.of_node;
>   	if (node == NULL)
> @@ -860,11 +859,10 @@ static int octeon_cf_probe(struct platfo
>   	if (!cf_port)
>   		return -ENOMEM;
>   
> -	cf_port->is_true_ide = (of_find_property(node, "cavium,true-ide", NULL) != NULL);
> +	cf_port->is_true_ide = of_property_read_bool(node, "cavium,true-ide");
>   
> -	prop = of_get_property(node, "cavium,bus-width", NULL);
> -	if (prop)
> -		is_16bit = (be32_to_cpup(prop) == 16);
> +	if (of_property_read_u32(node, "cavium,bus-width", &bus_width) == 0)
> +		is_16bit = (bus_width == 16);
>   	else
>   		is_16bit = false;
>   
> 
> 
> 
