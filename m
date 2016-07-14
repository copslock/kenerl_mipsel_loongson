Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 17:39:02 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33940 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995219AbcGNPizBz1wp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 17:38:55 +0200
Received: by mail-pa0-f65.google.com with SMTP id hh10so4757894pac.1;
        Thu, 14 Jul 2016 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=B6Cr6piA561t3r/sPE0504CtWY6R9vEK5W8np+CPn3s=;
        b=yeumcjA6p9BCMm+Od0BwIb044BdfO9smnuPEukWRLCYX9vV9ghHXqtPyhE5a/pJeHN
         ymam5spJa8fzJM73mMHDdcm3AtZ/T/0//jwm/r9lcjXaNvGnDYEh4deEIq3vvDpOn7I/
         soZToCda3tIp3lpnCko15//b4ihokl78p1Emm4T0PhbsE4FCiy/IQ3cRZW/JQ20hHnsg
         STDO57oIFdDEDcXuw4R2/Jq9Z6p2SYt+0K6zfThHrFG4IW1QHZydNamXYs3M3np5EVUX
         i9CS1LdOcKiqgz+ML385t9GA1JImXXkWvyJZ6/Sv6NTIR1oSajO6GF+aYy0o23gpgsqD
         sx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=B6Cr6piA561t3r/sPE0504CtWY6R9vEK5W8np+CPn3s=;
        b=bn2LM43OjKGxqgtBVqVHnvZSlUPZz7VRjYER04RKUXvU+Ra26hTwa4aIERoMr+6TUT
         uusQmqZ4TLW6f849PZEoYYePeB5SeicZyVDNc+E40fTtuXczOYDtRyywFw6Lzak2ns4B
         lNRkO2Aicl+m6PF7LYa8TrdGBfQTI5wq6wzMDaGxiPlMRzKsMPpeOHtuPxGfDeceivx8
         o9+bH+ZDoQ1Dx1dA73EBq4yhNUTD6xW3EyM546oEt+rhbW3AzG4rysRrursSbMtVonch
         DsAUsxbmdhvUP0pWEtRshbkg+Eh9pnDi5ohmUlsXUDDmwnM+5LEWt2x557iSYKr1LL87
         Qn2w==
X-Gm-Message-State: ALyK8tKvJy58gW4Y+a4/eJ4P74e5Fdf1oDTTonZHwFRkawWrknpmciM5b9TbxuQrmGaGvQ==
X-Received: by 10.66.185.14 with SMTP id ey14mr23949976pac.71.1468510729019;
        Thu, 14 Jul 2016 08:38:49 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id h189sm4876295pfc.52.2016.07.14.08.38.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 08:38:48 -0700 (PDT)
Message-ID: <5787B206.3030902@gmail.com>
Date:   Thu, 14 Jul 2016 08:38:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] MIPS: OCTEON: Off by one in octeon_irq_gpio_map()
References: <20160714101429.GA18175@mwanda>
In-Reply-To: <20160714101429.GA18175@mwanda>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54335
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

On 07/14/2016 03:14 AM, Dan Carpenter wrote:
> It should be >= ARRAY_SIZE() instead of > ARRAY_SIZE().
>
> Fixes: 64b139f97c01 ('MIPS: OCTEON: irq: add CIB and other fixes')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch.  This would probably only matter if a malformed device tree, 
or buggy device driver were encountered.

Acked-by: David Daney <david.daney@cavium.com>


>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 368eb49..75a4add 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1260,7 +1260,7 @@ static int octeon_irq_gpio_map(struct irq_domain *d,
>
>   	line = (hw + gpiod->base_hwirq) >> 6;
>   	bit = (hw + gpiod->base_hwirq) & 63;
> -	if (line > ARRAY_SIZE(octeon_irq_ciu_to_irq) ||
> +	if (line >= ARRAY_SIZE(octeon_irq_ciu_to_irq) ||
>   		octeon_irq_ciu_to_irq[line][bit] != 0)
>   		return -EINVAL;
>
>
