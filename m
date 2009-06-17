Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:33:14 +0200 (CEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:34560 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492005AbZFQTdI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 21:33:08 +0200
Received: by bwz25 with SMTP id 25so676608bwz.0
        for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 12:31:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YPxfVt0zGaic7jg+hTHOLbdLu8NZYFB2KikQ0Y+7ecQ=;
        b=AiwPssY5aygNlTTL3xUQgelvpqytvXV3Q4pa+sDbV+Kis3MCyDu3Ls/edda0jjvgpe
         x9iE0+s4W5cV2lMvc6gGJ1cDrZcRb4jyZ29Stu8aoMcbM/r+86r5DhuyFxxSBA8oD5hS
         7Pcti0zxwdQwW/aIqFItkw7I+dpZfpU/M1w/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=grPrW44eBdZsZ9oyTdYkQsPL5qp4jAdZ4lYomgML16h8IqsWJ8R5dxdpm50bVDKem+
         p0LS3ZBIi5Ge8wRmcS35UJkaBkOeeGF0EFMA2llrBAS7LyNyfi3OSPBhShNU5Zw0rf3t
         tdYTYlg9Pp6WBUUfLtWsJKDwz69+W2frnzmDY=
MIME-Version: 1.0
Received: by 10.103.223.2 with SMTP id a2mr393643mur.88.1245267093733; Wed, 17 
	Jun 2009 12:31:33 -0700 (PDT)
In-Reply-To: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org>
References: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org>
Date:	Wed, 17 Jun 2009 21:31:33 +0200
Message-ID: <f861ec6f0906171231o1e5e4b1ei5525dcf5180127ac@mail.gmail.com>
Subject: Re: [PATCH v2] -git compile fixes for MIPS
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, manuel.lauss@gmail.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Zhang,

On Wed, Jun 17, 2009 at 9:23 PM, Zhang Le<r0bertz@gentoo.org> wrote:

>  CC      arch/mips/kernel/traps.o
> cc1: warnings being treated as errors
> /home/zhangle/linux/arch/mips/kernel/traps.c: In function ‘set_uncached_handler’:
> /home/zhangle/linux/arch/mips/kernel/traps.c:1604: error: format not a string literal and no format arguments

This one is caused by one of the Gentoo patches to GCC
(10-format-string-security patch),
I usually remove this patch when building GCC to avoid these stupid
compile failures ;-)


> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 08ea468..974b161 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -6,6 +6,7 @@
>  #ifdef CONFIG_BUG
>
>  #include <asm/break.h>
> +#include <linux/compiler.h>
>
>  static inline void __noreturn BUG(void)
>  {

Seems to me to be the best course of action.

Thanks!
        Manuel Lauss
