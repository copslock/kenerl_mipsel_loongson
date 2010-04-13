Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 07:04:17 +0200 (CEST)
Received: from mail-yx0-f200.google.com ([209.85.210.200]:47813 "EHLO
        mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0DMFEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Apr 2010 07:04:09 +0200
Received: by yxe38 with SMTP id 38so2520735yxe.22
        for <multiple recipients>; Mon, 12 Apr 2010 22:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:x-priority:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=VCIsg488Y94CsX4qRUs4W4d8c5HkkeO/d7gARqWJld0=;
        b=Rxh67ftAozcSC4uTfV98nEAHebGmyLZhjDM//IwEYr/AdV6tOGgyJOD2+8OZaNi7ju
         Lk0sF8voTTeLOEUgqhCk7ipphdbWU/j73EuyidmZosog3jRn6Sxmlwyn9arc1aLI9ACd
         psZAbriIgH6rOm5JHrV60puMG4Ec7d7IjcHI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:x-priority
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=aN+V5A//CUw80reeTqZyEcc4YLAiJ/Og58zSWDgZv97Zm8U+xoUCOYTmkYxVH9Xith
         1p+Hrj611nSiH8l020RBPe3bgb1i7QS2YMHnXaF0tRpT8GfaDAD/Q5SdT1LLNVAlaRw+
         n4SVmf/IcvPsQm4RAKbUScmCXi08gqueSZeT8=
Received: by 10.150.103.12 with SMTP id a12mr4356880ybc.112.1271135041714;
        Mon, 12 Apr 2010 22:04:01 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm4595766iwn.4.2010.04.12.22.03.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 22:04:00 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 13 Apr 2010 13:03:54 +0800
Message-ID: <1271135034.25797.41.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, David and Ralf

This patch have broken the support to the MIPS variants whose
cpu_has_mips_r2 is 0 for the CAC_BASE and CKSEG0 is completely different
in these MIPSs.

With the patch, the kernel will exit when booting(later after
trap_init()).

A potential patch to fix the above problem is:

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1a4dd65..d8cb554 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1599,7 +1599,7 @@ void __init trap_init(void)
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
 	} else {
-		ebase = CKSEG0;
+		ebase = (cpu_has_mips_r2) ? CKSEG0 : CAC_BASE;
 		if (cpu_has_mips_r2)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}

Regards,
	Wu Zhangjin

On Tue, 2010-04-06 at 13:29 -0700, David Daney wrote:
> The ebase is relative to CKSEG0 not CAC_BASE.  On a 32-bit kernel they
> are the same thing, for a 64-bit kernel they are not.
> 
> It happens to kind of work on a 64-bit kernel as they both reference
> the same physical memory.  However since the CPU uses the CKSEG0 base,
> determining if a J instruction will reach always gives the wrong
> result unless we use the same number the CPU uses.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/kernel/traps.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 7ce84bb..b122f76 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1706,7 +1706,7 @@ void __init trap_init(void)
>  		ebase = (unsigned long)
>  			__alloc_bootmem(size, 1 << fls(size), 0);
>  	} else {
> -		ebase = CAC_BASE;
> +		ebase = CKSEG0;
>  		if (cpu_has_mips_r2)
>  			ebase += (read_c0_ebase() & 0x3ffff000);
>  	}
