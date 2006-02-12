Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 20:26:42 +0000 (GMT)
Received: from alpha.total-knowledge.com ([205.217.158.170]:36491 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S8133496AbWBLU0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 20:26:32 +0000
Received: (qmail 7583 invoked from network); 12 Feb 2006 11:33:48 -0800
Received: from unknown (HELO ?10.50.163.242?) (ilya@209.157.142.204)
  by alpha.total-knowledge.com with ESMTPA; 12 Feb 2006 11:33:48 -0800
Message-ID: <43EF9B63.7020506@total-knowledge.com>
Date:	Sun, 12 Feb 2006 12:32:35 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Tomasz Chmielewski <mangoo@wpkg.org>
CC:	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org> <43EF8C16.9020104@total-knowledge.com> <43EF985C.4060609@wpkg.org>
In-Reply-To: <43EF985C.4060609@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Tomasz Chmielewski wrote:

> Ilya A. Volynets-Evenbakh wrote:
>
>> Are you sure it is what you want? I somehow suspect that you want to
>> generate toolchain to build things
>> natively on your mipsel box to run on said box. If that is true,
>> buildroot (http://buildroot.uclibc.org) will do everything
>
>
> Buildroot also builds gcc which works on let's say x86 and makes
> binaries for mipsel/uclibc).
>
> I need the gcc binaries which will work on mipsel, and which will
> build for mipsel.

Buildroot builds _both_. At least it has support for building both.

>
>
>> for you. Also, I think crosstool does it by default as well (not 100%
>> sure though). Look under your destination dir
>> for <target>/bin/gcc.
>
>
> Crosstool by default builds the binaries on system X that will run on
> system X and build for Y.
>
> So now I have binaries that build for mipsel/uclibc on x86, but I
> can't build gcc that will work on mipsel/uclibc with it.

Let's say you build with instdir /crosstool
Then look for mipsel toolchain binaries in
/crosstool/gcc-x.y.z-glibc-K.L.M/mipsel-linux-gnu/mipsel-linux-gnu/bin

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
