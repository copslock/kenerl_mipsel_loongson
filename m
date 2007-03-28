Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 12:02:36 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:13430 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021986AbXC1LCd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 12:02:33 +0100
Received: by ug-out-1314.google.com with SMTP id 40so182137uga
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 04:01:32 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RUkX/MrdznrA2PSTvMVKxSPVpAN1k3CrAzQV41PKdm/TUfpS+I+ka52KZUI3NYpbBsTjvaG7kEAJWg6G4f/lkWZ1RuhCmMoFTLvjRps56r0MUibQUi6qJ8MKhVKwNnKjEW1Ph//7zn9NZ7KE9ajUCpTyl/EV/cFxAeiIjSZMIbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S0HvZlzlyBJPdd8Nsi6GlGkUSTHNER28qde1vC8ur4ul1uTHfs6rJN2wFL1bnvF4/+1ljJhr9aS8kAvFbu9hR+cUBUQUedQKm4KjXkQzLamvCT37+dnnJlZVaP1NGHKpMqbK0GGjP4deh/kVZ9c4L6dMX5MmlrJGQgKWAbP4guM=
Received: by 10.114.26.1 with SMTP id 1mr3636205waz.1175079690995;
        Wed, 28 Mar 2007 04:01:30 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Wed, 28 Mar 2007 04:01:30 -0700 (PDT)
Message-ID: <cda58cb80703280401h7ef54d23i19766f453f085c5e@mail.gmail.com>
Date:	Wed, 28 Mar 2007 13:01:30 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: missimg system calls
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070328.011100.07456480.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070328.011100.07456480.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 3/27/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 4924626..d6abdc5 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -4,6 +4,17 @@
>
>  extra-y                := head.o init_task.o vmlinux.lds
>
> +ifdef CONFIG_MIPS32_N32
> +missing_syscalls_n32.o: missing_syscalls_n32.c
> +CFLAGS_missing_syscalls_n32.o = -mabi=n32
> +always += missing_syscalls_n32.o
> +endif
> +ifdef CONFIG_MIPS32_O32
> +missing_syscalls_o32.o: missing_syscalls_o32.c
> +CFLAGS_missing_syscalls_o32.o = -mabi=32
> +always += missing_syscalls_o32.o
> +endif
> +
>  obj-y          += cpu-probe.o branch.o entry.o genex.o irq.o process.o \
>                    ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
>                    time.o topology.o traps.o unaligned.o

Isn't this simpler ?

-- >8 --
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..2408432 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -67,4 +67,10 @@ obj-$(CONFIG_I8253)		+= i8253.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o

+obj-$(CONFIG_MIPS32_N32)	+= missing_syscalls_n32.o
+obj-$(CONFIG_MIPS32_O32)	+= missing_syscalls_o32.o
+
+CFLAGS_missing_syscalls_n32.o = -mabi=n32
+CFLAGS_missing_syscalls_o32.o = -mabi=32
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o
/dev/null -xc /dev/null >/dev/null 2>&1; then echo
"-DHAVE_AS_SET_DADDI"; fi)

-- 
               Franck
