Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 10:25:15 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:43461
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbeBTJZEBlAFs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 10:25:04 +0100
Received: by mail-lf0-x244.google.com with SMTP id q69so3163510lfi.10;
        Tue, 20 Feb 2018 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o8RmHOqOKDAekrJGo+uhJlGlrQheQQR4FMK4oLLlvWM=;
        b=f8739GKlNCBjkPJeZRTy0gpIYXKf5Z9iG5Q9taEHXl7OWfA14Vax6gWhCYdN0Z/TXi
         a/DsFKJ1NWUmFUXQoLiMBvaMKba3Esb7eZsArwWvK24NU9kKYWzV2ZDPJH35tTLUumOS
         ErtE6hpxwnV2pdaFkzvCjNk723iGcgvH3dNlG/5uqqzjiqzEXhieMZShWkFTg73dDakP
         5LE8tyW5YyMKf8+0WnhVFkeQ/6ynTecIlcp0xi++V7r+b456EBqXiUX2QeIvDWq8DXCk
         +HaatFunI9ra08fxyb+y0NfqEKGhSlrX6B+mBa7h+8T5t7UgsC40zdgOiCAqd7T+weru
         PWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o8RmHOqOKDAekrJGo+uhJlGlrQheQQR4FMK4oLLlvWM=;
        b=PoZ315r4xQAKdWXdNQVlSWlQacMYRZlAKZ4AoNRxYpY7olO82UwKeDklOddBU9ne7c
         UpT+9BRGdHwIh5G/eri80bT4hUcGzLqf+xd0Y22g+wEzL8TvUsjAHJz6zrTxBLNtU67e
         8JLvCJcNhNIKM7kut8WSF7A+oZ0dmCo+JtD/LTTLv5lACyVZ9Q0WURgms8oXf6Xtch0V
         0fRcimvGnoMWI+Sdpo3UCFIlirscRf53n68ecLCA+/4R61laq0ITPCiYZ1pXRii8j1n6
         K8BndpQHTKs85SaY78acTLDp+hXrWVnhXY/xFoHwaVwnY/NHUGbNW8FmQ/QTAMkPZxQG
         OELg==
X-Gm-Message-State: APf1xPAANe+4lz+L3GYqVrVYi1kq+bfDyKZ5j+8PAOijAFBLdp9wKpQS
        hFQ9+pOgNYM5TajofKVjppI=
X-Google-Smtp-Source: AH8x226295dJMqOT6qorgdA+j58BXR5en7ca1dbXX6lvlxzONGjfc7aLd27WaA+7ToU2FrY9akeE7A==
X-Received: by 10.25.162.72 with SMTP id l69mr12242812lfe.38.1519118698000;
        Tue, 20 Feb 2018 01:24:58 -0800 (PST)
Received: from localhost.localdomain (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id e20sm1109477lji.83.2018.02.20.01.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 01:24:57 -0800 (PST)
Date:   Tue, 20 Feb 2018 12:24:50 +0300
From:   Peter Mamonov <pmamonov@gmail.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: fcntl64 syscall causes user program stack corruption
Message-ID: <20180220092449.m763qhaia3w6cskq@localhost.localdomain>
References: <20180219180655.wiotjqubelp7ywxs@localhost.localdomain>
 <20180219203120.GA6245@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219203120.GA6245@saruman>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <pmamonov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmamonov@gmail.com
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

On Mon, Feb 19, 2018 at 08:31:21PM +0000, James Hogan wrote:
> On Mon, Feb 19, 2018 at 09:06:56PM +0300, Peter Mamonov wrote:
> > Hello,
> > 
> > After upgrading the Linux kernel to the recent version I've found that the 
> > Firefox browser from the Debian 8 (jessie),mipsel stopped working: it causes 
> > Bus Error exception at startup. The problem is reproducible with the QEMU 
> > virtual machine (qemu-system-mips64el). Thorough investigation revealed that 
> > the following syscall in /lib/mipsel-linux-gnu/libpthread-2.19.so causes 
> > Firefox's stack corruption at address 0x7fff5770:
> > 
> > 	0x77fabd28:  li      v0,4220
> > 	0x77fabd2c:  syscall
> > 
> > Relevant registers contents are as follows:
> > 
> > 		  zero       at       v0       v1       a0       a1       a2       a3
> > 	 R0   00000000 300004e0 0000107c 77c2e6b0 00000006 0000000e 7fff574c 7fff5770 
> > 
> > The stack corruption is caused by the following patch:
> > 
> > 	commit 8c6657cb50cb037ff58b3f6a547c6569568f3527
> > 	Author: Al Viro <viro@zeniv.linux.org.uk>
> > 	Date:   Mon Jun 26 23:51:31 2017 -0400
> > 	
> > 	    Switch flock copyin/copyout primitives to copy_{from,to}_user()
> > 	    
> > 	    ... and lose HAVE_ARCH_...; if copy_{to,from}_user() on an
> > 	    architecture sucks badly enough to make it a problem, we have
> > 	    a worse problem.
> > 	    
> > 	    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Reverting the change in put_compat_flock() introduced by the patch prevents the 
> > stack corruption:
> > 
> > 	diff --git a/fs/fcntl.c b/fs/fcntl.c
> > 	index 0345a46b8856..c55afd836e5d 100644
> > 	--- a/fs/fcntl.c
> > 	+++ b/fs/fcntl.c
> > 	@@ -550,25 +550,27 @@ static int get_compat_flock64(struct flock *kfl, const struct compat_flock64 __u
> > 	 
> > 	 static int put_compat_flock(const struct flock *kfl, struct compat_flock __user *ufl)
> > 	 {
> > 	-       struct compat_flock fl;
> > 	-
> > 	-       memset(&fl, 0, sizeof(struct compat_flock));
> > 	-       copy_flock_fields(&fl, kfl);
> > 	-       if (copy_to_user(ufl, &fl, sizeof(struct compat_flock)))
> > 	+       if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
> > 	+           __put_user(kfl->l_type, &ufl->l_type) ||
> > 	+           __put_user(kfl->l_whence, &ufl->l_whence) ||
> > 	+           __put_user(kfl->l_start, &ufl->l_start) ||
> > 	+           __put_user(kfl->l_len, &ufl->l_len) ||
> > 	+           __put_user(kfl->l_pid, &ufl->l_pid))
> > 	                return -EFAULT;
> > 	        return 0;
> > 	 }
> > 
> > Actually, the change introduced by the patch is ok. However, it looks like 
> > there is either a mismatch of sizeof(struct compat_flock) between the kernel 
> > and the user space or a mismatch of types used by the kernel and the user 
> > space.  Despite the fact that the user space is built for a different kernel 
> > version (3.16), I believe this syscall should work fine with it, since `struct 
> > compat_flock` did not change since the 3.16.  So, probably, the problem is 
> > caused by some discrepancies which were hidden until "Switch flock 
> > copyin/copyout..." patch.
> > 
> > Please, give your comments.
> 
> Hmm, thanks for reporting this.
> 
> The change this commit makes is to make it write the full compat_flock
> struct out, including the padding at the end, instead of only the
> specific fields, suggesting that MIPS' struct compat_flock on 64-bit
> doesn't match struct flock on 32-bit.
> 
> Here's struct flock from arch/mips/include/uapi/asm/fcntl.h with offset
> annotations for 32-bit:
> 
> struct flock {
> /*0*/	short	l_type;
> /*2*/	short	l_whence;
> /*4*/	__kernel_off_t	l_start;
> /*8*/	__kernel_off_t	l_len;
> /*12*/	long	l_sysid;
> /*16*/	__kernel_pid_t l_pid;
> /*20*/	long	pad[4];
> /*36*/
> };
> 
> and here's struct compat_flock from arch/mips/include/asm/compat.h with
> offset annotations for 64-bit:
> 
> struct compat_flock {
> /*0*/	short		l_type;
> /*2*/	short		l_whence;
> /*4*/	compat_off_t	l_start;
> /*8*/	compat_off_t	l_len;
> /*12*/	s32		l_sysid;
> /*16*/	compat_pid_t	l_pid;
> /*20*/	short		__unused;
> /*24*/	s32		pad[4];
> /*40*/
> };
> 
> Clearly the existence of __unused is outright wrong here.
> 
> Please can you test the following patch to see if it fixes the issue.

Yes, the patch fixes the issue.

And thanks for clarification.

Regards,
Peter

> 
> Thanks again,
> James
> 
> From ebcbbb431aa7cc97330793da8a30c51150963935 Mon Sep 17 00:00:00 2001
> From: James Hogan <jhogan@kernel.org>
> Date: Mon, 19 Feb 2018 20:14:34 +0000
> Subject: [PATCH] MIPS: Drop spurious __unused in struct compat_flock
> 
> MIPS' struct compat_flock doesn't match the 32-bit struct flock, as it
> has an extra short __unused before pad[4], which combined with alignment
> increases the size to 40 bytes compared with struct flock's 36 bytes.
> 
> Since commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
> copy_{from,to}_user()"), put_compat_flock() writes the full compat_flock
> struct to userland, which results in corruption of the userland word
> after the struct flock when running 32-bit userlands on 64-bit kernels.
> 
> This was observed to cause a bus error exception when starting Firefox
> on Debian 8 (Jessie).
> 
> Reported-by: Peter Mamonov <pmamonov@gmail.com>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.13+
> ---
>  arch/mips/include/asm/compat.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
> index 946681db8dc3..9a0fa66b81ac 100644
> --- a/arch/mips/include/asm/compat.h
> +++ b/arch/mips/include/asm/compat.h
> @@ -86,7 +86,6 @@ struct compat_flock {
>  	compat_off_t	l_len;
>  	s32		l_sysid;
>  	compat_pid_t	l_pid;
> -	short		__unused;
>  	s32		pad[4];
>  };
>  
> -- 
> 2.13.6
> 
