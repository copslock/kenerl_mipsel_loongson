Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 13:36:30 +0100 (CET)
Received: from ozlabs.org ([203.11.71.1]:49121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbeJ3Mg0eTGwN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Oct 2018 13:36:26 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42krYb3vfqz9s89;
        Tue, 30 Oct 2018 23:36:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
In-Reply-To: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Tue, 30 Oct 2018 23:36:17 +1100
Message-ID: <877ehzk3we.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 17be664..338e827 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
>  endif
>  
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
>  endif
>  
> @@ -175,7 +175,7 @@ endif
>  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>  endif
>  endif

Does this behave like other CONFIG variables, ie. it will not be defined
when it's false?

And if so can't we use ifdef/ifndef? eg:

ifndef CONFIG_CC_IS_CLANG
  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)

That reads cleaner to me.

Still this patch is fine as is:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
