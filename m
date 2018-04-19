Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 17:01:33 +0200 (CEST)
Received: from out03.mta.xmission.com ([166.70.13.233]:34316 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeDSPBYxoxiB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 17:01:24 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1f9B3j-0007vd-5o; Thu, 19 Apr 2018 09:01:15 -0600
Received: from [97.119.174.25] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1f9B3h-0006yH-EO; Thu, 19 Apr 2018 09:01:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
References: <20180419143737.606138-1-arnd@arndb.de>
        <20180419143737.606138-2-arnd@arndb.de>
Date:   Thu, 19 Apr 2018 09:59:48 -0500
In-Reply-To: <20180419143737.606138-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 19 Apr 2018 16:37:21 +0200")
Message-ID: <87efjbnswr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9B3h-0006yH-EO;;;mid=<87efjbnswr.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pl9tgkmh2hKvB1qcFOJ340F7Yw13/C8g=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

Arnd Bergmann <arnd@arndb.de> writes:

> Most architectures now use the asm-generic copy of the sysvipc data
> structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
> __kernel_time_t on 32-bit architectures but have padding behind them to
> allow extending the type to 64-bit.
>
> Unfortunately, that fails on all big-endian architectures, which have the
> padding on the wrong side. As so many of them get it wrong, we decided to
> not bother even trying to fix it up when we introduced the asm-generic
> copy. Instead we always use the padding word now to provide the upper
> 32 bits of the seconds value, regardless of the endianess.
>
> A libc implementation on a typical big-endian system can deal with
> this by providing its own copy of the structure definition to user
> space, and swapping the two 32-bit words before returning from the
> semctl/shmctl/msgctl system calls.
>
> ARM64 and s/390 are architectures that use these generic headers and
> also provide support for compat mode on 64-bit kernels, so we adapt
> their copies here as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/asm-generic/msgbuf.h | 17 ++++++++---------
>  include/uapi/asm-generic/sembuf.h | 26 ++++++++++++++++----------
>  include/uapi/asm-generic/shmbuf.h | 17 ++++++++---------
>  3 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
> index fb306ebdb36f..d2169cae93b8 100644
> --- a/include/uapi/asm-generic/msgbuf.h
> +++ b/include/uapi/asm-generic/msgbuf.h
> @@ -18,23 +18,22 @@
>   * On big-endian systems, the padding is in the wrong place.
>   *
>   * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
>   * - 2 miscellaneous 32-bit values
>   */
>  
>  struct msqid64_ds {
>  	struct ipc64_perm msg_perm;
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t msg_stime;	/* last msgsnd time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused1;
> -#endif
>  	__kernel_time_t msg_rtime;	/* last msgrcv time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused2;
> -#endif
>  	__kernel_time_t msg_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused3;
> +#else
> +	unsigned long	msg_stime;	/* last msgsnd time */
> +	unsigned long	msg_stime_high;
> +	unsigned long	msg_rtime;	/* last msgrcv time */
> +	unsigned long	msg_rtime_high;
> +	unsigned long	msg_ctime;	/* last change time */
> +	unsigned long	msg_ctime_high;
>  #endif

I suspect you want to use __kernel_ulong_t here instead of a raw
unsigned long.  If nothing else it seems inconsistent to use typedefs
in one half of the structure and no typedefs in the other half.

>  	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
>  	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
> diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
> index cbf9cfe977d6..0bae010f1b64 100644
> --- a/include/uapi/asm-generic/sembuf.h
> +++ b/include/uapi/asm-generic/sembuf.h
> @@ -13,23 +13,29 @@
>   * everyone just ended up making identical copies without specific
>   * optimizations, so we may just as well all use the same one.
>   *
> - * 64 bit architectures typically define a 64 bit __kernel_time_t,
> + * 64 bit architectures use a 64-bit __kernel_time_t here, while
> + * 32 bit architectures have a pair of unsigned long values.
>   * so they do not need the first two padding words.
> - * On big-endian systems, the padding is in the wrong place.
>   *
> - * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
> - * - 2 miscellaneous 32-bit values
> + * On big-endian systems, the padding is in the wrong place for
> + * historic reasons, so user space has to reconstruct a time_t
> + * value using
> + *
> + * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
> + *		((long long)kernel_semid64_ds.sem_otime_high << 32)
> + *
> + * Pad space is left for 2 miscellaneous 32-bit values
>   */
>  struct semid64_ds {
>  	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t	sem_otime;	/* last semop time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused1;
> -#endif
>  	__kernel_time_t	sem_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused2;
> +#else
> +	unsigned long	sem_otime;	/* last semop time */
> +	unsigned long	sem_otime_high;
> +	unsigned long	sem_ctime;	/* last change time */
> +	unsigned long	sem_ctime_high;
>  #endif
>  	unsigned long	sem_nsems;	/* no. of semaphores in array */
>  	unsigned long	__unused3;
> diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
> index 2b6c3bb97f97..602f1b5b462b 100644
> --- a/include/uapi/asm-generic/shmbuf.h
> +++ b/include/uapi/asm-generic/shmbuf.h
> @@ -19,24 +19,23 @@
>   *
>   *
>   * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
>   * - 2 miscellaneous 32-bit values
>   */
>  
>  struct shmid64_ds {
>  	struct ipc64_perm	shm_perm;	/* operation perms */
>  	size_t			shm_segsz;	/* size of segment (bytes) */
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t		shm_atime;	/* last attach time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused1;
> -#endif
>  	__kernel_time_t		shm_dtime;	/* last detach time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused2;
> -#endif
>  	__kernel_time_t		shm_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused3;
> +#else
> +	unsigned long		shm_atime;	/* last attach time */
> +	unsigned long		shm_atime_high;
> +	unsigned long		shm_dtime;	/* last detach time */
> +	unsigned long		shm_dtime_high;
> +	unsigned long		shm_ctime;	/* last change time */
> +	unsigned long		shm_ctime_high;
>  #endif
>  	__kernel_pid_t		shm_cpid;	/* pid of creator */
>  	__kernel_pid_t		shm_lpid;	/* pid of last operator */
