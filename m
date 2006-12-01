Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:29:57 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:46894 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038324AbWLAP3w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:29:52 +0000
Received: by mo.po.2iij.net (mo32) id kB1FTkir023411; Sat, 2 Dec 2006 00:29:46 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1FTbdF080366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 2 Dec 2006 00:29:38 +0900 (JST)
Date:	Sat, 2 Dec 2006 00:29:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Message-Id: <20061202002937.7b4cb749.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <457042FF.2060908@innova-card.com>
References: <457042FF.2060908@innova-card.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 01 Dec 2006 15:58:07 +0100
Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:

>  config MACH_VR41XX
>  	bool "NEC VR41XX-based machines"
>  	select SYS_HAS_CPU_VR41XX
> +	select GENERIC_HARDIRQS_NO__DO_IRQ

NEC CMBVR4133 has i8259.
The other vr41xx boards have no problem.

Thanks,

Yoichi
