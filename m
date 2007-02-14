Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 08:35:59 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.231]:24360 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037435AbXBNIfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Feb 2007 08:35:55 +0000
Received: by qb-out-0506.google.com with SMTP id e12so10156qba
        for <linux-mips@linux-mips.org>; Wed, 14 Feb 2007 00:34:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0rXuPp41phMBkm37emp7+DJf7yLVbJ9M5VSXpZbtq/Ql2ZCzJkFC/BGmzX0hNLlQgS0JneXYVQA0K6d2XV9+KaahwMbfr/rsLY3CC9ETjVuURAW1b2vNTJypVsctKlh29N5+pinOlTAabLb50nQA+kHTc+ztQxoQQJLN8e0wf8=
Received: by 10.114.132.5 with SMTP id f5mr6472wad.1171442093579;
        Wed, 14 Feb 2007 00:34:53 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Wed, 14 Feb 2007 00:34:53 -0800 (PST)
Message-ID: <cda58cb80702140034g5f3243c9j333f97ae6fc6986@mail.gmail.com>
Date:	Wed, 14 Feb 2007 09:34:53 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from a context.
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
In-Reply-To: <20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
	 <20070209.015405.08319291.anemo@mba.ocn.ne.jp>
	 <20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
	 <20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 2/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Revised again.  Fix check_and_restore_fp_context32 and rediff against
> current git.
>
>
> Subject: Check FCSR for pending interrupts, alternative version
>

[snip]

> diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
> index fdbdbdc..297dfcb 100644
> --- a/arch/mips/kernel/signal-common.h
> +++ b/arch/mips/kernel/signal-common.h
> @@ -31,4 +31,7 @@ extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
>   */
>  extern int install_sigtramp(unsigned int __user *tramp, unsigned int syscall);
>
> +/* Check and clear pending FPU exceptions in saved CSR */
> +extern int fpcsr_pending(unsigned int __user *fpcsr);
> +

Just my 2 cents: This looks like the wrong place for this fpu
prototype. I mean shouldn't it belong to a fpu header file or
something else ?
-- 
               Franck
