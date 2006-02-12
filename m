Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 20:43:53 +0000 (GMT)
Received: from networks.syneticon.net ([213.239.212.131]:14738 "EHLO
	mail2.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S8133496AbWBLUnk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 20:43:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id CF3033C6FE;
	Sun, 12 Feb 2006 21:49:52 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02199-19; Sun, 12 Feb 2006 21:49:48 +0100 (CET)
Received: from [84.44.217.177] (xdsl-84-44-217-177.netcologne.de [84.44.217.177])
	by mail2.syneticon.net (Postfix) with ESMTP;
	Sun, 12 Feb 2006 21:49:48 +0100 (CET)
Message-ID: <43EF9F6A.8000207@wpkg.org>
Date:	Sun, 12 Feb 2006 21:49:46 +0100
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060210)
MIME-Version: 1.0
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org> <43EF8C16.9020104@total-knowledge.com> <43EF985C.4060609@wpkg.org> <43EF9B63.7020506@total-knowledge.com>
In-Reply-To: <43EF9B63.7020506@total-knowledge.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at syneticon.de
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> Tomasz Chmielewski wrote:
> 
>> Ilya A. Volynets-Evenbakh wrote:
>>
>>> Are you sure it is what you want? I somehow suspect that you want to
>>> generate toolchain to build things
>>> natively on your mipsel box to run on said box. If that is true,
>>> buildroot (http://buildroot.uclibc.org) will do everything
>>
>> Buildroot also builds gcc which works on let's say x86 and makes
>> binaries for mipsel/uclibc).
>>
>> I need the gcc binaries which will work on mipsel, and which will
>> build for mipsel.
> 
> Buildroot builds _both_. At least it has support for building both.

OK, than I didn't look close enough.


>>> for you. Also, I think crosstool does it by default as well (not 100%
>>> sure though). Look under your destination dir
>>> for <target>/bin/gcc.
>>
>> Crosstool by default builds the binaries on system X that will run on
>> system X and build for Y.
>>
>> So now I have binaries that build for mipsel/uclibc on x86, but I
>> can't build gcc that will work on mipsel/uclibc with it.
> 
> Let's say you build with instdir /crosstool
> Then look for mipsel toolchain binaries in
> /crosstool/gcc-x.y.z-glibc-K.L.M/mipsel-linux-gnu/mipsel-linux-gnu/bin

It's all x86 cross compilers (they will build for mipsel, on x86):


# pwd
/opt/crosstool/mipsel-unknown-linux-uclibc/gcc-3.3.3-uClibc-0.9.23/mipsel-unknown-linux-uclibc/bin
# file gcc
gcc: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for 
GNU/Linux 2.2.5, dynamically linked (uses shared libs), for GNU/Linux 
2.2.5, not stripped

# pwd
/opt/crosstool/mipsel-unknown-linux-uclibc/gcc-3.3.3-uClibc-0.9.23/bin
# file mipsel-unknown-linux-uclibc-gcc
mipsel-unknown-linux-uclibc-gcc: ELF 32-bit LSB executable, Intel 80386, 
version 1 (SYSV), for GNU/Linux 2.2.5, dynamically linked (uses shared 
libs), for GNU/Linux 2.2.5, not stripped


So I guess I need to spend some more time on it, if I don't figure out, 
I'll keep on asking :)

-- 
Tomasz Chmielewski
Software deployment with Samba
http://wpkg.org
