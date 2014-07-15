Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 18:09:38 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:53193 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860024AbaGOQJgieTNc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 18:09:36 +0200
Received: by mail-la0-f45.google.com with SMTP id ty20so4445780lab.32
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qEa2IVuX1Zf93tjBHKXUAGmiLpjrwSJsXrY8oSvj3p8=;
        b=b8xfRHLlnZycAQFo0T5xksU1y17oF+hDTTzKeMh0KJD2Dzpk+fnYDgIOq+YgnmLGWB
         iSqXggjrPn+w2T5IoF+asfg2A91FBZC2PDdQPk8O40X9X05mOSL7XkZsqezQWKahLxWq
         VeU6cOcE9giL+CYDAweopiNhjUUvefJbeg+OuZLgPeWGGn3FodbQ0MPI1ZwIa8HrbGSi
         /haR/zn5VMlZK3UsImi8RpwGqfoH6FJ9uK4eUPxg+/UfyTd/xOARvsdZPK9Ar+fRdlAz
         Bt7WOhKwQeScyKDajRIjm/xtTYp4YnBdVOXHkPkuwnRoTo+rpfv1pacn5HK1QU1KCXMj
         xgQQ==
X-Gm-Message-State: ALoCoQkvH8Fqn590HhH9GxujnWOXVTR8cs5lcShOxP8GafxvyZ5m6vZs31dgK65vqm+c4xZqYa6r
X-Received: by 10.112.124.204 with SMTP id mk12mr2457925lbb.101.1405440571009;
        Tue, 15 Jul 2014 09:09:31 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp31-238.pppoe.mtu-net.ru. [81.195.31.238])
        by mx.google.com with ESMTPSA id xv6sm7105146lab.21.2014.07.15.09.09.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 09:09:30 -0700 (PDT)
Message-ID: <53C5523E.7060503@cogentembedded.com>
Date:   Tue, 15 Jul 2014 20:09:34 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 1/3] MIPS: Add new option for unique RI/XI exceptions
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com> <1405429797-18281-2-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405429797-18281-2-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41196
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

On 07/15/2014 05:09 PM, Markos Chandras wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> MIPSr5 added support for unique exception codes for the Read-Inhibit
> and Execute-Inhibit exceptions.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
[...]

> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 8219c0a5f77e..be13f2879c84 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -364,6 +364,7 @@ enum cpu_type_enum {
>   #define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
>   #define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
>   #define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
> +#define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */

    I think this conflicts with the MAAR patchset.

WBR, Sergei
