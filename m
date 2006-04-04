Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 04:41:53 +0100 (BST)
Received: from mo00.po.2iij.net ([210.130.202.204]:52702 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8126537AbWDDDlm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 04:41:42 +0100
Received: NPO MO00 id k343qiiv011817; Tue, 4 Apr 2006 12:52:44 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox01) id k343qgRw005816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 4 Apr 2006 12:52:43 +0900 (JST)
Date:	Tue, 4 Apr 2006 12:52:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: build error about current git
Message-Id: <20060404125242.4c5b1f1c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4431D413.5050403@gentoo.org>
References: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
	<4431D413.5050403@gentoo.org>
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
X-archive-position: 11018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 03 Apr 2006 22:04:03 -0400
"Stephen P. Becker" <geoman@gentoo.org> wrote:

> Yoichi Yuasa wrote:
> > Hi,
> > 
> > I got the following error, when I built the kernel using current git.
> > 
> > Yoichi
> 
> Why don't you take a closer look at the output of "gcc -v" which you
> pasted below, and then you tell us why your x86 toolchain can't build a
> mips kernel.

Because, the first error occurs in using HOSTCC. 

mips toolchain is

$ mipsel-linux-gcc -v
Reading specs from /usr/local/cross/lib/gcc-lib/mipsel-linux/3.3.2/specs
Configured with: ../gcc-3.3.2/configure --target=mipsel-linux --prefix=/usr/local/cross --enable-languages=c --without-headers --disable-shared --disable-threads : (reconfigured) ../gcc-3.3.2/configure --target=mipsel-linux --prefix=/usr/local/cross --enable-languages=c --without-headers --disable-shared --disable-threads : (reconfigured) ../gcc-3.3.2/configure --target=mipsel-linux --prefix=/usr/local/cross --enable-languages=c --without-headers --disable-shared --disable-threads : (reconfigured) ../gcc-3.3.2/configure --target=mipsel-linux --prefix=/usr/local/cross --enable-languages=c --disable-shared
Thread model: posix
gcc version 3.3.2

Yoichi
