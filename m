Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 06:22:01 +0000 (GMT)
Received: from mo00.po.2iij.Net ([210.130.202.204]:34279 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8126482AbWCTGVw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 06:21:52 +0000
Received: NPO MO00 id k2K6VSKI008444; Mon, 20 Mar 2006 15:31:28 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox02) id k2K6VR6Y006788
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 20 Mar 2006 15:31:27 +0900 (JST)
Date:	Mon, 20 Mar 2006 15:31:27 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] [MIPS] Cosmetic updates to sync with linux-mips
Message-Id: <20060320153127.520a6a50.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043915.GB20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043915.GB20416@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Mar 2006 04:39:15 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> Make some cosmetic changes in order to bring mainline in sync
> with the linux-mips tree.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> 
> --- linux-2.6/arch/mips/Makefile	2006-03-13 18:45:54.000000000 +0000
> +++ mips.git/arch/mips/Makefile	2006-03-13 18:43:52.000000000 +0000
> @@ -498,6 +499,7 @@
>  cflags-$(CONFIG_PMC_YOSEMITE)	+= -Iinclude/asm-mips/mach-yosemite
>  load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
>  
> +#
>  # Qemu simulating MIPS32 4Kc
>  #
>  core-$(CONFIG_QEMU)		+= arch/mips/qemu/
> @@ -584,7 +586,7 @@
>  load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
>  
>  #
> -# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
> +# TANBAC TB0225 VR4131 Multi-chip module/TB0229 VR4131DIMM (VR4131)

The linux-mips tree is older than kernel.org about this line.

Yoichi
