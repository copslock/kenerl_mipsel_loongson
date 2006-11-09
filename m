Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2006 12:07:50 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62849 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037506AbWKIMHs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Nov 2006 12:07:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA9C8CXx017972;
	Thu, 9 Nov 2006 12:08:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA9C8BEc017971;
	Thu, 9 Nov 2006 12:08:11 GMT
Date:	Thu, 9 Nov 2006 12:08:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	=?utf-8?B?sei5zsL5?= <barrioskmc@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: upgrade toolchain(gcc-4.1)
Message-ID: <20061109120811.GA17860@linux-mips.org>
References: <000f01c703c3$de5d7000$45a6580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000f01c703c3$de5d7000$45a6580a@swcenter.sec.samsung.co.kr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 09, 2006 at 02:56:55PM +0900, ������ wrote:
> From:	������ <barrioskmc@gmail.com>

> Hi all. 
> Currently I use gcc-3.4.4 in my mips board. 
> I want to update my toolchain(gcc, glibc, binutil etc.. ) to latest new
> toolchains( for example, gcc-4.1)
> But, in http://www.linux-mips.org/wiki/Toolchains, Roll-your-own is
> obsolete. Also, There isn't description about glibc. 

Updating glibc is a little non-trivial due to compatibility issues, extra
patches requires, version dependencies to the build environment and other
constraints so I deciede to drop the glibc documentation when I replaced
the old MIPS Howto document with the current size.

The good news are that the glibc world is getting somewhat simpler again
so maybe it's time to re-introduce some glibc documentation.

That said glibc will probably always stay somewhat non-trivial and most
people are probably best off by just using binaries.

  Ralf
