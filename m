Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 18:27:42 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:40363 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817090Ab3JaR1jnmMCB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Oct 2013 18:27:39 +0100
Received: by mail-ob0-f169.google.com with SMTP id uz6so3419655obc.28
        for <multiple recipients>; Thu, 31 Oct 2013 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gAoTiWt87ihjhxTaZW4D84ksKZ+uZH41VzSWB2o0NrY=;
        b=Ma2URXp5A8uSu5veYXRgSbs/Rnm2ZvYL62lcthsVlppC/Nozhgqc00D51Fj7q1wCDM
         tlQjFdE/7ztH7dEHUBkAA/IlH9hlxoePojnJ2xWYZt7rHrsUYGnlmtXrbLkzwzEN6ypw
         1PRVmsoBw6LR5yY7FcxZHBCQ7L3WOs90hJfKSMHeBDus+KINSD4KhC59230XZMw2LFpl
         Qr61oa/bmUpO2wUadcHQgL4OHOGPmKRKASxncyUVn4f+sphl5O2SzzDUNcGfomi9jGrA
         ZSsHHX2TWK4pLiBUWKse+2Ptph0hzo/ztcONLkiG1L/Eh1bwXesgC535/dTHlmpWGmSF
         fg2Q==
X-Received: by 10.60.155.166 with SMTP id vx6mr3604347oeb.28.1383240452992;
        Thu, 31 Oct 2013 10:27:32 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id rr6sm8629048oeb.0.2013.10.31.10.27.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 10:27:32 -0700 (PDT)
Message-ID: <52729302.6090505@gmail.com>
Date:   Thu, 31 Oct 2013 10:27:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nsn.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] MIPS: cavium-octeon: fix early boot hang on EBH5600 board
References: <1383142087-25995-1-git-send-email-aaro.koskinen@nsn.com>
In-Reply-To: <1383142087-25995-1-git-send-email-aaro.koskinen@nsn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38429
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

I am looking at this, but it could be a few days before I can render an 
opinion about it.


On 10/30/2013 07:08 AM, Aaro Koskinen wrote:
> The boot hangs early on EBH5600 board when octeon_fdt_pip_iface() is
> trying enumerate a non-existant interface. We can avoid this situation
> by first checking that the interface exists in the DTB.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
> ---
>   arch/mips/cavium-octeon/octeon-platform.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 1830874..f68c75a 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -336,14 +336,14 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
>   	int p;
>   	int count = 0;
>
> -	if (cvmx_helper_interface_enumerate(idx) == 0)
> -		count = cvmx_helper_ports_on_interface(idx);
> -
>   	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
>   	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
>   	if (iface < 0)
>   		return;
>
> +	if (cvmx_helper_interface_enumerate(idx) == 0)
> +		count = cvmx_helper_ports_on_interface(idx);
> +
>   	for (p = 0; p < 16; p++)
>   		octeon_fdt_pip_port(iface, idx, p, count - 1, pmac);
>   }
>
