Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 16:32:22 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:57663 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022838AbXCZPcV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 16:32:21 +0100
Received: by ug-out-1314.google.com with SMTP id 40so1807129uga
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 08:31:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=noZZYmb60KRkyST5hnGs5lutJuNXA082c+H6LCBoF2g0VXWEh/miXdg8xp4YQkj1Oc+vzKFXhH43wPJsAAW+ETLPmeQlUIz6MiDhg0RU9Zs7xO/3OFTU2aRjC/1mOjoxM2aZnfYQgtLD8XrsZyWRqz8875VHIf3u5J8x/piMt9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXlx7aX2xYyzB77Y0CUyIqxrwb4dTF9YvRxRW1B/XJb+I2H5J/jR+Mv1UWvkqx0O6d9VBaqQrBGWJylBlG7AcAzF/Z2zHO6jCvkAH2K3w2aGFmK/SuA5uq6DXnule9xWqbWG1fWQgapcZy+or5XNh1l+h3NdDG0Uqr+TWoPnsTM=
Received: by 10.114.181.1 with SMTP id d1mr2661563waf.1174923078554;
        Mon, 26 Mar 2007 08:31:18 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 26 Mar 2007 08:31:18 -0700 (PDT)
Message-ID: <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
Date:	Mon, 26 Mar 2007 17:31:18 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
In-Reply-To: <20070326.234821.30439266.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4606AA74.3070907@gentoo.org>
	 <20070325221919.GA12088@linux-mips.org>
	 <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
	 <20070326.234821.30439266.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 3/26/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> One thing I noticed recently: Your patchset dropped gcc test for
> availability of -msym32, so may not work with gcc 3.x.
>

I suspect you're asking why I did not do this:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 3ec0c12..b0d8240 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -627,7 +627,7 @@ ifdef CONFIG_64BIT
   endif

   ifeq ($(KBUILD_SYM32), y)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+    cflags-y += $(call cc-option,-msym32) -DKBUILD_64BIT_SYM32
   endif
 endif

I remove the call to cc-option because this function removes
_silently_ '-msym32' option if it's not supported by the compiler. IOW
it's really not what we want.

IIRC I haven't found an other function like 'cc-option-strict' which
makes a compilation error in case.

So I assumed that the compiler will complain if it doesn't understand
this option. But it may be incorrect. If so I can add an error message
in Kbuild or add a new Kbuild helper. But I'd like to understand
what's wrong with it before.

Thanks
-- 
               Franck
