Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 19:07:14 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:39003
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994644AbeBSSHFV-zwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2018 19:07:05 +0100
Received: by mail-lf0-x244.google.com with SMTP id h78so655923lfg.6
        for <linux-mips@linux-mips.org>; Mon, 19 Feb 2018 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wIBAv9n5UaXeVXuohqJpGYh3DTqQTCsnXkUQpWTG93g=;
        b=SDBRXYEQ1Z/1mr6KZI9UtMUYjZHTxMsQtsV5cdS8uSdumjFDQQGBIVjCngwhS9imxX
         Jnm7nueBVQLs/tK1jWTX2rxwmQAe0u2zZsxDP53VJ2iU1fmb4nmAhkXhUJ2ndwAqdoHf
         uQoC7D1tQlTFhsiBopwQ6MQbRw8lAvH6gbXtA39lIjdW8SNrV3PRYZ9PCnJ3Rm4I/KUx
         oF/xb4sG2Jk8RBXCEhSdvgVLE2ubp+qzGhDBF8EtMDeLLEVHG/NsvpNXprzWogCAJtHy
         tRQjhh9iX0ymKr0rXT4H5IWUZUPPD8Op0Pid2DkNiTQyeMERbuGEWplik3zQzWxyJ3nn
         OEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wIBAv9n5UaXeVXuohqJpGYh3DTqQTCsnXkUQpWTG93g=;
        b=S7mY2Jgz0yq/iS9kaET4nzIHn6ZLSKciq0XdE4ibzSYgqLY18gSuwd/XOratGu58iM
         jLUtDg45sRFurlhsnrPO0yY7xlqVWjszB0XRHPeC2dzRFo1NF7BG0kYYVLYWWEZ16vkX
         bhQc6escwctOnKyTTZNN41UNFmMgKCWsMunnRy/B2ypAsNchbF4kswNJ9YqzA2INLAlh
         zMWWvuJJ5lUHPot7OL+nI8rc5LAIK4riTZxcMvQa7dtxxEydoET2bbB+96iNedJ/tS4j
         83WlsRfwc/EV0VcLLxrxG8rK9N4zwGH6YfE6BRuYJ9AhNzgQQ37xp2TpH40i/4UnBrit
         rRYA==
X-Gm-Message-State: APf1xPD4oo7CHzSasAEdhLQ6HnnF+nSlycutZ3MPL95E4u8GeULHdDbd
        qa/jasWzS0zG4sA5a0nKs4I62w==
X-Google-Smtp-Source: AH8x226F8kHJ7BS+etRnrqXTAA9vpBReadXAwLbu+x0KevyVMxFoBskVDdp7Sd71WhdjOfWQZlSyKQ==
X-Received: by 10.46.50.3 with SMTP id y3mr7561691ljy.90.1519063619211;
        Mon, 19 Feb 2018 10:06:59 -0800 (PST)
Received: from localhost.localdomain (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id i6sm4922316lji.26.2018.02.19.10.06.58
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Feb 2018 10:06:58 -0800 (PST)
Date:   Mon, 19 Feb 2018 21:06:56 +0300
From:   Peter Mamonov <pmamonov@gmail.com>
To:     linux-mips@linux-mips.org
Subject: fcntl64 syscall causes user program stack corruption
Message-ID: <20180219180655.wiotjqubelp7ywxs@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <pmamonov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62624
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

Hello,

After upgrading the Linux kernel to the recent version I've found that the 
Firefox browser from the Debian 8 (jessie),mipsel stopped working: it causes 
Bus Error exception at startup. The problem is reproducible with the QEMU 
virtual machine (qemu-system-mips64el). Thorough investigation revealed that 
the following syscall in /lib/mipsel-linux-gnu/libpthread-2.19.so causes 
Firefox's stack corruption at address 0x7fff5770:

	0x77fabd28:  li      v0,4220
	0x77fabd2c:  syscall

Relevant registers contents are as follows:

		  zero       at       v0       v1       a0       a1       a2       a3
	 R0   00000000 300004e0 0000107c 77c2e6b0 00000006 0000000e 7fff574c 7fff5770 

The stack corruption is caused by the following patch:

	commit 8c6657cb50cb037ff58b3f6a547c6569568f3527
	Author: Al Viro <viro@zeniv.linux.org.uk>
	Date:   Mon Jun 26 23:51:31 2017 -0400
	
	    Switch flock copyin/copyout primitives to copy_{from,to}_user()
	    
	    ... and lose HAVE_ARCH_...; if copy_{to,from}_user() on an
	    architecture sucks badly enough to make it a problem, we have
	    a worse problem.
	    
	    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reverting the change in put_compat_flock() introduced by the patch prevents the 
stack corruption:

	diff --git a/fs/fcntl.c b/fs/fcntl.c
	index 0345a46b8856..c55afd836e5d 100644
	--- a/fs/fcntl.c
	+++ b/fs/fcntl.c
	@@ -550,25 +550,27 @@ static int get_compat_flock64(struct flock *kfl, const struct compat_flock64 __u
	 
	 static int put_compat_flock(const struct flock *kfl, struct compat_flock __user *ufl)
	 {
	-       struct compat_flock fl;
	-
	-       memset(&fl, 0, sizeof(struct compat_flock));
	-       copy_flock_fields(&fl, kfl);
	-       if (copy_to_user(ufl, &fl, sizeof(struct compat_flock)))
	+       if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
	+           __put_user(kfl->l_type, &ufl->l_type) ||
	+           __put_user(kfl->l_whence, &ufl->l_whence) ||
	+           __put_user(kfl->l_start, &ufl->l_start) ||
	+           __put_user(kfl->l_len, &ufl->l_len) ||
	+           __put_user(kfl->l_pid, &ufl->l_pid))
	                return -EFAULT;
	        return 0;
	 }

Actually, the change introduced by the patch is ok. However, it looks like 
there is either a mismatch of sizeof(struct compat_flock) between the kernel 
and the user space or a mismatch of types used by the kernel and the user 
space.  Despite the fact that the user space is built for a different kernel 
version (3.16), I believe this syscall should work fine with it, since `struct 
compat_flock` did not change since the 3.16.  So, probably, the problem is 
caused by some discrepancies which were hidden until "Switch flock 
copyin/copyout..." patch.

Please, give your comments.

Regards,
Peter
