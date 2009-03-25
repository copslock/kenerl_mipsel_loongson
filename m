Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 17:29:19 +0000 (GMT)
Received: from mtagate1.de.ibm.com ([195.212.17.161]:15085 "EHLO
	mtagate1.de.ibm.com") by ftp.linux-mips.org with ESMTP
	id S28575351AbZCYR3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 17:29:13 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id n2PHT7iv016794;
	Wed, 25 Mar 2009 17:29:07 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n2PHT7bV4198524;
	Wed, 25 Mar 2009 18:29:07 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n2PHT6eK008638;
	Wed, 25 Mar 2009 18:29:07 +0100
Received: from osiris.boeblingen.de.ibm.com (dyn-9-152-212-33.boeblingen.de.ibm.com [9.152.212.33])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n2PHT6Pa008635;
	Wed, 25 Mar 2009 18:29:06 +0100
Date:	Wed, 25 Mar 2009 18:29:05 +0100
From:	Heiko Carstens <heiko.carstens@de.ibm.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: o32: Get rid of useless wrapper for llseek
Message-ID: <20090325182905.5fbca9df@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20090325001555.GA1357@linux-mips.org>
References: <20090325001555.GA1357@linux-mips.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.7; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Wed, 25 Mar 2009 01:15:55 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  arch/mips/kernel/linux32.c     |    7 -------
>  arch/mips/kernel/scall64-o32.S |    2 +-
>  2 files changed, 1 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> index 49aac6e..ab2da41 100644
> --- a/arch/mips/kernel/linux32.c
> +++ b/arch/mips/kernel/linux32.c
> @@ -133,13 +133,6 @@ SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
>  	return sys_ftruncate(fd, merge_64(a2, a3));
>  }
> 
> -SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
> -	unsigned long, offset_low, loff_t __user *, result,
> -	unsigned long, origin)
> -{
> -	return sys_llseek(fd, offset_high, offset_low, result, origin);
> -}
> -

Ah.. this hunk seems to be the origin of the bug. git commit
dbda6ac0897603f6c6dfadbbc37f9882177ec7ac "MIPS: CVE-2009-0029: Enable
syscall wrappers." contains this:

-asmlinkage int sys32_llseek(unsigned int fd, unsigned int offset_high,
-			    unsigned int offset_low, loff_t __user * result,
-			    unsigned int origin)
+SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
+	unsigned long, offset_low, loff_t __user *, result,
+	unsigned long, origin)

Here you converted offset_low from unsigned int to unsigned long. Hence
you lost the clearing of the upper 32 bits. That would explain the bug.
Any chance the process where the bug was seen was a compat process?

Patch below would probably fix it.

Btw. there are a lot of int->long conversions in the git commit
mentioned above. AFAICS all(?) of the conversions are wrong.

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 1a86f84..5abcc7f 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -134,9 +134,9 @@ SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	return sys_ftruncate(fd, merge_64(a2, a3));
 }
 
-SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
-	unsigned long, offset_low, loff_t __user *, result,
-	unsigned long, origin)
+SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
+		unsigned int, offset_low, loff_t __user *, result,
+		unsigned int, origin)
 {
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
