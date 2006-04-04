Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 02:53:18 +0100 (BST)
Received: from lennier.cc.vt.edu ([198.82.162.213]:2272 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133791AbWDDBxJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 02:53:09 +0100
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k34246MH006150;
	Mon, 3 Apr 2006 22:04:06 -0400
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by dagger.cc.vt.edu (MOS 3.7.3a-GA)
	with ESMTP id FKT75696 (AUTH spbecker);
	Mon, 3 Apr 2006 22:04:05 -0400 (EDT)
Message-ID: <4431D413.5050403@gentoo.org>
Date:	Mon, 03 Apr 2006 22:04:03 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060324)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: build error about current git
References: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> Hi,
> 
> I got the following error, when I built the kernel using current git.
> 
> Yoichi

Why don't you take a closer look at the output of "gcc -v" which you
pasted below, and then you tell us why your x86 toolchain can't build a
mips kernel.

-Steve

> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
> Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --enable-__cxa_atexit --with-system-zlib --enable-nls --without-included-gettext --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
> Thread model: posix
> gcc version 3.3.5 (Debian 1:3.3.5-13)
> 
> 
> 
