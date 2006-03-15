Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2006 20:07:02 +0000 (GMT)
Received: from xrelay04.mail2web.com ([168.144.1.50]:45490 "EHLO
	xrelay04.mail2web.com") by ftp.linux-mips.org with ESMTP
	id S8133817AbWCOUGw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2006 20:06:52 +0000
Received: from [168.144.251.196] (helo=M2W085.mail2web.com)
	by xrelay04.mail2web.com with smtp (Exim 4.50)
	id 1FJcPU-0006o1-O5
	for linux-mips@linux-mips.org; Wed, 15 Mar 2006 15:15:59 -0500
Message-ID: <380-220063315201556492@M2W085.mail2web.com>
X-Priority: 3
Reply-To: dan.mcgee@ntsoc.com
X-Originating-IP: 64.241.199.88
X-URL:	http://mail2web.com/
From:	"dan.mcgee@ntsoc.com" <dan.mcgee@ntsoc.com>
To:	linux-mips@linux-mips.org
Date:	Wed, 15 Mar 2006 15:15:56 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Subject: Building GCC for BCM1480 SiByte 
Return-Path: <dan.mcgee@ntsoc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.mcgee@ntsoc.com
Precedence: bulk
X-list: linux-mips

Does anyone know the configuration flags to build gcc 4.1.0 compiler for
MIPS BCM1480 sb1 code.
The current build flags that I used are:
 ../configure   --with-system-zlib --libexecdir=/usr/lib
--prefix=/usr/local/gcc-4.0.2 --enable-shared --with-arch=sb1
--with-tune=sb1 --without-included-gettext --enable-nls
--program-suffix=-4.0.2 --enable-__cxa_atexit
--enable-libstdcxx-allocator=mt --with-target=mips64-linux

This compiler works, but there are no floating point optimization for the
sb1 fpu.


--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .
