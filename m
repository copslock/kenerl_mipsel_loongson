Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 20:08:31 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.171]:12449 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28580084AbXLRUIW (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 18 Dec 2007 20:08:22 +0000
Received: by ug-out-1314.google.com with SMTP id k3so185413ugf.38
        for <linux-mips@ftp.linux-mips.org>; Tue, 18 Dec 2007 12:08:12 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3jyUfH+bAthU59RUNytI0o9Lyld5Eoq7wbaXHZqYonM=;
        b=xrhw4BfK8JT+IVK9bY2tyFPABFSpnVEZC9pNwm7uWDO4ZK8w70jd0ZXzi8GQIk11wT/Zniyf/zSrTi4/9KFM8tPKf/aVkqUzNEyfBYtzRwGUsKXk3us9+MhrFP4+VoYWQEGgl6Xjipmn0oHM927MsBtxsbf+a85Lu6J0pGyDcR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DKcVFpoirmGLyqtO90p3XFuWXDXzwuxGN53Q42WLqzRzJ7++Tv5Gt9f1flH59dV7cqqCU2sBFCbKzwu8/ocVTml1t0uE/Jz0TVU5HXxhWXtVgkX2nRrS2CX3ENjGKesE3znMHrM/8AQ4UUVKRoQMeLfUR1151ZgPAfflS8EoJPc=
Received: by 10.67.22.2 with SMTP id z2mr1293517ugi.1.1198008492559;
        Tue, 18 Dec 2007 12:08:12 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Tue, 18 Dec 2007 12:08:12 -0800 (PST)
Message-ID: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>
Date:	Tue, 18 Dec 2007 22:08:12 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: [MIPS] Build an embedded initramfs into mips kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to build a basic initramfs image into the kernel, using
the CONFIG_INITRAMFS_SOURCE. The required result is a single image
loaded into a target containing usermode application (busybox).

I use cross compile mipsel-unknown-linux-uclibc in order to build the
kernel and the initramfs's usermode.

The cpio image is created using cpio -o -H newc command.

The same configuration works with i586-pc-linux-uclibc cross compile.

printk at init/main.c::run_init_process() shows that the
kernel_execve() returns -2 (ENOENT) for /init and -14 (EFAULT) for
/*/init.

Looking at the initramfs /init is available and executable.

Any reason why I get ENOENT?
Any special procedure should be performed for mips arch?

Best Regards,
Alon Bar-Lev.
