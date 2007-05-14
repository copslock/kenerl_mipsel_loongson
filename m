Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 11:42:50 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:46845 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023020AbXENKmq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 11:42:46 +0100
Received: by py-out-1112.google.com with SMTP id u52so1413747pyb
        for <linux-mips@linux-mips.org>; Mon, 14 May 2007 03:42:45 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHIwxqj5KCzcwBEc3ZLnWEj4FhbnmXiwObCnCEkM7NrSpmTinVBeNKZMyt4zaqLz700BN4mnJr6qWWCLQcj17DWNnZAeHjt4BamlBgVAdvXqiR1lfgtauIbv/jDZRhPEsvSotjQwAdcOn8XB1iK4PibwsR2tUKUgbGim5pZhP24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCfsmMc7lfGkw0tTXuCkw9ANB/+Jb4bKOYfDNdmavbBqKy7EUKBwqhWLh3vtnf+AHXCs/gup0y/6Y02wyFr1VlQRxx8daExGuIBuw2WTUvFrgI+hjjK8zsQwwXkLDyng4VhuCAeUcgYQmd+jIDjpTUBLH+rpOZBM4b70BroBN98=
Received: by 10.64.184.16 with SMTP id h16mr10082825qbf.1179139364968;
        Mon, 14 May 2007 03:42:44 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Mon, 14 May 2007 03:42:44 -0700 (PDT)
Message-ID: <cda58cb80705140342s1d5d795fk554cd3025509e225@mail.gmail.com>
Date:	Mon, 14 May 2007 12:42:44 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <cda58cb80705140332i79e8396braa008ddf878fb177@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80705140023w2829d86y662e6fa957b3734c@mail.gmail.com>
	 <20070514.164650.126759873.nemoto@toshiba-tops.co.jp>
	 <cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
	 <20070514.170716.18313509.nemoto@toshiba-tops.co.jp>
	 <cda58cb80705140332i79e8396braa008ddf878fb177@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/14/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 5aa0f41..04a57f9 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -713,7 +713,7 @@ ifdef CONFIG_MIPS32_O32
>         $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
>  endif
>
> -archprepare: arch-missing-syscalls
> +prepare0: arch-missing-syscalls
>
>  archclean:
>         @$(MAKE) $(clean)=arch/mips/boot
>

of course with "prepare"1 prerequisite has been removed too:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5aa0f41..151a44c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -703,7 +703,7 @@ CLEAN_FILES += vmlinux.ecoff \
               vmlinux.srec

 PHONY += arch-missing-syscalls
-arch-missing-syscalls: prepare1
+arch-missing-syscalls:
 ifdef CONFIG_MIPS32_N32
        @echo '  Checking missing-syscalls for N32'
        $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
@@ -713,7 +713,7 @@ ifdef CONFIG_MIPS32_O32
        $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
 endif

-archprepare: arch-missing-syscalls
+prepare0: arch-missing-syscalls

 archclean:
        @$(MAKE) $(clean)=arch/mips/boot

-- 
               Franck
