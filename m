Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 02:27:17 +0100 (BST)
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:2024 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20022796AbXF2B1K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 02:27:10 +0100
Received: from sj-dkim-7.cisco.com ([171.68.10.88])
  by sj-iport-2.cisco.com with ESMTP; 28 Jun 2007 18:26:03 -0700
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAA78g0arRApYh2dsb2JhbACCMjWMRQIJDiw
X-IronPort-AV: i="4.16,473,1175497200"; 
   d="scan'208,217"; a="382551883:sNHT85294492"
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-7.cisco.com (8.12.11/8.12.11) with ESMTP id l5T1Q2CA012306
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 18:26:02 -0700
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com [128.107.191.100])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id l5T1Q2mo018083
	for <linux-mips@linux-mips.org>; Fri, 29 Jun 2007 01:26:02 GMT
Received: from xmb-sjc-237.amer.cisco.com ([128.107.191.123]) by xbh-sjc-231.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Jun 2007 18:26:02 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B9EC.7441C459"
Subject: upgrading glibc for mipsel
Date:	Thu, 28 Jun 2007 18:26:01 -0700
Message-ID: <27801B4D04E7CA45825B0E0CE60FE10A01F971CF@xmb-sjc-237.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: upgrading glibc for mipsel
Thread-Index: Ace5zRyfOVTIhqqaSfSufkB8ojYOBQAHodI5
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com> <20070627.013312.25479645.anemo@mba.ocn.ne.jp> <20070627153932.GA6016@lst.de> <20070628.112223.96686654.nemoto@toshiba-tops.co.jp> <20070628083725.GA23394@lst.de> <27801B4D04E7CA45825B0E0CE60FE10A0410F0D6@xmb-sjc-237.amer.cisco.com> <46842B05.5050103@avtrex.com>
From:	"Ratin Rahman \(mratin\)" <mratin@cisco.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 29 Jun 2007 01:26:02.0132 (UTC) FILETIME=[74801540:01C7B9EC]
DKIM-Signature:	v=0.5; a=rsa-sha256; q=dns/txt; l=9712; t=1183080362; x=1183944362;
	c=relaxed/simple; s=sjdkim7002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=mratin@cisco.com;
	z=From:=20=22Ratin=20Rahman=20\(mratin\)=22=20<mratin@cisco.com>
	|Subject:=20upgrading=20glibc=20for=20mipsel
	|Sender:=20;
	bh=ekugsSOMCDZ1OmsEG2KAigDdcn0dq6/z0fpKs41l4qk=;
	b=ATspc13Ju5ZWTp3R4gv7ESC/8D2y1qE2fi8bt4CxcXpuk6nfSFHgCtgzkbauoUBQkLCfdtQe
	s6inQKLxIuAxUROVTT4qR050532EiR2nLPdH4jUsok8X1q5UbdWAsSKz;
Authentication-Results:	sj-dkim-7; header.From=mratin@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Return-Path: <mratin@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mratin@cisco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B9EC.7441C459
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In an effort to build gdbserver, I am trying to upgrade my glibc and gcc =
cross compile tools. I am  having=20
problem while bulding glibc-2.3.3, mipsel compiler version 3.2.3 and =
current glibc ver
is 2.2.5.=20
=20
I exported all current cross tools and cross compiler with export.=20
=20
configured with the options:
../glibc-2.3.3/configure --prefix=3D/opt/crosstool =
--build=3Di686-pc-linux-gnu --host=3Dmipsel-linux =
--with-binutils=3D/opt/mipseltools/bin/ --enable-add-ons=3Dlinuxthreads
=20
did a make and after make went thru for 5 mins or so, it threw this =
error message:=20
I get the following error:
=20
 -Wl,-d -Wl,--whole-archive /workspace/ratin/make_glibc/libc_pic.a
/opt/mipseltools/bin/mipsel-linux-gcc -mabi=3D32   -shared -Wl,-O1 \
  -nostdlib -nostartfiles \
   -Wl,-dynamic-linker=3D/opt/crosstool/lib/ld.so.1  \
  -Wl,--verbose 2>&1 | \
  sed > /workspace/ratin/make_glibc/shlib.ldsT \
      -e =
'/^=3D=3D=3D=3D=3D=3D=3D=3D=3D/,/^=3D=3D=3D=3D=3D=3D=3D=3D=3D/!d;/^=3D=3D=
=3D=3D=3D=3D=3D=3D=3D/d' \
      -e 's/^.*\.hash[  ]*:.*$/  .note.ABI-tag : { *(.note.ABI-tag) } =
&/' \
      -e 's/^.*\*(\.dynbss).*$/& \
         PROVIDE(__start___libc_freeres_ptrs =3D .); \
         *(__libc_freeres_ptrs) \
         PROVIDE(__stop___libc_freeres_ptrs =3D .);/'
mv -f /workspace/ratin/make_glibc/shlib.ldsT =
/workspace/ratin/make_glibc/shlib.lds
/opt/mipseltools/bin/mipsel-linux-gcc -mabi=3D32   -shared =
-static-libgcc -Wl,-O1  -Wl,-z,defs =
-Wl,-dynamic-linker=3D/opt/crosstool/lib/ld.so.1  =
-B/workspace/ratin/make_glibc/csu/  =
-Wl,--version-script=3D/workspace/ratin/make_glibc/libc.map =
-Wl,-soname=3Dlibc.so.6  -nostdlib -nostartfiles -e __libc_main =
-L/workspace/ratin/make_glibc -L/workspace/ratin/make_glibc/math =
-L/workspace/ratin/make_glibc/elf -L/workspace/ratin/make_glibc/dlfcn =
-L/workspace/ratin/make_glibc/nss -L/workspace/ratin/make_glibc/nis =
-L/workspace/ratin/make_glibc/rt -L/workspace/ratin/make_glibc/resolv =
-L/workspace/ratin/make_glibc/crypt =
-L/workspace/ratin/make_glibc/linuxthreads =
-Wl,-rpath-link=3D/workspace/ratin/make_glibc:/workspace/ratin/make_glibc=
/math:/workspace/ratin/make_glibc/elf:/workspace/ratin/make_glibc/dlfcn:/=
workspace/ratin/make_glibc/nss:/workspace/ratin/make_glibc/nis:/workspace=
/ratin/make_glibc/rt:/workspace/ratin/make_glibc/resolv:/workspace/ratin/=
make_glibc/crypt:/workspace/ratin/make_glibc/linuxthreads -o =
/workspace/ratin/make_glibc/libc.so -T =
/workspace/ratin/make_glibc/shlib.lds =
/workspace/ratin/make_glibc/csu/abi-note.o =
/workspace/ratin/make_glibc/elf/soinit.os =
/workspace/ratin/make_glibc/libc_pic.os =
/workspace/ratin/make_glibc/elf/sofini.os =
/workspace/ratin/make_glibc/elf/interp.os =
/workspace/ratin/make_glibc/elf/ld.so -lgcc -lgcc_eh
/workspace/ratin/make_glibc/libc_pic.os: In function =
`__register_atfork':
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d088): undefined =
reference to `__fork_block'
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d0b4): undefined =
reference to `__fork_block'
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d0e0): undefined =
reference to `__fork_block'
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d148): undefined =
reference to `__fork_block'
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d164): undefined =
reference to `__fork_block'
/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d214): more undefined =
references to `__fork_block' follow
collect2: ld returned 1 exit status
make[1]: *** [/workspace/ratin/make_glibc/libc.so] Error 1
make[1]: Leaving directory `/workspace/ratin/glibc-2.3.3'
make: *** [all] Error 2

=20
=20
=20
I will appreciate any help if you could provide..
Thanks
=20
Ratin

------_=_NextPart_001_01C7B9EC.7441C459
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">=0A=
<TITLE>Re: gdbserver</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText96333 dir=3Dltr><FONT face=3DArial size=3D2>=0A=
<DIV><FONT face=3DArial color=3D#000000>In an effort to build gdbserver, =
I am trying =0A=
to upgrade my glibc and gcc&nbsp;cross compile tools. I am &nbsp;having =0A=
</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000>problem while bulding =
glibc-2.3.3, mipsel =0A=
compiler version 3.2.3 and current glibc ver</FONT></DIV>=0A=
<DIV><FONT face=3DArial>is 2.2.5. </FONT></DIV>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial>I exported all current cross tools and cross =
compiler with =0A=
export. </FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>configured with the options:</DIV>=0A=
<DIV>../glibc-2.3.3/configure --prefix=3D/opt/crosstool =
--build=3Di686-pc-linux-gnu =0A=
--host=3Dmipsel-linux --with-binutils=3D/opt/mipseltools/bin/ =0A=
--enable-add-ons=3Dlinuxthreads</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>did a make and after make went thru&nbsp;for 5&nbsp;mins or so, it =
threw =0A=
this error message: </DIV>=0A=
<DIV><FONT face=3DArial>I get the following error:</FONT></DIV>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial>&nbsp;-Wl,-d -Wl,--whole-archive =0A=
/workspace/ratin/make_glibc/libc_pic.a<BR>/opt/mipseltools/bin/mipsel-lin=
ux-gcc =0A=
-mabi=3D32&nbsp;&nbsp; -shared -Wl,-O1 \<BR>&nbsp; -nostdlib =
-nostartfiles =0A=
\<BR>&nbsp;&nbsp; -Wl,-dynamic-linker=3D/opt/crosstool/lib/ld.so.1&nbsp; =0A=
\<BR>&nbsp; -Wl,--verbose 2&gt;&amp;1 | \<BR>&nbsp; sed &gt; =0A=
/workspace/ratin/make_glibc/shlib.ldsT =
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -e =0A=
'/^=3D=3D=3D=3D=3D=3D=3D=3D=3D/,/^=3D=3D=3D=3D=3D=3D=3D=3D=3D/!d;/^=3D=3D=
=3D=3D=3D=3D=3D=3D=3D/d' \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
-e 's/^.*\.hash[&nbsp; ]*:.*$/&nbsp; .note.ABI-tag : { *(.note.ABI-tag) =
} =0A=
&amp;/' \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -e =
's/^.*\*(\.dynbss).*$/&amp; =0A=
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
PROVIDE(__start___libc_freeres_ptrs =3D .); =0A=
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*(__libc_freeres_ptrs) =0A=
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
PROVIDE(__stop___libc_freeres_ptrs =3D .);/'<BR>mv -f =0A=
/workspace/ratin/make_glibc/shlib.ldsT =0A=
/workspace/ratin/make_glibc/shlib.lds<BR>/opt/mipseltools/bin/mipsel-linu=
x-gcc =0A=
-mabi=3D32&nbsp;&nbsp; -shared -static-libgcc -Wl,-O1&nbsp; -Wl,-z,defs =0A=
-Wl,-dynamic-linker=3D/opt/crosstool/lib/ld.so.1&nbsp; =0A=
-B/workspace/ratin/make_glibc/csu/&nbsp; =0A=
-Wl,--version-script=3D/workspace/ratin/make_glibc/libc.map =0A=
-Wl,-soname=3Dlibc.so.6&nbsp; -nostdlib -nostartfiles -e __libc_main =0A=
-L/workspace/ratin/make_glibc -L/workspace/ratin/make_glibc/math =0A=
-L/workspace/ratin/make_glibc/elf -L/workspace/ratin/make_glibc/dlfcn =0A=
-L/workspace/ratin/make_glibc/nss -L/workspace/ratin/make_glibc/nis =0A=
-L/workspace/ratin/make_glibc/rt -L/workspace/ratin/make_glibc/resolv =0A=
-L/workspace/ratin/make_glibc/crypt =
-L/workspace/ratin/make_glibc/linuxthreads =0A=
-Wl,-rpath-link=3D/workspace/ratin/make_glibc:/workspace/ratin/make_glibc=
/math:/workspace/ratin/make_glibc/elf:/workspace/ratin/make_glibc/dlfcn:/=
workspace/ratin/make_glibc/nss:/workspace/ratin/make_glibc/nis:/workspace=
/ratin/make_glibc/rt:/workspace/ratin/make_glibc/resolv:/workspace/ratin/=
make_glibc/crypt:/workspace/ratin/make_glibc/linuxthreads =0A=
-o /workspace/ratin/make_glibc/libc.so -T =
/workspace/ratin/make_glibc/shlib.lds =0A=
/workspace/ratin/make_glibc/csu/abi-note.o =0A=
/workspace/ratin/make_glibc/elf/soinit.os =0A=
/workspace/ratin/make_glibc/libc_pic.os =0A=
/workspace/ratin/make_glibc/elf/sofini.os =0A=
/workspace/ratin/make_glibc/elf/interp.os =
/workspace/ratin/make_glibc/elf/ld.so =0A=
-lgcc -lgcc_eh<BR>/workspace/ratin/make_glibc/libc_pic.os: In function =0A=
`__register_atfork':<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x1=
0d088): =0A=
undefined reference to =0A=
`__fork_block'<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d0b4)=
: =0A=
undefined reference to =0A=
`__fork_block'<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d0e0)=
: =0A=
undefined reference to =0A=
`__fork_block'<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d148)=
: =0A=
undefined reference to =0A=
`__fork_block'<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d164)=
: =0A=
undefined reference to =0A=
`__fork_block'<BR>/workspace/ratin/make_glibc/libc_pic.os(.text+0x10d214)=
: more =0A=
undefined references to `__fork_block' follow<BR>collect2: ld returned 1 =
exit =0A=
status<BR>make[1]: *** [/workspace/ratin/make_glibc/libc.so] Error =
1<BR>make[1]: =0A=
Leaving directory `/workspace/ratin/glibc-2.3.3'<BR>make: *** [all] =
Error =0A=
2<BR></DIV></FONT>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial>I will appreciate any help if you could =0A=
provide..</FONT></DIV>=0A=
<DIV><FONT face=3DArial>Thanks</FONT></DIV>=0A=
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial>Ratin</FONT></DIV></FONT></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C7B9EC.7441C459--
