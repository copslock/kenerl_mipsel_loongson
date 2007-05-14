Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 08:23:11 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:14709 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022524AbXENHXJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 08:23:09 +0100
Received: by py-out-1112.google.com with SMTP id u52so1375083pyb
        for <linux-mips@linux-mips.org>; Mon, 14 May 2007 00:23:08 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VCxzNDBGbI0dnB3tIUf5/FkYgdI6U3X40YgVahQzIFo9FnHKjk76eJfaStaO2c8tngYbyopIvSEmma8uBaBjfkN/SGJiwhKj8/yOGAIhFefoEv5k1LixsPZpjoxVTteZkl+B+84AUANCW+5EHk8+PPD5ESmWOOou3xiu8Rwdi10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HuHy6PQ03eHVHj1sjBYVPBe76Tc1cuKMb/E+R0W8nk7Uc8VJzlgq3E2iBnc1PtXAC5nszFywZ57JUdj0Elx32PN5xIweBA1aaTU/2F1hDWAEDkS+z27fSp9qMsqSM+pOI8Wa8T3FW/avBPST3S2hjmwUtCgRYop90EmAMWrG+Lc=
Received: by 10.64.241.14 with SMTP id o14mr9768662qbh.1179127388425;
        Mon, 14 May 2007 00:23:08 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Mon, 14 May 2007 00:23:08 -0700 (PDT)
Message-ID: <cda58cb80705140023w2829d86y662e6fa957b3734c@mail.gmail.com>
Date:	Mon, 14 May 2007 09:23:08 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
	 <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
	 <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
	 <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi,

On 5/12/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index f450066..5aa0f41 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -702,6 +702,19 @@ vmlinux.srec: $(vmlinux-32)
>  CLEAN_FILES += vmlinux.ecoff \
>                vmlinux.srec
>
> +PHONY += arch-missing-syscalls
> +arch-missing-syscalls: prepare1

Why did you add 'prepare1' dependency ?

Thanks
-- 
               Franck
