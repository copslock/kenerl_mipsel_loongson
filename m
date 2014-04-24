Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2014 21:19:24 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:8418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6837251AbaDXTTUJ69yF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Apr 2014 21:19:20 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OJJAJL016390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Apr 2014 15:19:10 -0400
Received: from sifl.localnet (vpn-50-223.rdu2.redhat.com [10.10.50.223])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3OJJ8TL021729
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 24 Apr 2014 15:19:08 -0400
From:   Paul Moore <pmoore@redhat.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Andy Lutomirski <luto@amacapital.net>,
        Eric Paris <eparis@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.15] MIPS: Add new AUDIT_ARCH token for the N32 ABI on MIPS64
Date:   Thu, 24 Apr 2014 15:19:07 -0400
Message-ID: <2110472.rttbk0K4Ne@sifl>
Organization: Red Hat
User-Agent: KMail/4.13 (Linux/3.13.9-gentoo; KDE/4.13.0; x86_64; ; )
In-Reply-To: <1398177636-10442-1-git-send-email-markos.chandras@imgtec.com>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com> <1398177636-10442-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <pmoore@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmoore@redhat.com
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

On Tuesday, April 22, 2014 03:40:36 PM Markos Chandras wrote:
> A MIPS64 kernel may support ELF files for all 3 MIPS ABIs
> (O32, N32, N64). Furthermore, the AUDIT_ARCH_MIPS{,EL}64 token
> does not provide enough information about the ABI for the 64-bit
> process. As a result of which, userland needs to use complex
> seccomp filters to decide whether a syscall belongs to the o32 or n32
> or n64 ABI. Therefore, a new arch token for MIPS64/n32 is added so it
> can be used by seccomp to explicitely set syscall filters for this ABI.
> 
> Link: http://sourceforge.net/p/libseccomp/mailman/message/32239040/
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Paul Moore <pmoore@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Ralf, can we please have this in 3.15 (Assuming it's ACK'd)?
> 
> Thanks a lot!
> ---
>  arch/mips/include/asm/syscall.h |  2 ++
>  include/uapi/linux/audit.h      | 12 ++++++++++++
>  2 files changed, 14 insertions(+)

I'm far from qualified to ACK any MIPS specific patches, but I do want to add 
my support for this patch.  As Markos states above, without this patch any 
seccomp BPF code will be more complex than necessary (see x32 for an idea) and 
projects that try to abstract away the arch/ABI specific nature of the BPF 
seccomp filters will be have to do a lot more work.  Please merge this patch, 
or something similar, along with the MIPS BPF seccomp filters in 3.15; waiting 
until 3.16 will be too late.

I also don't want to speak for the audit folks (Eric?), but I think you'll 
hear that this patch makes life much easier for them as well.

Thanks,
-Paul

> diff --git a/arch/mips/include/asm/syscall.h
> b/arch/mips/include/asm/syscall.h index c6e9cd2..17960fe 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -133,6 +133,8 @@ static inline int syscall_get_arch(void)
>  #ifdef CONFIG_64BIT
>  	if (!test_thread_flag(TIF_32BIT_REGS))
>  		arch |= __AUDIT_ARCH_64BIT;
> +	if (test_thread_flag(TIF_32BIT_ADDR))
> +		arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
>  #endif
>  #if defined(__LITTLE_ENDIAN)
>  	arch |=  __AUDIT_ARCH_LE;
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 11917f7..1b1efdd 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -331,9 +331,17 @@ enum {
>  #define AUDIT_FAIL_PRINTK	1
>  #define AUDIT_FAIL_PANIC	2
> 
> +/*
> + * These bits disambiguate different calling conventions that share an
> + * ELF machine type, bitness, and endianness
> + */
> +#define __AUDIT_ARCH_CONVENTION_MASK 0x30000000
> +#define __AUDIT_ARCH_CONVENTION_MIPS64_N32 0x20000000
> +
>  /* distinguish syscall tables */
>  #define __AUDIT_ARCH_64BIT 0x80000000
>  #define __AUDIT_ARCH_LE	   0x40000000
> +
>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARMEB	(EM_ARM)
> @@ -346,7 +354,11 @@ enum {
>  #define AUDIT_ARCH_MIPS		(EM_MIPS)
>  #define AUDIT_ARCH_MIPSEL	(EM_MIPS|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_MIPS64	(EM_MIPS|__AUDIT_ARCH_64BIT)
> +#define AUDIT_ARCH_MIPS64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|\
> +				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
>  #define AUDIT_ARCH_MIPSEL64	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|
__AUDIT_ARCH_LE\
> +				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
>  #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
>  #define AUDIT_ARCH_PARISC	(EM_PARISC)
>  #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)

-- 
paul moore
security and virtualization @ redhat
