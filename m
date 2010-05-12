Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 19:16:24 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.158]:7229 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492221Ab0ELRQV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 19:16:21 +0200
Received: by fg-out-1718.google.com with SMTP id e12so418708fga.6
        for <multiple recipients>; Wed, 12 May 2010 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=4srsXly1t7bH28eQOzBR+vG+hOAwOwRXh1Ou819sYSE=;
        b=Vn4T8qd0pRRU2Y0+IUGL0bz3yQhY4QXIHhgJgi17RxauWxgQh4adnFZbxIs/WlCMmd
         cTdAdEGsO3A/+4cplS0vnc5XBa7J1lZrOoMMG7nwQQgwM8bl51FmubK4vLb9OnFpdRxl
         FCzJ8U82IHQvadgkOccpJIZ9uk2xNQV0IMtrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tCJgCHAvrIJlXQvOnvtIKcYrhQYJAHQ9znHD4JUw/R6U7HL/z2cldMFv7UN1uVdbIm
         IWgsRQ35YgdSfSk3um1yNSMTCtPih65oNd60Ay+TtQWYWQnkt2EKHwZ9dJRIi+gAsTKT
         vInV729ZYiof+O6SyEA3Z/miDZVFVqyUFqOzA=
Received: by 10.204.3.23 with SMTP id 23mr670808bkl.142.1273684580970;
        Wed, 12 May 2010 10:16:20 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id s17sm115075bkd.22.2010.05.12.10.16.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 10:16:19 -0700 (PDT)
Message-ID: <4BEAE260.9060805@gmail.com>
Date:   Wed, 12 May 2010 10:16:16 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/9] tracing: MIPS: mcount.S: Fixup of the 32bit support
 with gcc 4.5
References: <cover.1273669419.git.wuzhangjin@gmail.com> <fd8a13e37a33c1075da184f4fe92b0d9afc51c09.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <fd8a13e37a33c1075da184f4fe92b0d9afc51c09.1273669419.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/12/2010 06:23 AM, Wu Zhangjin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> As the doc[1] of gcc-4.5 shows, the -mmcount-ra-address uses register
> $12 to transfer the stack offset of the return address to the _mcount
> function. in 64bit kernel, $12 is t0, but in 32bit kernel, it is t4, so,
> we need to use $12 instead of t0 here to cover the 64bit and 32bit
> support.
>
> [1] Gcc doc: MIPS Options
> http://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html
>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>

Would it be better to do?:

#define MCOUNT_RA_ADDRESS_REG $12

s/t0/MCOUNT_RA_ADDRESS_REG/g

David Daney

> ---
>   arch/mips/kernel/mcount.S |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index e256bf9..92d1540 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -69,7 +69,7 @@ _mcount:
>
>   	MCOUNT_SAVE_REGS
>   #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
> +	PTR_S	$12, PT_R12(sp)	/* $12 saved the location of the return address(at) by -mmcount-ra-address */
>   #endif
>
>   	move	a0, ra		/* arg1: next ip, selfaddr */
> @@ -135,7 +135,7 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
>   #ifdef CONFIG_DYNAMIC_FTRACE
>   	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
>   #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
> +	PTR_L	$12, PT_R12(sp)	/* load the original $12 from the stack */
>   #endif
>   #else
>   	MCOUNT_SAVE_REGS
> @@ -143,10 +143,10 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
>   #endif
>
>   #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
> +	bnez	$12, 1f		/* non-leaf func: $12 saved the location of the return address */
>   	 nop
> -	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
> -1:	move	a0, t0		/* arg1: the location of the return address */
> +	PTR_LA	$12, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
> +1:	move	a0, $12		/* arg1: the location of the return address */
>   #else
>   	PTR_LA	a0, PT_R1(sp)	/* arg1:&AT ->  a0 */
>   #endif
