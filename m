Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 19:22:27 +0000 (GMT)
Received: from alpha.total-knowledge.com ([205.217.158.170]:9355 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S8133488AbWBLTVX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 19:21:23 +0000
Received: (qmail 6614 invoked from network); 12 Feb 2006 10:28:36 -0800
Received: from unknown (HELO ?10.50.163.242?) (ilya@209.157.142.204)
  by alpha.total-knowledge.com with ESMTPA; 12 Feb 2006 10:28:36 -0800
Message-ID: <43EF8C16.9020104@total-knowledge.com>
Date:	Sun, 12 Feb 2006 11:27:18 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Tomasz Chmielewski <mangoo@wpkg.org>
CC:	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org>
In-Reply-To: <43EF7C06.3080006@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Canadian cross is when you build toolchain on system X to run on system
Y, and generate code for system Z.
Are you sure it is what you want? I somehow suspect that you want to
generate toolchain to build things
natively on your mipsel box to run on said box. If that is true,
buildroot (http://buildroot.uclibc.org) will do everything
for you. Also, I think crosstool does it by default as well (not 100%
sure though). Look under your destination dir
for <target>/bin/gcc.

Tomasz Chmielewski wrote:

> I'm trying to cross-compile gcc to work on mipsel / uClibc, to run
> there natively (that is, I want to compile on this mipsel / uClibc
> machine).
>
> So far I have a cross compiler that builds binaries for mipsel/uClibc
> on a x86 machine.
>
>
> According to crosstool HOWTO, "to do a Canadian Cross build with
> crosstool, you have to run it three times:
>
>    1. once to build a toolchain that runs on the build system and
> generates code for the host system
>    2. once to build a toolchain that runs on the build system and
> generates code for the target system
>    3. once to build a toolchain that runs on the host system and
> generates code for the target system".
>
> So I guess the first step is behind me, but I'm not sure how to do
> steps 2 and 3.
>
> Anyone knows how to do it?
> Or perhaps, there are already gcc binaries available for mipsel / uClibc?
>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
