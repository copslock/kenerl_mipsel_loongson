Received:  by oss.sgi.com id <S553791AbRAAOZ1>;
	Mon, 1 Jan 2001 06:25:27 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:18451 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553788AbRAAOZH>; Mon, 1 Jan 2001 06:25:07 -0800
Received: from redhat.com (IDENT:joe@dhcp-252.wirespeed.com [172.16.17.252] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id IAA23957;
	Mon, 1 Jan 2001 08:17:23 -0600
Message-ID: <3A5092A7.1060304@redhat.com>
Date:   Mon, 01 Jan 2001 08:22:31 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@cotw.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Simple problem with second stage MIPS GCC compiler...
References: <3A2FB3CB.3566F805@mips.com> <3A5018A0.6B43960B@cotw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The problem you have is that gcc doesn't know where the glibc headers 
are. You probably need to pass 
"--with-includes=/usr/local/mips/mipsel-linux-include" or alternatively 
put the headers in {prefix}/sys-include .

There is also another list for cross compiling with gcc 
(crossgcc@sources.redhat.com) which might give more informative answers 
than the simple one I have...

good luck with it!

Steven J. Hill wrote:

> Well, I almost have a complete toolchain. I succesfully got binutils,
> first stage GCC-2.95.2 and GLIBC-2.2 installed just fine. I am having
> problems with rebuilding GCC. Below is the configuration and make
> directives that I am currently using along with the output. I have
> verified that the header files are in /usr/local/mips/mipsel-linux-include.
> Any help or thoughts are need and appreciated. Yes, I read the mailing
> list archives. TIA.
> 
> -Steve
> 
> *************************************************************
> AR=mipsel-linux-ar RANLIB=mipsel-linux-ranlib ../gcc-2.95.2/configure
> --prefix=/usr/local/mips --target=mipsel-linux i686-pc-linux-gnu --enable-shared
> --enable-threads --enable-languages=c
> 
> make LANGUAGES=c ALL_TARGET_MODULES= CONFIGURE_TARGET_MODULES=
> INSTALL_TARGET_MODULES= SUBDIRS="libiberty gcc"
> 
> *************************************************************
> make[2]: Leaving directory `/data/mips-stuff/build-gcc2/gcc/intl'
> rm -f tmplibgcc2.a
> for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 _negdi2 _lshrdi3 _ashldi3
> _ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 _ucmpdi2 _floatdidf _floatdisf
> _fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi _fixunssfdi _fixsfdi _fixxfdi
> _fixunsxfdi _floatdixf _fixunsxfsi _fixtfdi _fixunstfdi _floatditf __gcc_bcmp
> _varargs __dummy _eprintf _bb _shtab _clear_cache _trampoline __main _exit
> _ctors _pure; \
> do \
>   echo ${name}; \
>   /data/mips-stuff/build-gcc2/gcc/xgcc -B/data/mips-stuff/build-gcc2/gcc/
> -B/usr/local/mips/mipsel-linux/bin/ -I/usr/local/mips/mipsel-linux/include -O2 
> -DCROSS_COMPILE -DIN_GCC     -g -O2 -I./include  -fPIC -g1 -DHAVE_GTHR_DEFAULT
> -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED   -I. -I../../gcc-2.95.2/gcc
> -I../../gcc-2.95.2/gcc/config -I../../gcc-2.95.2/gcc/../include -c -DL${name} \
>        ../../gcc-2.95.2/gcc/libgcc2.c -o ${name}.o; \
>   if [ $? -eq 0 ] ; then true; else exit 1; fi; \
>   mipsel-linux-ar rc tmplibgcc2.a ${name}.o; \
>   rm -f ${name}.o; \
> done
> _muldi3
> .../../gcc-2.95.2/gcc/libgcc2.c:41: stdlib.h: No such file or directory
> .../../gcc-2.95.2/gcc/libgcc2.c:42: unistd.h: No such file or directory
> make[1]: *** [libgcc2.a] Error 1
> make[1]: Leaving directory `/data/mips-stuff/build-gcc2/gcc'
> make: *** [all-gcc] Error 2


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
