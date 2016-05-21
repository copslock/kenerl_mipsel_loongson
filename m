Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 22:27:50 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34792 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032824AbcEUU1s1ROur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 22:27:48 +0200
Received: by mail-lb0-f169.google.com with SMTP id sh2so3116779lbb.1
        for <linux-mips@linux-mips.org>; Sat, 21 May 2016 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=owolBqA0cY/ku+XdxaPaWKa6lLI8E7dcxocHwSbGyZU=;
        b=PlWLym05WAOooUNxW0X+uiao486c3Pj6YeiDkiAtzLOY3qbSIaq5ihPs58sEnxosWK
         QwIYrdnIbHU/KL1ewAdFqT4P67Wnwm0GtjfflQruGTYVmq9UyJbubhY/9SNwB79Fk82X
         RfX9mxMbezHdxJJR4ewFsPGQyeHuadwt/pg2uVkIWFOuSz3qgpMM+VmHip5XbrbptEzy
         +a4CgelxxXNj0OLyWJAQF4YeXoPwgi21FeFCcu6NDxgjQD2hpmSLA6Gyi2jKwDRgCrvO
         nmH73t01NuKlI+NNbDc0zM+r09AJ0Y/NsftUhYYs7rNfFVPHqhbjlVmg10z2CIiRqpLO
         smgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=owolBqA0cY/ku+XdxaPaWKa6lLI8E7dcxocHwSbGyZU=;
        b=RRtvKS225dwVDX4AYegtkQlSHSBTKzxqgq/Qaa5F3KqoHIuxK/69eQfqiyr8iHtUXW
         LxAQPxm2nL/MQiq/OtMvmoGEN6TPMZMmYGyJlBzww7E50ffP+AA8elFCncg73PDFt3C4
         zY4B5LQIUVM2SFXi7RnsJmQ+zuvLvze+KgfXTLrHBnYOY1MKPd/lOxGLpuBiEBSPG0f8
         R3URs5AauXCTMY+uU+sVa3RBUx0th/tuH6Jz8mLhfHzVXcIDcEvsvctgrxnXc8rTqoCP
         MWO0dhWclWlk6xM3cHbH602nzyX0Vk5i92cPi0Gl6QflGd0xsswaH8q4lrwyzHbBK5MJ
         NidA==
X-Gm-Message-State: AOPr4FWRjkV/Brmr7V2YP5cvpZ3aPijYt3LlcQiDCe2EKYbwU5c0Ge+4YC91OVuUdcF3xw==
X-Received: by 10.112.61.231 with SMTP id t7mr3160203lbr.67.1463862462883;
        Sat, 21 May 2016 13:27:42 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.73])
        by smtp.gmail.com with ESMTPSA id pb3sm4269455lbb.37.2016.05.21.13.27.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2016 13:27:41 -0700 (PDT)
Subject: Re: [PATCH 0193/1529] Fix typo
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
References: <20160521120120.9981-1-andrea.gelmini@gelma.net>
Cc:     trivial@kernel.org, ralf@linux-mips.org, macro@imgtec.com,
        paul.burton@imgtec.com, Leonid.Yegoshin@imgtec.com,
        linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d5911496-4d32-f1a1-92ff-a63b87dff7c0@cogentembedded.com>
Date:   Sat, 21 May 2016 23:27:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160521120120.9981-1-andrea.gelmini@gelma.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53602
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

On 5/21/2016 3:01 PM, Andrea Gelmini wrote:

> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/kernel/mips-r2-to-r6-emul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
> index 625ee77..edfa845 100644
> --- a/arch/mips/kernel/mips-r2-to-r6-emul.c
> +++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
> @@ -2202,7 +2202,7 @@ fpu_emul:
>  	}
>
>  	/*
> -	 * Lets not return to userland just yet. It's constly and
> +	 * Lets not return to userland just yet. It's costly  and

    Let's?

MBR, Sergei
