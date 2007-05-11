Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:16:03 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:36392 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022614AbXEKMP7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 13:15:59 +0100
Received: by py-out-1112.google.com with SMTP id u52so765830pyb
        for <linux-mips@linux-mips.org>; Fri, 11 May 2007 05:14:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kVMpbj/VyDQIJ8cv3R0x2+U+snz4/froWb+9iyJ3MeLmCc094k97WuR12wNPZyPGhO2ZW/ZftH3IHS3UB/yAmjm05nIhQ96BuIOs2y8Ey4/wi7q3nDHaN5ovDwbGKed4qD5MCdUa15885C+HGen8mlg8S+hoNmXjU/3f51HL580=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pgwXf9sry0yqTF6iIfY75YPoPQCqNsqJy7OWJwpvyzzemXHa9bixvVb9MEmctWe9nvcCNmvowMRw82xaUMemyRJhNrTSmyqemtY1oo+h7zF99B7qefSrAA3WBktsvBqLpcPgEBQnyA5pc0EU/+UWV2pZJZFF1bqTL0ZnexOPIl4=
Received: by 10.65.248.19 with SMTP id a19mr5103878qbs.1178885687094;
        Fri, 11 May 2007 05:14:47 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Fri, 11 May 2007 05:14:47 -0700 (PDT)
Message-ID: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
Date:	Fri, 11 May 2007 14:14:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 5/10/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On 64-bit MIPS, only N64 ABI is checked by default.  This patch adds
> some rules for other ABIs.  This results in these warnings at the
> moment:
>

nice to see this second version which is nicer IMHO.

>   CALL-N32 /home/git/linux-mips/scripts/checksyscalls.sh
> <stdin>:148:2: warning: #warning syscall time not implemented
> <stdin>:424:2: warning: #warning syscall select not implemented
> <stdin>:440:2: warning: #warning syscall uselib not implemented
> <stdin>:856:2: warning: #warning syscall vfork not implemented
> <stdin>:868:2: warning: #warning syscall truncate64 not implemented
> <stdin>:872:2: warning: #warning syscall ftruncate64 not implemented
> <stdin>:876:2: warning: #warning syscall stat64 not implemented
> <stdin>:880:2: warning: #warning syscall lstat64 not implemented
> <stdin>:884:2: warning: #warning syscall fstat64 not implemented
> <stdin>:980:2: warning: #warning syscall getdents64 not implemented
> <stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> <stdin>:1284:2: warning: #warning syscall fstatat64 not implemented
> <stdin>:1364:2: warning: #warning syscall utimensat not implemented
>   CALL-O32 /home/git/linux-mips/scripts/checksyscalls.sh
> <stdin>:424:2: warning: #warning syscall select not implemented
> <stdin>:856:2: warning: #warning syscall vfork not implemented
> <stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> <stdin>:1364:2: warning: #warning syscall utimensat not implemented
>   CALL    /home/git/linux-mips/scripts/checksyscalls.sh
> <stdin>:148:2: warning: #warning syscall time not implemented
> <stdin>:424:2: warning: #warning syscall select not implemented
> <stdin>:440:2: warning: #warning syscall uselib not implemented
> <stdin>:856:2: warning: #warning syscall vfork not implemented
> <stdin>:980:2: warning: #warning syscall getdents64 not implemented
> <stdin>:1364:2: warning: #warning syscall utimensat not implemented
>

woah, quite a lot of works are waiting for you ;)

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index a68d462..f450066 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -709,3 +709,25 @@ archclean:
>  CLEAN_FILES += vmlinux.32 \
>                vmlinux.64 \
>                vmlinux.ecoff
> +
> +quiet_cmd_syscalls_n32 = CALL-N32 $<
> +      cmd_syscalls_n32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=n32
> +
> +quiet_cmd_syscalls_o32 = CALL-O32 $<
> +      cmd_syscalls_o32 = $(CONFIG_SHELL) $< $(CC) $(c_flags) -mabi=32
> +
> +PHONY += missing-syscalls-n32 missing-syscalls-o32
> +
> +missing-syscalls-n32: scripts/checksyscalls.sh FORCE
> +       $(call cmd,syscalls_n32)
> +
> +missing-syscalls-o32: scripts/checksyscalls.sh FORCE
> +       $(call cmd,syscalls_o32)
> +
> +archprepare:

I didn't know about that rule. However I'm not sure it's a good idea
to add a set of commands
to it since it's multiple rule...

> +ifdef CONFIG_MIPS32_N32
> +       $(Q)$(MAKE) $(build)=arch/mips missing-syscalls-n32

or can't we do instead:

$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"

and get rid of "missing-syscalls-n32" rule. Thus this avoids to
duplicate "missing-syscalls" command.

> +endif
> +ifdef CONFIG_MIPS32_O32
> +       $(Q)$(MAKE) $(build)=arch/mips missing-syscalls-o32

ditto:

$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"

> +endif
>
>

I'm wondering if this should stay at the end where cleaning rules live...

Anyways thanks.
-- 
               Franck
