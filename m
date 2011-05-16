Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 17:27:07 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:38592 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491034Ab1EPP1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 17:27:00 +0200
X-Authority-Analysis: v=1.1 cv=NmbQexcdgr4rtO3OwYGrP5Q3rTMpacrTPhuaXkv4uP8= c=1 sm=0 a=zw1CKeOhDhoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=5n0JVoeqiomSfMFUpfsA:9 a=PUjeQqilurYA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:41043] helo=[192.168.23.10])
        by hrndva-oedge01.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id E3/CD-08391-83241DD4; Mon, 16 May 2011 15:26:53 +0000
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
 call filtering
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Drewry <wad@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        kees.cook@canonical.com, agl@chromium.org, jmorris@namei.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Marek <mmarek@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        Roland McGrath <roland@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
         <1305169376-2363-1-git-send-email-wad@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 16 May 2011 11:26:47 -0400
Message-ID: <1305559607.5456.11.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

Sorry to be absent from this thread so far, I just got back from my
travels and I'm now catching up on email.


On Wed, 2011-05-11 at 22:02 -0500, Will Drewry wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 377a7a5..22e1668 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1664,6 +1664,16 @@ config SECCOMP
>  	  and the task is only allowed to execute a few safe syscalls
>  	  defined by each seccomp mode.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config CC_STACKPROTECTOR
>  	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index eccdefe..7641ee9 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -129,6 +129,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  menu "Advanced setup"
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8e256cc..fe4cbda 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2245,6 +2245,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config USE_OF
>  	bool "Flattened Device Tree support"
>  	select OF
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8f4d50b..83499e4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -605,6 +605,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2508a6f..2777515 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -614,6 +614,16 @@ config SECCOMP
>  
>  	  If unsure, say Y.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  menu "Power Management"
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 4b89da2..00c1521 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -676,6 +676,16 @@ config SECCOMP
>  
>  	  If unsure, say N.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config SMP
>  	bool "Symmetric multi-processing support"
>  	depends on SYS_SUPPORTS_SMP
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index e560d10..5b42255 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -270,6 +270,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"
>  	depends on SPARC64 && SMP
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cc6c53a..d6d44d9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1485,6 +1485,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config CC_STACKPROTECTOR
>  	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
>  	---help---

You just cut-and-pasted 8 copies of a config selection. The proper way
to do that is to add the Kconfig selection in a core kernel Kconfig,
have it depend on "HAVE_SECCOMP_FILTER" and then in each of these
configs, simply add in the arch Kconfig:

config <ARCH>
	[...]
	select HAVE_SECCOMP_FILTER


That way you don't need to duplicate the config option all over the
place.

-- Steve
