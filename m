Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 17:08:32 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.226]:1198 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022806AbXCZQI2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 17:08:28 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1488437nzc
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 09:07:22 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OamvYOuNtpa8hKReiiCeGCfet4FYNa4rjFM4jTxtSmU4L59aYQjW5BS4j/jv94PtREGMkn2+tjzgZCFR5oLhBZFc3cK7ouoKlwOU5wLmtN/VhBKxmUCd7R5yeMAtOsLhokIgSun9HT4HO9fQIUeozgVFMySl2W1UgxHDxwtZ6V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRJ4m1zC30SERimTUsBa0Qsk5dsacZwIqudyq1CByCO+5fPTnexymMo8k2DCMXa42AuyAYmxuyCIecd+rDwg5shLXFgJFSxMQ702JdEtgchfRdk1up9KO6E2gBkQnaXjujX1vHZLzUZHPw5vxMNz+v6T93l1uN/Z/Bx5SssrrM0=
Received: by 10.115.76.1 with SMTP id d1mr2696557wal.1174925241264;
        Mon, 26 Mar 2007 09:07:21 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 26 Mar 2007 09:07:21 -0700 (PDT)
Message-ID: <cda58cb80703260907g6f349298xf85b2e2954a7b6a7@mail.gmail.com>
Date:	Mon, 26 Mar 2007 18:07:21 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
In-Reply-To: <20070327.004511.31449250.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
	 <20070326.234821.30439266.anemo@mba.ocn.ne.jp>
	 <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
	 <20070327.004511.31449250.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/26/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I think dropping gcc 3.x support for 64-bit kernel is not what we
> wanted.  And -msym32 is just an optimization and kernel should be
> buildable without it.  So "remove -msym32 silently" is not so bad, I
> suppose.
>
> "If you used newer compiler, you can get better result" is natural
> thing, isn't it? ;)

ok, I suppose a warning is fine. What about this patch on top of the patchset ?

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 3ec0c12..b886945 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -627,7 +627,12 @@ ifdef CONFIG_64BIT
   endif

   ifeq ($(KBUILD_SYM32), y)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+    ifeq ($(call cc-option-yn,-msym32), y)
+      cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+    else
+      $(warning '-msym32' option is not supported by your compiler. \
+               You should use a new one to get best result)
+    endif
   endif
 endif
-- 
               Franck
