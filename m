Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2003 22:00:02 +0100 (BST)
Received: from [IPv6:::ffff:211.154.175.2] ([IPv6:::ffff:211.154.175.2]:18436
	"EHLO mail.netpower.com.cn") by linux-mips.org with ESMTP
	id <S8225460AbTJTVAA>; Mon, 20 Oct 2003 22:00:00 +0100
Received: from netpower.com.cn [192.168.0.195] by mail.netpower.com.cn with ESMTP
  (SMTPD32-7.07) id AB3D17800FA; Tue, 21 Oct 2003 04:53:17 +0800
Message-ID: <3F944CF1.2010608@netpower.com.cn>
Date: Tue, 21 Oct 2003 05:00:33 +0800
From: Zhang Haitao <zhanght@netpower.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: kernel modules
References: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com> <20031020183922.GD15997@linux-mips.org>
In-Reply-To: <20031020183922.GD15997@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <zhanght@netpower.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhanght@netpower.com.cn
Precedence: bulk
X-list: linux-mips

On Mon, Oct 20, Ralf Baechle wrote:
>
> 
> You're _not_ using the same options as the kernel's Makefile does for
> building modules.
> 
>   Ralf
> 
Hi, modules compiled using these parameters are working on my 2.4.21 SMP 
kernel:

	CFLAGS="-I .../include/asm/gcc -D__KERNEL__ -I.../include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=XX 
-mips2 -Wa,--trap -pipe -DMODULE -mlong-calls"

XX = your chip style

Zhang Haitao
