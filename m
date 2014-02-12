Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2014 01:59:01 +0100 (CET)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47202 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825747AbaBLA6ziWneq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Feb 2014 01:58:55 +0100
Received: by mail-wi0-f172.google.com with SMTP id e4so5783124wiv.5
        for <linux-mips@linux-mips.org>; Tue, 11 Feb 2014 16:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JozhrxeHbcqRexe/Enjc3a5VSkgejz8mlOYiLGeUyOg=;
        b=h8oKK31+yu2YFF2NNns8CNycdSAd53e4iTe5cjw1PFT/XhQM7aEVXN/FdfpgoMv66n
         8pUazrLgTtm7hpiYInVBtlOCzrQrWCOKFZb8ZZnk3bwUjvOMYpxkqtZPzsTemxxZRIRB
         9HoR+N/WarnCKoFF3PqOYmffPohdOJ5Ch/qsWFtYIiO95QzHuyvXFDXH8tn/nm3QvWfS
         129ax7KHueZTSSMeUQO5YUq3VIAKyIN8gn5noU8MW0QDG7wy5iGTn4hshwLO/7t9K/i0
         o6H8xOfyPSBwxE7aUIFgGx7tZa3bTLWTz2yM/JLFPxl1cSRSxbmebr435hLkIq6+nOMh
         XQHQ==
X-Received: by 10.180.9.71 with SMTP id x7mr411344wia.55.1392166729775; Tue,
 11 Feb 2014 16:58:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.80.2 with HTTP; Tue, 11 Feb 2014 16:58:19 -0800 (PST)
In-Reply-To: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Tue, 11 Feb 2014 19:58:19 -0500
X-Google-Sender-Auth: eQaYGJPjqRcm12ExhoWLL33K3_o
Message-ID: <CAP=VYLoNjfC8ZBgfLtCSv=s638p3faY-wm2cj2rn482KekyA7A@mail.gmail.com>
Subject: Re: [PATCH 0/8] Improved seccomp-bpf support for MIPS
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On Wed, Jan 22, 2014 at 9:39 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Hi,
>
> This patch improves the existing seccomp-bpf support for MIPS.
> It fixes a bug when copying system call arguments for the filter
> checks and it also moves away from strict filtering to actually
> use the filter supplied by the userspace process.

Hi all,

It seems this causes a build fail on linux-next allmodconfig.  I left
a mindless "git bisect run .." go against it and it came up with:
----------------------------
make[2]: *** [samples/seccomp/bpf-direct.o] Error 1
make[1]: *** [samples/seccomp] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [vmlinux] Error 2
5c5df77172430c6377ec3434ce62f2b14a6799fc is the first bad commit
commit 5c5df77172430c6377ec3434ce62f2b14a6799fc
Author: Markos Chandras <markos.chandras@imgtec.com>
Date:   Wed Jan 22 14:40:04 2014 +0000

    MIPS: Select HAVE_ARCH_SECCOMP_FILTER

    Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
    Reviewed-by: James Hogan <james.hogan@imgtec.com>
    Reviewed-by: Paul Burton <paul.burton@imgtec.com>
    Cc: linux-mips@linux-mips.org
    Patchwork: https://patchwork.linux-mips.org/patch/6401/
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---------------------

The original linux-next fail is at:

http://kisskb.ellerman.id.au/kisskb/buildresult/10601740/

Paul.
--

>
> This patchset has been tested with libseccomp
> (MIPS support not upstream yet) on mips, mipsel and mips64
> and with Chromium test suite (MIPS support not upstream yet)
> on mipsel.
>
> This patchset is based on the upstream-sfr/mips-for-linux-next tree.
>
> Markos Chandras (8):
>   MIPS: asm: syscall: Fix copying system call arguments
>   MIPS: asm: syscall: Add the syscall_rollback function
>   MIPS: asm: syscall: Define syscall_get_arch
>   MIPS: asm: thread_info: Add _TIF_SECCOMP flag
>   MIPS: ptrace: Move away from secure_computing_strict
>   MIPS: kernel: scalls: Skip the syscall if denied by the seccomp filter
>   MIPS: seccomp: Handle indirect system calls (o32)
>   MIPS: Select HAVE_ARCH_SECCOMP_FILTER
>
>  arch/mips/Kconfig                   |  1 +
>  arch/mips/include/asm/ptrace.h      |  2 +-
>  arch/mips/include/asm/syscall.h     | 35 ++++++++++++++++++++++++++++++-----
>  arch/mips/include/asm/thread_info.h |  3 ++-
>  arch/mips/kernel/ptrace.c           | 11 ++++++-----
>  arch/mips/kernel/scall32-o32.S      | 15 +++++++++++++--
>  arch/mips/kernel/scall64-64.S       |  5 ++++-
>  arch/mips/kernel/scall64-n32.S      |  5 ++++-
>  arch/mips/kernel/scall64-o32.S      | 17 +++++++++++++++--
>  9 files changed, 76 insertions(+), 18 deletions(-)
>
> --
> 1.8.5.3
>
>
>--
