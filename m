Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 16:49:28 +0200 (CEST)
Received: from SBA.FLIR.com ([12.164.250.85]:37579 "EHLO coral.sba.flir.net")
	by ftp.linux-mips.org with ESMTP id S8133443AbWEPOtT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 May 2006 16:49:19 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=neXtPaRt_1147790958"
Subject: RE: problem building cross compiler gcc-3.4.4
Date:	Tue, 16 May 2006 07:49:15 -0700
Message-ID: <D68CE2DA7B2E3C4B880DAFD4DE38EE16630B6E@coral.sba.flir.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem building cross compiler gcc-3.4.4
Thread-Index: AcZ4qpak6ACT7djqRd+dkBQ0ILv95QAS9rBQ
From:	"De Jong, Rienco" <Marinus.DeJong@flir.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Marinus.DeJong@flir.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marinus.DeJong@flir.com
Precedence: bulk
X-list: linux-mips


------=neXtPaRt_1147790958
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Shyamal,

I also have problems with compiling a mips platform for threads.  I used
the buildroot environment but made no progress.  I am able to compile
buildroot for the old/stable version of linux threads which also
includes a version of gcc.  I also tried posting to this list but have
heard no response as of yet so this is probably not the right list for
this kind of question.

I was trying to get the use of the NPTL. Are you trying to build for
NPTL as well?  If not you should be able to use the previous build of
the compiler to build the old and stable version of linux threads.
Apparently gcc doesn't need to have the --enable_threads flag set for
that but I can't say for sure.

Rienco De Jong


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Shyamal Sadanshio
Sent: Monday, May 15, 2006 10:35 PM
To: linux-mips@linux-mips.org
Subject: Fwd: problem building cross compiler gcc-3.4.4

Hi,

I am facing gcc 3.4.4 build problem for mips platform with
--enable-thread options.

../gcc-3.4.4/configure --target=3D$TARGET --prefix=3D$PREFIX
--enable-language=3Dc
--with-headers=3D/opt/crosstool/mipsel-unknown-linux-gnu/sys-include/
--with-gnu-ld --with-gnu-as --disable-shared --enable-threads

Error message are listed as below:
************************************************************************
*************************
In file included from ./tm.h:13,
                 from ../../gcc-3.4.4/gcc/libgcc2.c:43:
../../gcc-3.4.4/gcc/config/mips/linux.h:198: error: parse error before
"stack_t"
../../gcc-3.4.4/gcc/config/mips/linux.h:198: warning: no semicolon at
end of str
uct or union
../../gcc-3.4.4/gcc/config/mips/linux.h:201: error: parse error before
'}' token
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: type defaults to
`int' in
declaration of `_sig_ucontext_t'
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: data definition
has no typ
e or storage class
In file included from ./tm.h:13,
                 from ../../gcc-3.4.4/gcc/libgcc2.c:43:
../../gcc-3.4.4/gcc/config/mips/linux.h:198: error: parse error before
"stack_t"
../../gcc-3.4.4/gcc/config/mips/linux.h:198: warning: no semicolon at
end of str
uct or union
../../gcc-3.4.4/gcc/config/mips/linux.h:201: error: parse error before
'}' token
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: type defaults to
`int' in
declaration of `_sig_ucontext_t'
../../gcc-3.4.4/gcc/config/mips/linux.h:201: warning: data definition
has no typ
e or storage class
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [libgcc/./_negdi2.o] Error 1
make[2]: Leaving directory
`/tmp/mipsel-unknown-linux-gnu-toolchain/build-gcc-bo
otstrap/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory
`/tmp/mipsel-unknown-linux-gnu-toolchain/build-gcc-bo
otstrap/gcc'
make: *** [all-gcc] Error 2

************************************************************************
*************************
I am able to build the minimal version of compiler for kernel build
with config options as below:

../gcc-3.4.4/configure --target=3D$TARGET --prefix=3D$PREFIX
--enable-language=3Dc --without-headers --with-gnu-ld --with-gnu-as
--disable-shared --disable-threads

Has anybody faced this issue earlier?
Will be grateful if someone could comment on this issue.

Thanks and Regards,
Shyamal


Thanks and Regards,
Shyamal


------=neXtPaRt_1147790958
Content-Type: text/plain;

**********************************************************************
Notice to recipient: This email is meant for only the intended recipient of the transmission, and may be a communication privileged by law, subject to export control restrictions or that otherwise contains proprietary information.  If you receive this email by mistake, please notify us immediately by replying to this message and then destroy it and do not review, disclose, copy or distribute it.  Thank you in advance for your cooperation.
**********************************************************************


------=neXtPaRt_1147790958--
