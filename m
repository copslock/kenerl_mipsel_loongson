Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 17:41:32 +0100 (BST)
Received: from p508B70C1.dip.t-dialin.net ([IPv6:::ffff:80.139.112.193]:55886
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225203AbUJPQlY>; Sat, 16 Oct 2004 17:41:24 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9GGf9Zw011434;
	Sat, 16 Oct 2004 18:41:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9GGexdh011433;
	Sat, 16 Oct 2004 18:40:59 +0200
Date: Sat, 16 Oct 2004 18:40:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: thomas_blattmann@canada.com
Cc: linux-mips@linux-mips.org
Subject: Re: crt1.o missing
Message-ID: <20041016164059.GB3711@linux-mips.org>
References: <20041015174831.28904.h007.c009.wm@mail.canada.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015174831.28904.h007.c009.wm@mail.canada.com.criticalpath.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2004 at 05:48:31PM -0700, thomas_blattmann@canada.com wrote:

> I'm trying to crosscompile a hello-world program but it
> fails:
> 
> /usr/local/lib/gcc-lib/mipsel-linux/2.96-mips3264-000710/../../../../mipsel-linux/bin/ld: cannot open crt1.o:
> No such file or directory
> collect2: ld returned 1 exit status
> 
> There are several postings in the archives but non of
> them helped me on so far. I will probably have to get
> the libc for mipsel-linux - but where can I get it and
> what to do with it ??

You need to install libc; the crt1.o file would end up being in
/usr/local/mipsel-linux/lib/crt1.o then.

  Ralf
