Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 16:03:14 +0100 (CET)
Received: from ozlabs.org ([203.11.71.1]:43681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992492AbeJ3PDK0eI7x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Oct 2018 16:03:10 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kvpv4fCmz9s9J;
        Wed, 31 Oct 2018 02:03:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
In-Reply-To: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com> <877ehzk3we.fsf@concordia.ellerman.id.au> <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Date:   Wed, 31 Oct 2018 02:03:02 +1100
Message-ID: <87tvl3iijd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66990
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
> On Tue, Oct 30, 2018 at 9:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> > index 17be664..338e827 100644
>> > --- a/arch/powerpc/Makefile
>> > +++ b/arch/powerpc/Makefile
>> > @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mabi=elfv1)
>> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mabi=elfv2
>> >  endif
>> >
>> > -ifneq ($(cc-name),clang)
>> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
>> >    cflags-$(CONFIG_CPU_LITTLE_ENDIAN) += -mno-strict-align
>> >  endif
>> >
>> > @@ -175,7 +175,7 @@ endif
>> >  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
>> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
>> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
>> > -ifneq ($(cc-name),clang)
>> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
>> >  CC_FLAGS_FTRACE      += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>> >  endif
>> >  endif
>>
>> Does this behave like other CONFIG variables, ie. it will not be defined
>> when it's false?
>
> Right.
>
>> And if so can't we use ifdef/ifndef? eg:
>>
>> ifndef CONFIG_CC_IS_CLANG
>>   CC_FLAGS_FTRACE       += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>>
>> That reads cleaner to me.
>
>
> OK, will do respin if you prefer ifdef/ifndef style.

I do prefer it, but I can also fix it up later if you're in a hurry to
get this merged.

cheers
