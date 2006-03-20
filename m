Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 06:13:39 +0000 (GMT)
Received: from mo00.po.2iij.Net ([210.130.202.204]:57822 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8127231AbWCTGNa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 06:13:30 +0000
Received: NPO MO00 id k2K6N4KI002844; Mon, 20 Mar 2006 15:23:04 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox01) id k2K6N2W0012921
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 20 Mar 2006 15:23:03 +0900 (JST)
Date:	Mon, 20 Mar 2006 15:23:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/12] [MIPS] Remove tb0287_defconfig
Message-Id: <20060320152302.22588fd8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043926.GC20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043926.GC20416@deprecation.cyrius.com>
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
X-archive-position: 10873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Mar 2006 04:39:26 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> Remove the tb0287 defconfig file since this platform is no longer
> supported.  This brings mainline in sync with the linux-mips tree.

The TB0287 is supported.
I'm testing -rc and -mm release on TB0287.

Yoichi
