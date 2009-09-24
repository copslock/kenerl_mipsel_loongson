Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 14:10:01 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:1735 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492256AbZIXMJz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 14:09:55 +0200
Received: by fg-out-1718.google.com with SMTP id d23so503345fga.6
        for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 05:09:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=//V/TyCBJ6ZJcjcjCWwTXRUXX5MdLSebuFMMn/4kaSM=;
        b=oHgS3/f/fre542JdEtF48zHsdxaKybKgeyRYILE7yuR1CrAJUdrEoEqLnhvqSEYM56
         YVcG+v55y00U7NkDYzYRvtatulEQFqxz9/AzfYVKyWfq3dsc566jhPFbGaUdhSre3+ge
         x7yMwEFD3ak04reTsP+hVSnVFtc8zTPIZ+ZzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=Es2KF+b4uUCv0d9hh0/foihR1X1DoXrYQFHjRoc4j2WW2Di6bJlVVer+fDPmBNQCm3
         wbhFsqHqprDEvZ+7pT2aC0XmerxVH+n0mtCq/eTBlDlGP20hcmPQEIjZs88Htmb1z/l6
         mmV91XhqHlqbhgorvtVIBYPFpWV3qIa5gn6Cs=
Received: by 10.86.16.9 with SMTP id 9mr2846953fgp.8.1253794195222;
        Thu, 24 Sep 2009 05:09:55 -0700 (PDT)
Received: from ?0.0.0.0? (p5496B0C7.dip.t-dialin.net [84.150.176.199])
        by mx.google.com with ESMTPS id d6sm1762188fga.6.2009.09.24.05.09.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Sep 2009 05:09:54 -0700 (PDT)
Message-ID: <4ABB6189.5010909@gmail.com>
Date:	Thu, 24 Sep 2009 14:09:45 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.23 (X11/20090828)
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>
CC:	Sam Ravnborg <sam@ravnborg.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git [with patch]
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>	 <20090924091539.GA929@merkur.ravnborg.org>	 <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com> <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com>
In-Reply-To: <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> On Thu, Sep 24, 2009 at 11:24 AM, Manuel Lauss
> <manuel.lauss@googlemail.com> wrote:
>>> I'm away from my machine atm.
>>> Could you try to add the following to arch/mips/kernel/makefile:
>>>
>>> CPPFFLAGS_vmlinux.lds += $(KBUILD_CFLAGS)
>>>
>>> This should fix it.
>> Thank you, that did it.
> 
> Spoke too soon:
> 
> This leaves unprocessed directives in vmlinux.lds:
> 
> [...]
> OUTPUT_ARCH(mips)
> ENTRY(kernel_entry)
> PHDRS {
>  text PT_LOAD FLAGS(7); /* RWX */
>  note PT_NOTE FLAGS(4); /* R__ */
> }
> ifdef 1
>  ifdef 1
>   jiffies = jiffies_64;
>  else
>   jiffies = jiffies_64 + 4;
>  endif
> else
>  jiffies = jiffies_6

... which is of course easily fixed after consumption of
unhealthy amounts of coffee.

Patch below works for me.

Thank you Sam!
	Manuel Lauss

---

From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: fix build of vmlinux.lds

Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 removed a few
CPPFLAGS with vital include paths necessary to build vmlinux.lds
on MIPS, and moved the calculation of the 'jiffies' symbol
directly to vmlinux.lds.S but forgot to change make ifdef/... to
cpp macros.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/kernel/Makefile      |    2 ++
 arch/mips/kernel/vmlinux.lds.S |   12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e961221..8e26e9c 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -91,3 +91,5 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o

 EXTRA_CFLAGS += -Werror
+
+CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 9bf0e3d..162b299 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -11,15 +11,15 @@ PHDRS {
 	note PT_NOTE FLAGS(4);	/* R__ */
 }

-ifdef CONFIG_32BIT
-	ifdef CONFIG_CPU_LITTLE_ENDIAN
+#ifdef CONFIG_32BIT
+	#ifdef CONFIG_CPU_LITTLE_ENDIAN
 		jiffies  = jiffies_64;
-	else
+	#else
 		jiffies  = jiffies_64 + 4;
-	endif
-else
+	#endif
+#else
 	jiffies  = jiffies_64;
-endif
+#endif

 SECTIONS
 {
--
1.6.5.rc1
