Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 12:01:58 +0100 (BST)
Received: from imo-m06.mx.aol.com ([IPv6:::ffff:64.12.136.161]:39659 "EHLO
	imo-m06.mx.aol.com") by linux-mips.org with ESMTP
	id <S8225208AbTDIIaY>; Wed, 9 Apr 2003 09:30:24 +0100
Received: from Kumba12345@aol.com
	by imo-m06.mx.aol.com (mail_out_v34.21.) id l.1a4.129edea5 (16781)
	 for <linux-mips@linux-mips.org>; Wed, 9 Apr 2003 04:30:05 -0400 (EDT)
From: Kumba12345@aol.com
Message-ID: <1a4.129edea5.2bc5340c@aol.com>
Date: Wed, 9 Apr 2003 04:30:04 EDT
Subject: Re: cross-compiler for mips (r5432)
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="part1_1a4.129edea5.2bc5340c_boundary"
X-Mailer: 7.0 for Windows sub 10634
Return-Path: <Kumba12345@aol.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1956
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kumba12345@aol.com
Precedence: bulk
X-list: linux-mips


--part1_1a4.129edea5.2bc5340c_boundary
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit


       Not sure if this will help any, but this configuration helped me build 
a sparc -> mips cross compiler using glibc 2.3.2, gcc 3.2.2, and binutils 
2.13.90.0.16.  Works fine so far, I've built kernels with it and had no 
issues yet.  Although, I do not claim to be an expert in the field of 
cross-compiling -- it seems to be almost an artform.

//------------------

export myARCH=mips-unknown-linux-gnu
export myHOST=sparc-unknown-linux-gnu
export myDEST=/home/crossdev/mips

binutils:
../configure --target=${myARCH} --host=${myHOST} --prefix=${myDEST} 
--enable-shared --enable-64-bit-bfd && make

gcc-bootstrap:
../configure --prefix=${myDEST} --target=${myARCH} --host=${myHOST} 
--with-newlib --without-headers --disable-shared --disable-threads 
--enable-languages=c --disable-multilib && make

glibc:
CC="${myARCH}-gcc" CFLAGS="-O2 -mips2" ../configure --prefix=${myDEST} 
--host=${myARCH} --build=${myHOST} --without-tls --without-__thread 
--enable-add-ons=linuxthreads --enable-kernel=2.4.0 --with-gd=no 
--without-cvs --disable-profile --with-headers="${myDEST}/include" && make 
-j2

gcc-full
../configure --prefix=${myDEST} --target=${myARCH} --host=${myHOST} 
--disable-multilib --enable-shared --enable-languages="c,c++,ada,f77,objc" 
--enable-nls --without-included-gettext --with-system-zlib 
--enable-threads=posix --enable-long-long --disable-checking 
--enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit 
--enable-version-specific-runtime-libs --with-local-prefix=${prefix}/local 
--with-libs="${myDEST}/lib" --with-headers="${myDEST}/${myARCH}/include" && 
make -j2

//------------------

--Kumba


In a message dated 4/9/2003 02:19:18 Eastern Daylight Time, 
madhavis@sasken.com writes:


> Hi
> 
> I want to install a cross-compiler for MIPS(R5432 CPU) on an i686 host.
> Since R4000 is compatible with R5432, I am using "mips3" as the target.
> binutils-2.13 and I phase compilation of gcc-3.2 happened without any
> problems. But, glibc-2.2.5 is giving many compilation problems. This is
> how I configured glibc:
> 
> configure --build=i686-linux --host=mips3el-linux --enable-add-ons
> --prefix=/usr.
> 
> Could someone guide me on this or give me some pointers for installation?
> Is the target option "mips3" the right choice for R5432?
> 
> Thank you in advance.
> 
> regards
> Madhavi.
> 
> Madhavi Suram
> Software Engineer
> Customer Delivery / Networks
> Sasken Communication Technologies Limited
> 139/25, Ring Road, Domlur
> Bangalore - 560071 India
> Email: madhavis@sasken.com
> Tel: + 91 80 5355501 Extn: 8062
> Fax: + 91 80 5351133
> URL: www.sasken.com
> 
--part1_1a4.129edea5.2bc5340c_boundary
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<HTML><FONT FACE=3Darial,helvetica><FONT  SIZE=3D2><BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not sure if this will help any, but thi=
s configuration helped me build a sparc -&gt; mips cross compiler using glib=
c 2.3.2, gcc 3.2.2, and binutils 2.13.90.0.16.&nbsp; Works fine so far, I've=
 built kernels with it and had no issues yet.&nbsp; Although, I do not claim=
 to be an expert in the field of cross-compiling -- it seems to be almost an=
 artform.<BR>
<BR>
//------------------<BR>
<BR>
export myARCH=3Dmips-unknown-linux-gnu<BR>
export myHOST=3Dsparc-unknown-linux-gnu<BR>
export myDEST=3D/home/crossdev/mips<BR>
<BR>
binutils:<BR>
../configure --target=3D${myARCH} --host=3D${myHOST} --prefix=3D${myDEST} --=
enable-shared --enable-64-bit-bfd &amp;&amp; make<BR>
<BR>
gcc-bootstrap:<BR>
../configure --prefix=3D${myDEST} --target=3D${myARCH} --host=3D${myHOST} --=
with-newlib --without-headers --disable-shared --disable-threads --enable-la=
nguages=3Dc --disable-multilib &amp;&amp; make<BR>
<BR>
glibc:<BR>
CC=3D"${myARCH}-gcc" CFLAGS=3D"-O2 -mips2" ../configure --prefix=3D${myDEST}=
 --host=3D${myARCH} --build=3D${myHOST} --without-tls --without-__thread --e=
nable-add-ons=3Dlinuxthreads --enable-kernel=3D2.4.0 --with-gd=3Dno --withou=
t-cvs --disable-profile --with-headers=3D"${myDEST}/include" &amp;&amp; make=
 -j2<BR>
<BR>
gcc-full<BR>
../configure --prefix=3D${myDEST} --target=3D${myARCH} --host=3D${myHOST} --=
disable-multilib --enable-shared --enable-languages=3D"c,c++,ada,f77,objc" -=
-enable-nls --without-included-gettext --with-system-zlib --enable-threads=
=3Dposix --enable-long-long --disable-checking --enable-cstdio=3Dstdio --ena=
ble-clocale=3Dgeneric --enable-__cxa_atexit --enable-version-specific-runtim=
e-libs --with-local-prefix=3D${prefix}/local --with-libs=3D"${myDEST}/lib" -=
-with-headers=3D"${myDEST}/${myARCH}/include" &amp;&amp; make -j2<BR>
<BR>
//------------------<BR>
<BR>
--Kumba<BR>
<BR>
<BR>
In a message dated 4/9/2003 02:19:18 Eastern Daylight Time, madhavis@sasken.=
com writes:<BR>
<BR>
<BR>
<BLOCKQUOTE TYPE=3DCITE style=3D"BORDER-LEFT: #0000ff 2px solid; MARGIN-LEFT=
: 5px; MARGIN-RIGHT: 0px; PADDING-LEFT: 5px">Hi<BR>
<BR>
I want to install a cross-compiler for MIPS(R5432 CPU) on an i686 host.<BR>
Since R4000 is compatible with R5432, I am using "mips3" as the target.<BR>
binutils-2.13 and I phase compilation of gcc-3.2 happened without any<BR>
problems. But, glibc-2.2.5 is giving many compilation problems. This is<BR>
how I configured glibc:<BR>
<BR>
configure --build=3Di686-linux --host=3Dmips3el-linux --enable-add-ons<BR>
--prefix=3D/usr.<BR>
<BR>
Could someone guide me on this or give me some pointers for installation?<BR=
>
Is the target option "mips3" the right choice for R5432?<BR>
<BR>
Thank you in advance.<BR>
<BR>
regards<BR>
Madhavi.<BR>
<BR>
Madhavi Suram<BR>
Software Engineer<BR>
Customer Delivery / Networks<BR>
Sasken Communication Technologies Limited<BR>
139/25, Ring Road, Domlur<BR>
Bangalore - 560071 India<BR>
Email: madhavis@sasken.com<BR>
Tel: + 91 80 5355501 Extn: 8062<BR>
Fax: + 91 80 5351133<BR>
URL: www.sasken.com<BR>
</FONT></HTML>
--part1_1a4.129edea5.2bc5340c_boundary--
