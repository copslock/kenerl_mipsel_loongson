Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2003 09:00:48 +0000 (GMT)
Received: from [IPv6:::ffff:203.199.202.17] ([IPv6:::ffff:203.199.202.17]:10756
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225310AbTKPJAh>; Sun, 16 Nov 2003 09:00:37 +0000
Received: from DURAI ([192.168.0.180])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id hAG8xbn26374
	for <linux-mips@linux-mips.org>; Sun, 16 Nov 2003 14:29:37 +0530
Message-ID: <007801c3ac20$070adff0$0205a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: <linux-mips@linux-mips.org>
References: <92F2591F460F684C9C309EB0D33256FA01B750B8@trid-mail1.tridentmicro.com> <20031115125329.GA324@linux-mips.org>
Subject: file handling in kernel mode
Date: Sun, 16 Nov 2003 14:30:05 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0075_01C3AC4E.20B73510"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: Found to be clean
Return-Path: <durai@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: durai@isofttech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0075_01C3AC4E.20B73510
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
I need to read a file from a device driver and i wrote a sample driver =
like this

This kernel mode code which try to read the file until end of file is =
reached. This code had been is working without any problems in RedHat =
linux and uClinux.
But the same code causes a General Protection Fault in my mips linux. I =
tested the same code in mips running on uClinux which runs well.
what is wrong with mips linux?

#define __KERNEL_SYSCALLS__

#include <linux/version.h>
#ifdef MODULE
#ifdef MODVERSIONS
#include <linux/modversions.h>
#endif
#include <linux/module.h>
#else
#define MOD_INC_USE_COUNT
#define MOD_DEC_USE_COUNT
#endif

#include <linux/types.h>
#include <linux/unistd.h>
#include <linux/delay.h>
#include <asm/uaccess.h>
#include <asm/io.h>
int test_open(void );
int init_module(void)
{
        printk("\n init_module ");
        test_open();
        return 0;
}
void cleanup_module(void)
{
        printk("\n cleanup module");
}

int test_open(void )
{
    int ifp,bcount;
    mm_segment_t fs;
    char buffer[0x1000];

    // for file opening temporarily tell the kernel I am not a user for
    // memory management segment access
    fs =3D get_fs();
    set_fs(KERNEL_DS);
    // open the file with the firmware for uploading
    if (ifp =3D open( "/etc/hotplug/isl3890.arm", O_RDONLY, 0 ), ifp < =
0)
    {
        // error opening the file
        printk( "ERROR: File opening did not success \n");
        set_fs(fs);
        return -1;
    }
    // enter a loop which reads data blocks from the file and writes =
them
    // to the Direct Memory Windows
    do
    {
            bcount =3D read(ifp, &buffer, sizeof(buffer));
            printk("\n bcount %x ",bcount);
    }
    while (bcount !=3D 0);
    close(ifp);
    // switch back the segment setting
    set_fs(fs);

    return 0;
}



thanks & regards
durai
------=_NextPart_000_0075_01C3AC4E.20B73510
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I need to read a file from a device =
driver and i=20
wrote a sample driver like this</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>This kernel mode code which try to read =
the file=20
until end of file is reached. This code had been is working without any =
problems=20
in RedHat linux and uClinux.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But the same code causes a General =
Protection Fault=20
in my mips linux. I tested the same code in mips running on uClinux =
which runs=20
well.</FONT></DIV></DIV>
<DIV><FONT face=3DArial size=3D2>what is wrong with mips =
linux?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>#define=20
__KERNEL_SYSCALLS__</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>#include=20
&lt;linux/version.h&gt;<BR>#ifdef MODULE<BR>#ifdef =
MODVERSIONS<BR>#include=20
&lt;linux/modversions.h&gt;<BR>#endif<BR>#include=20
&lt;linux/module.h&gt;<BR>#else<BR>#define MOD_INC_USE_COUNT<BR>#define=20
MOD_DEC_USE_COUNT<BR>#endif</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>#include=20
&lt;linux/types.h&gt;<BR>#include &lt;linux/unistd.h&gt;<BR>#include=20
&lt;linux/delay.h&gt;<BR>#include &lt;asm/uaccess.h&gt;<BR>#include=20
&lt;asm/io.h&gt;<BR>int test_open(void );<BR>int=20
init_module(void)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printk("\n=20
init_module ");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
test_open();<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
0;<BR>}<BR>void=20
cleanup_module(void)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("\n cleanup module");<BR>}<BR></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>int test_open(void=20
)<BR>{<BR>&nbsp;&nbsp;&nbsp; int ifp,bcount;<BR>&nbsp;&nbsp;&nbsp; =
mm_segment_t=20
fs;<BR>&nbsp;&nbsp;&nbsp; char buffer[0x1000];</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>&nbsp;&nbsp;&nbsp; // =
for file=20
opening temporarily tell the kernel I am not a user =
for<BR>&nbsp;&nbsp;&nbsp; //=20
memory management segment access<BR>&nbsp;&nbsp;&nbsp; fs =3D=20
get_fs();<BR>&nbsp;&nbsp;&nbsp; set_fs(KERNEL_DS);<BR>&nbsp;&nbsp;&nbsp; =
// open=20
the file with the firmware for uploading<BR>&nbsp;&nbsp;&nbsp; if (ifp =
=3D open(=20
"/etc/hotplug/isl3890.arm", O_RDONLY, 0 ), ifp &lt; =
0)<BR>&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // error opening the=20
file<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk( "ERROR: File =
opening=20
did not success \n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
set_fs(fs);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
-1;<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp;<FONT color=3D#ff0000> =
// enter a=20
loop which reads data blocks from the file and writes =
them<BR>&nbsp;&nbsp;&nbsp;=20
// to the Direct Memory Windows<BR>&nbsp;&nbsp;&nbsp; =
do<BR>&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bcount =3D=20
read(ifp, &amp;buffer,=20
sizeof(buffer));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
printk("\n bcount %x ",bcount);<BR>&nbsp;&nbsp;&nbsp;=20
}<BR></FONT>&nbsp;&nbsp;&nbsp; while (bcount !=3D =
0);<BR>&nbsp;&nbsp;&nbsp;=20
close(ifp);<BR>&nbsp;&nbsp;&nbsp; // switch back the segment=20
setting<BR>&nbsp;&nbsp;&nbsp; set_fs(fs);</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>&nbsp;&nbsp;&nbsp; =
return=20
0;<BR>}<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>thanks &amp; regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>durai</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0075_01C3AC4E.20B73510--
