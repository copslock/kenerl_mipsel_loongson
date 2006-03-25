Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Mar 2006 09:12:18 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.196]:46505 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133409AbWCYJMG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Mar 2006 09:12:06 +0000
Received: by zproxy.gmail.com with SMTP id 14so1051890nzn
        for <linux-mips@linux-mips.org>; Sat, 25 Mar 2006 01:22:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=kgsFcV303KiL6b1gL8NzxxVpr5NbEl7Y3umINT2RciodSjh1E3Nsv7n4khNup2giNEKjXUClIYLmCH9u2nIhzU+8GoMCCvw9kFUMqEDqhTzI18TRWOqE2B0sNuBSRWh8s7kmE/nfIMqLyzboQye3qPFRV+5QtsjWAw9TjKOkJ5w=
Received: by 10.36.49.6 with SMTP id w6mr2395402nzw;
        Sat, 25 Mar 2006 01:22:13 -0800 (PST)
Received: by 10.36.49.7 with HTTP; Sat, 25 Mar 2006 01:22:13 -0800 (PST)
Message-ID: <f07e6e0603250122t6328c09coe37141d14396dc12@mail.gmail.com>
Date:	Sat, 25 Mar 2006 15:22:13 +0600
From:	"Kishore K" <hellokishore@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: 2.6.14 - problem with malta
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20060324165518.GA16567@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16593_24122964.1143278533541"
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com>
	 <20060324165518.GA16567@linux-mips.org>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_16593_24122964.1143278533541
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/24/06, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Fri, Mar 24, 2006 at 08:06:43PM +0530, Kishore K wrote:
>
> > hi
> > I am trying to bring up the malta board (MIPS 4kec), using the 2.6.14ke=
rnel
> > downloaded from linux-mips. The kernel is built with malta_defconfig
> located
> > in arch/mips/configs. After loading this kernel, board halts after
> printing
> > "Linux Started
> > Config serial console: console=3DttyS0, 38400n8r"
> >
> > Kernel is built with the tool chain based on gcc 3.3.6, binutils
> 2.14.90.0.8
> > .
>
> Note I generally don't test with HJ.Lu's toolchain at all.  It may be
> broken for MIPS, I don't know.  Also due to known bugs in older toolchain=
s
> the minimal requirement is binutils 2.16; the vanilla FSF version from
> ftp.gnu.org will do.
>
> (2.15 will core dump for some configurations but if it doesn't die, it
> seems
> to do just fine)


Thanks for the reply. I observed the same problem  even when compiled with
tool chain based on gcc 3.4.4 binutils 2.15.97 and uclibc- 0.9.27. I 'll tr=
y
with binutils 2.16. Please note that my malta is based on 4kc but not 4kec.

> Could any one tell me what the problem is .
>
> Let's see.  What CPU card are you using on your Malta?  And if it's an
> FPGA card, what bitfile is loaded?  Yamon will print information on the
> CPU after powerup or reset.
>
>   Ralf
>

Here are the details of my malta board.

Board type/revision =3D           0x02 (Malta) / 0x00
Core board type/revision =3D      0x01 (CoreLV) / 0x01
FPGA revision =3D                 0x0001
MAC address =3D                   00.d0.a0.00.03.22
Board S/N =3D                     0000000554
PCI bus frequency =3D             33.33 MHz
Processor Company ID/options =3D  0x01 (MIPS Technologies, Inc.) / 0x00
Processor ID/revision =3D         0x80 (MIPS 4Kc) / 0x05
Endianness =3D                    Big
CPU/Bus frequency =3D             125 MHz / 63 MHz
Flash memory size =3D             4 MByte
SDRAM size =3D                    64 MByte
First free SDRAM address =3D      0x8009e380

thanks,
--kishore

------=_Part_16593_24122964.1143278533541
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/24/06, <b class=3D"gmail_sendername">Ralf Baechle</b> &lt;<a href=3D"m=
ailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:<div><span cla=
ss=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">
On Fri, Mar 24, 2006 at 08:06:43PM +0530, Kishore K wrote:<br><br>&gt; hi<b=
r>&gt; I am trying to bring up the malta board (MIPS 4kec), using the 2.6.1=
4 kernel<br>&gt; downloaded from linux-mips. The kernel is built with malta=
_defconfig located
<br>&gt; in arch/mips/configs. After loading this kernel, board halts after=
 printing<br>&gt; &quot;Linux Started<br>&gt; Config serial console: consol=
e=3DttyS0, 38400n8r&quot;<br>&gt;<br>&gt; Kernel is built with the tool cha=
in based on gcc=20
3.3.6, binutils 2.14.90.0.8<br>&gt; .<br><br>Note I generally don't test wi=
th HJ.Lu's toolchain at all.&nbsp;&nbsp;It may be<br>broken for MIPS, I don=
't know.&nbsp;&nbsp;Also due to known bugs in older toolchains<br>the minim=
al requirement is binutils=20
2.16; the vanilla FSF version from<br><a href=3D"http://ftp.gnu.org">ftp.gn=
u.org</a> will do.<br><br>(2.15 will core dump for some configurations but =
if it doesn't die, it seems<br>to do just fine)</blockquote><div><br>
Thanks for the reply. I observed the same problem&nbsp; even when
compiled with tool chain based on gcc 3.4.4 binutils 2.15.97 and
uclibc- 0.9.27. I 'll try with binutils 2.16. Please note that my malta
is based on 4kc but not 4kec.<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Co=
uld any one tell me what the problem is .<br><br>Let's see.&nbsp;&nbsp;What=
 CPU card are you using on your Malta?&nbsp;&nbsp;And if it's an
<br>FPGA card, what bitfile is loaded?&nbsp;&nbsp;Yamon will print informat=
ion on the<br>CPU after powerup or reset.<br><br>&nbsp;&nbsp;Ralf<br></bloc=
kquote></div><br>
Here are the details of my malta board.<br>
<br>
Board type/revision =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x02 (Malta) / 0x00<br>
Core board type/revision =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01 (CoreLV) / =
0x01<br>
FPGA revision =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001<br>
MAC address
=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00.d0.a0.00.03.22<br>
Board S/N
=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0000000554<br>
PCI bus frequency =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 33.33 MHz<br>
Processor Company ID/options =3D&nbsp; 0x01 (MIPS Technologies, Inc.) / 0x0=
0<br>
Processor ID/revision =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x80 (MIPS 4Kc) / 0x05<br>
Endianness
=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Big<br>
CPU/Bus frequency =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 125 MHz / 63 MHz<br>
Flash memory size =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 4 MByte<br>
SDRAM size
=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
64 MByte<br>
First free SDRAM address =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8009e380<br>
<br>
thanks,<br>
--kishore<br>
<br>

------=_Part_16593_24122964.1143278533541--
