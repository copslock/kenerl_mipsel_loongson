Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 21:33:41 +0000 (GMT)
Received: from terminus.zytor.com ([198.137.202.10]:20121 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S28580302AbXLRVdd (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 18 Dec 2007 21:33:33 +0000
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.1/8.13.8) with ESMTP id lBILRBar008837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 13:27:12 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id lBILRBSI007055;
	Tue, 18 Dec 2007 13:27:11 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.1/8.13.6) with ESMTP id lBILRAQq032006;
	Tue, 18 Dec 2007 13:27:10 -0800
Message-ID: <47683B2D.9030608@zytor.com>
Date:	Tue, 18 Dec 2007 13:27:09 -0800
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Alon Bar-Lev <alon.barlev@gmail.com>
CC:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [MIPS] Build an embedded initramfs into mips kernel
References: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>
In-Reply-To: <9e0cf0bf0712181208m7f16b9acpf3dba67f3556a613@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.91.2/5174/Tue Dec 18 11:07:58 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Alon Bar-Lev wrote:
> Hello,
> 
> I am trying to build a basic initramfs image into the kernel, using
> the CONFIG_INITRAMFS_SOURCE. The required result is a single image
> loaded into a target containing usermode application (busybox).
> 
> I use cross compile mipsel-unknown-linux-uclibc in order to build the
> kernel and the initramfs's usermode.
> 
> The cpio image is created using cpio -o -H newc command.
> 
> The same configuration works with i586-pc-linux-uclibc cross compile.
> 
> printk at init/main.c::run_init_process() shows that the
> kernel_execve() returns -2 (ENOENT) for /init and -14 (EFAULT) for
> /*/init.
> 
> Looking at the initramfs /init is available and executable.
> 
> Any reason why I get ENOENT?
> Any special procedure should be performed for mips arch?
> 

Make sure your /init doesn't depend on an interpreter or library which 
isn't available.

	-hpa
