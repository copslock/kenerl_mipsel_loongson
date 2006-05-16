Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 07:35:06 +0200 (CEST)
Received: from py-out-1112.google.com ([64.233.166.176]:20715 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S8133363AbWEPFe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 May 2006 07:34:57 +0200
Received: by py-out-1112.google.com with SMTP id s49so987457pyc
        for <linux-mips@linux-mips.org>; Mon, 15 May 2006 22:34:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYEaF6m4dAbshB/KleP0n3fh50hfwx0BILgeJ45fEpwdGjykg4sOCK3xjFXBnH6INtuVQpmpXJnUw/74KSgj5Ff3aJdEIA/R42fRbcsY/i3KK++32q8PQ5g9rRa4QZF4dw8jOTxKqZvqBNE5Ns47vbZmAxWVgHyVT/1VBQ+azNU=
Received: by 10.35.37.18 with SMTP id p18mr786665pyj;
        Mon, 15 May 2006 22:34:55 -0700 (PDT)
Received: by 10.35.58.5 with HTTP; Mon, 15 May 2006 22:34:55 -0700 (PDT)
Message-ID: <3857255c0605152234r503c959ep5d773f8a20b4b201@mail.gmail.com>
Date:	Tue, 16 May 2006 11:04:55 +0530
From:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Fwd: problem building cross compiler gcc-3.4.4
In-Reply-To: <3857255c0605150658h51761270s6f647ffdeda1f7fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3857255c0605142352i6f7ed9bdh6c99eed60a80a3c4@mail.gmail.com>
	 <44686874.90101@mbnet.fi>
	 <3857255c0605150658h51761270s6f647ffdeda1f7fd@mail.gmail.com>
Return-Path: <shyamal.sadanshio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shyamal.sadanshio@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am facing gcc 3.4.4 build problem for mips platform with
--enable-thread options.

../gcc-3.4.4/configure --target=$TARGET --prefix=$PREFIX
--enable-language=c
--with-headers=/opt/crosstool/mipsel-unknown-linux-gnu/sys-include/
--with-gnu-ld --with-gnu-as --disable-shared --enable-threads

Error message are listed as below:
*************************************************************************************************
In file included from ./tm.h:13,
                 from ../../gcc-3.4.4/gcc/libgcc2.c:43:
../../gcc-3.4.4/gcc/config/mips/linux.h:198: error: parse error before "stack_t"
../../gcc-3.4.4/gcc/config/mips/linux.h:198: warning: no semicolon at end of str
uct or union
../../gcc-3.4.4/gcc/config/mips/linux.h:201: error: parse error before '}' token
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: type defaults to `int' in
declaration of `_sig_ucontext_t'
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: data definition has no typ
e or storage class
In file included from ./tm.h:13,
                 from ../../gcc-3.4.4/gcc/libgcc2.c:43:
../../gcc-3.4.4/gcc/config/mips/linux.h:198: error: parse error before "stack_t"
../../gcc-3.4.4/gcc/config/mips/linux.h:198: warning: no semicolon at end of str
uct or union
../../gcc-3.4.4/gcc/config/mips/linux.h:201: error: parse error before '}' token
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: type defaults to `int' in
declaration of `_sig_ucontext_t'
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: data definition has no typ
e or storage class
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [libgcc/./_negdi2.o] Error 1
make[2]: Leaving directory `/tmp/mipsel-unknown-linux-gnu-toolchain/build-gcc-bo
otstrap/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory `/tmp/mipsel-unknown-linux-gnu-toolchain/build-gcc-bo
otstrap/gcc'
make: *** [all-gcc] Error 2

*************************************************************************************************
I am able to build the minimal version of compiler for kernel build
with config options as below:

../gcc-3.4.4/configure --target=$TARGET --prefix=$PREFIX
--enable-language=c --without-headers --with-gnu-ld --with-gnu-as
--disable-shared --disable-threads

Has anybody faced this issue earlier?
Will be grateful if someone could comment on this issue.

Thanks and Regards,
Shyamal


Thanks and Regards,
Shyamal
