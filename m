Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2005 04:50:02 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:50166
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8224913AbVACEt4>; Mon, 3 Jan 2005 04:49:56 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <ZYJ9722Y>; Mon, 3 Jan 2005 09:40:09 +0500
Message-ID: <1B701004057AF74FAFF851560087B161064699@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'Stephen P. Becker'" <geoman@gentoo.org>,
	'Scott Parker' <whtghst1@direcway.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: cross compiling gcc for mips
Date: Mon, 3 Jan 2005 09:40:03 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

Hi,

Initially I was configuring gcc by

../gcc-3.4.3/configure --target=mipsel-linux --prefix=${PREFIX}
--without-headers --with-newlib --enable-languages=c

I looked up a bit and found --disable-threads option, so when I configure
gcc using --disbale-threads option I don't get the the initial threads
related errors but i just get

/home/mudeem/ashwaria_rai/tools/mipsel-linux/bin/ld: crti.o: No such file:
No such file or directory
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory
`/home/mudeem/ashwaria_rai/build-tools/build-boot-gcc/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory
`/home/mudeem/ashwaria_rai/build-tools/build-boot-gcc/gcc'
make: *** [all-gcc] Error 2

Steve, if I am specifying --without-headers flag, that means not using
headers at all right??? Actaully I am following the instructions from the
O'Reilly's book "building Embedded Linux Systems" It is written that
--without-headers option is broken in gcc 3.2 and subsequent 3.2.1 releases.
Has it been fixed in gcc 3.4.3 ???

Mudeem


-----Original Message-----
From: Stephen P. Becker [mailto:geoman@gentoo.org]
Sent: Sunday, January 02, 2005 10:01 PM
To: Scott Parker
Cc: Mudeem Iqbal; 'linux-mips@linux-mips.org'
Subject: Re: cross compiling gcc for mips


Scott Parker wrote:
> How did you configure GCC?
> 
> Mudeem Iqbal wrote:
> 
>> Hi,
>>
>> I am building a toolchain for mips platform. I am using
>>
>> binutils-2.15
>> gcc-3.4.3
>> glibc-2.3.3
>> linux-2.6.9    (from linux-mips.org)
>>

Try using 2.4 headers instead.  I haven't had much success using 2.6 
headers to build a mips (cross)toolchain.

Steve
