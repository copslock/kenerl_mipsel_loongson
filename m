Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7VAMU814985
	for linux-mips-outgoing; Fri, 31 Aug 2001 03:22:30 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7VAMKd14980
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 03:22:20 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f7VCo4W05149
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 20:50:04 +0800
Message-ID: <02b801c13203$f52ad440$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
Subject: compile C++ code
Date: Fri, 31 Aug 2001 18:01:51 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02B5_01C13247.03141880"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_02B5_01C13247.03141880
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi all,

My host is x86 with redhat 7.0 and install the mips cross-compiler:
1.binutils-mips-linux-2.8.1-2.i386.rpm
2.egcs-mips-linux-1.1.2-3.i386.rpm
3.egcs-c++-mips-linux-1.1.2-4.i386.rpm
4.libc-2.0.6
5.egcs-libstdc++-mips-linux-2.9.0-4.i386.rpm
But when i compile the following C++ code, something wrong!

#include <stdio.h>
class A {
public:
        A();
        virtual void hello();        // with virtual is failed, without =
virtual is ok.
};
A::A() {printf("A construction!\n");}
void A::hello() { printf("hello\n"); }
main()
{
        A *exam;
        exam->hello();
}

#mips-linux-gcc test.C
/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/libgcc.a(frame.o): In function =
`decode_uleb128':
/usr/src/redhat/BUILD/egcs-1.1.2/target-mips-linux/gcc/../../gcc/frame.c(=
.data+0x0): undefined reference to `pthread_create'
/usr/mips-linux/bin/ld: bfd assertion fail ../../bfd/elf32-mips.c:5123
mips-linux-gcc: Internal compiler error: program ld got fatal signal 11
#mips-linux-g++ test.C
/usr/mips-linux/lib/libstdc++.so: undefined reference to =
`pthread_create'
/usr/mips-linux/lib/libstdc++.so: undefined reference to =
`pthread_getspecific'
/usr/mips-linux/lib/libstdc++.so: undefined reference to `pthread_once'
/usr/mips-linux/lib/libstdc++.so: undefined reference to =
`pthread_key_create'
/usr/mips-linux/lib/libstdc++.so: undefined reference to =
`pthread_setspecific'

If the "virtual" is not used, "virtual void hello();" to "void =
hello();", mips-linux-gcc compiling is fine but mips-linux-g++ compiling =
is still the same error.
What is going on?
Is it the problem of compiler or library?
How should i do?

Thanks in advance!
KJ



------=_NextPart_000_02B5_01C13247.03141880
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi all,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>My host is x86 with redhat 7.0 and install =
the&nbsp;mips=20
cross-compiler:</FONT></DIV>
<DIV><FONT size=3D2>1.binutils-mips-linux-2.8.1-2.i386.rpm</FONT></DIV>
<DIV><FONT size=3D2>2.egcs-mips-linux-1.1.2-3.i386.rpm</FONT></DIV>
<DIV><FONT size=3D2>3.egcs-c++-mips-linux-1.1.2-4.i386.rpm</FONT></DIV>
<DIV><FONT size=3D2>4.libc-2.0.6</FONT></DIV>
<DIV><FONT =
size=3D2>5.egcs-libstdc++-mips-linux-2.9.0-4.i386.rpm</FONT></DIV>
<DIV><FONT size=3D2>But when i compile the following C++ code, something =

wrong!</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>#include &lt;stdio.h&gt;</FONT></DIV>
<DIV><FONT size=3D2>class A=20
{<BR>public:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
A();<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual void=20
hello();&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // with virtual is failed, =
without=20
virtual is ok.<BR>};<BR>A::A() {printf("A construction!\n");}<BR>void =
A::hello()=20
{ printf("hello\n");=20
}<BR>main()<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=20
*exam;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
exam-&gt;hello();<BR>}<BR></FONT></DIV>
<DIV><FONT size=3D2>#mips-linux-gcc test.C</FONT></DIV>
<DIV><FONT =
size=3D2>/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/libgcc.a(frame.o): In=20
function=20
`decode_uleb128':<BR>/usr/src/redhat/BUILD/egcs-1.1.2/target-mips-linux/g=
cc/../../gcc/frame.c(.data+0x0):=20
undefined reference to `pthread_create'<BR>/usr/mips-linux/bin/ld: bfd =
assertion=20
fail ../../bfd/elf32-mips.c:5123<BR>mips-linux-gcc: Internal compiler =
error:=20
program ld got fatal signal 11</FONT></DIV>
<DIV><FONT size=3D2>#mips-linux-g++ test.C</FONT></DIV>
<DIV><FONT size=3D2>/usr/mips-linux/lib/libstdc++.so: undefined =
reference to=20
`pthread_create'<BR>/usr/mips-linux/lib/libstdc++.so: undefined =
reference to=20
`pthread_getspecific'<BR>/usr/mips-linux/lib/libstdc++.so: undefined =
reference=20
to `pthread_once'<BR>/usr/mips-linux/lib/libstdc++.so: undefined =
reference to=20
`pthread_key_create'<BR>/usr/mips-linux/lib/libstdc++.so: undefined =
reference to=20
`pthread_setspecific'<BR></FONT></DIV>
<DIV><FONT size=3D2>If the "virtual" is not used, "virtual void =
hello();" to "void=20
hello();", mips-linux-gcc compiling is&nbsp;fine&nbsp;but mips-linux-g++ =

compiling is still the same error.</FONT></DIV>
<DIV><FONT size=3D2>What is going on?</FONT></DIV>
<DIV><FONT size=3D2>Is it the problem of compiler or =
library?</FONT></DIV>
<DIV><FONT size=3D2>How should i do?</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Thanks in advance!</FONT></DIV>
<DIV><FONT size=3D2>KJ<BR></FONT></DIV>
<DIV><FONT size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_02B5_01C13247.03141880--
