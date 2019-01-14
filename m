Return-Path: <SRS0=henU=PW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79105C43387
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 03:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A39020659
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 03:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfANDke (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:40:34 -0500
Received: from ozlabs.org ([203.11.71.1]:42065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfANDke (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 13 Jan 2019 22:40:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dK433MFKz9s9G;
        Mon, 14 Jan 2019 14:40:17 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, jcmvbkbc@gmail.com, firoz.khan@linaro.org,
        ebiederm@xmission.com, deepa.kernel@gmail.com,
        linux@dominikbrodowski.net, akpm@linux-foundation.org,
        dave@stgolabs.net, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
In-Reply-To: <20190110162435.309262-15-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de>
Date:   Mon, 14 Jan 2019 14:40:14 +1100
Message-ID: <87r2df29gh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:
> The IPC system call handling is highly inconsistent across architectures,
> some use sys_ipc, some use separate calls, and some use both.  We also
> have some architectures that require passing IPC_64 in the flags, and
> others that set it implicitly.
>
> For the additon of a y2083 safe semtimedop() system call, I chose to only
> support the separate entry points, but that requires first supporting
> the regular ones with their own syscall numbers.
>
> The IPC_64 is now implied by the new semctl/shmctl/msgctl system
> calls even on the architectures that require passing it with the ipc()
> multiplexer.
>
> I'm not adding the new semtimedop() or semop() on 32-bit architectures,
> those will get implemented using the new semtimedop_time64() version
> that gets added along with the other time64 calls.
> Three 64-bit architectures (powerpc, s390 and sparc) get semtimedop().
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> One aspect here that might be a bit controversial is the use of
> the same system call numbers across all architectures, synchronizing
> all of them with the x86-32 numbers. With the new syscall.tbl
> files, I hope we can just keep doing that in the future, and no
> longer require the architecture maintainers to assign a number.
>
> This is mainly useful for implementers of the C libraries: if
> we can add future system calls everywhere at the same time, using
> a particular version of the kernel headers also guarantees that
> the system call number macro is visible.
> ---
>  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
>  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
>  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++

I have some changes I'd like to make to our syscall table that will
clash with this.

I'll try and send them today.

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index db3bbb8744af..1bffab54ff35 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -425,3 +425,15 @@
>  386	nospu	pkey_mprotect			sys_pkey_mprotect
>  387	nospu	rseq				sys_rseq
>  388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
> +# room for arch specific syscalls
> +392	64	semtimedop			sys_semtimedop
> +393	common	semget				sys_semget
> +394	common	semctl				sys_semctl			compat_sys_semctl
> +395	common	shmget				sys_shmget
> +396	common	shmctl				sys_shmctl			compat_sys_shmctl
> +397	common	shmat				sys_shmat			compat_sys_shmat
> +398	common	shmdt				sys_shmdt
> +399	common	msgget				sys_msgget
> +400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
> +401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
> +402	common	msgctl				sys_msgctl			compat_sys_msgctl

We already have a gap at 366-377 from when we tried to add the split IPC
calls a few years back.

I guess I don't mind leaving that gap and using the common numbers.

But would be good to add a comment pointing out that we have room there
for arch specific syscalls as well.

cheers
