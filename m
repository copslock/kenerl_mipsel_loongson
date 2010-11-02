Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2010 17:12:27 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:46933 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491831Ab0KBQMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Nov 2010 17:12:24 +0100
Received: by ewy19 with SMTP id 19so3438797ewy.36
        for <multiple recipients>; Tue, 02 Nov 2010 09:12:23 -0700 (PDT)
Received: by 10.213.9.207 with SMTP id m15mr8336971ebm.85.1288714341673;
        Tue, 02 Nov 2010 09:12:21 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id x54sm5559016eeh.11.2010.11.02.09.12.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 09:12:20 -0700 (PDT)
Message-ID: <4CD03817.4050907@mvista.com>
Date:   Tue, 02 Nov 2010 19:11:03 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Camm Maguire <camm@maguirefamily.org>
Subject: Re: [PATCH 2/2] MIPS: Don't clobber personality bits in 32-bit sys_personality().
References: <1288658588-26801-1-git-send-email-ddaney@caviumnetworks.com> <1288658588-26801-2-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1288658588-26801-2-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> If PER_LINUX32 has been set on a 32-bit kernel, only twiddle with the
> low-order personality bits, let the upper bits pass through.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Camm Maguire <camm@maguirefamily.org>
> ---
>  arch/mips/kernel/linux32.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

> diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> index 6343b4a..a63f4e2 100644
> --- a/arch/mips/kernel/linux32.c
> +++ b/arch/mips/kernel/linux32.c
> @@ -252,13 +252,13 @@ SYSCALL_DEFINE5(n32_msgrcv, int, msqid, u32, msgp, size_t, msgsz,
>  SYSCALL_DEFINE1(32_personality, unsigned long, personality)
>  {
>  	int ret;
> -	personality &= 0xffffffff;
> +	unsigned int p = personality & 0xffffffff;

    I'd have inserted an empty line here...

>  	if (personality(current->personality) == PER_LINUX32 &&
> -	    personality == PER_LINUX)
> -		personality = PER_LINUX32;
> -	ret = sys_personality(personality);
> -	if (ret == PER_LINUX32)
> -		ret = PER_LINUX;
> +	    personality(p) == PER_LINUX)
> +		p = (p & ~PER_MASK) | PER_LINUX32;
> +	ret = sys_personality(p);
> +	if (ret != -1 && personality(ret) == PER_LINUX32)
> +		ret = (ret & ~PER_MASK) | PER_LINUX;
>  	return ret;
>  }

WBR, Sergei
