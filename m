Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Feb 2008 11:15:23 +0000 (GMT)
Received: from f4mail208.rediffmail.com ([202.137.234.208]:20402 "HELO
	rediffmail.com") by ftp.linux-mips.org with SMTP id S28587549AbYB0LPU
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Feb 2008 11:15:20 +0000
Received: (qmail 30957 invoked by uid 510); 27 Feb 2008 11:12:11 -0000
Date:	27 Feb 2008 11:12:11 -0000
MIME-Version: 1.0
To:	<linux-mips@linux-mips.org>
Received: from unknown 203.126.136.223 by rediffmail.com via HTTP; 27 Feb 2008 11:12:06 -0000
Message-ID: <1204110817.22.autosave.old.1204110726.15833@webmail.rediffmail.com>
Subject: Need help in setting up remote debugging setup for MIPS.
From:	"Sudhindra " <smsudhee@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_290e7cbe630acb0c390eb4709e907944"
Return-Path: <smsudhee@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smsudhee@rediffmail.com
Precedence: bulk
X-list: linux-mips

--=_290e7cbe630acb0c390eb4709e907944
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi, I have been trying to setup a remote debugger GDB for a MIPS platform.Tried to install the gdb with the information that I could gather on net.I downloaded gdb-6.7.1 from net. Have kept all these file on a Linux PC.following are the steps I followd.1.[root@ads
target]#&nbsp; /root/GDB761/gdb-6.7.1/configure
--target=mips-montavista-linux-gnu --host=i686-pc-linux-gnu
--prefix=/opt/gdb2.&nbsp; [root@ads target]# make3.[root@ads target]# make installHaving done these, I was not able to find the gdbserver executable in /opt/gdb.Thus I tried configuring the gdbserver explicitely.i.e:[root@ads
target]#&nbsp; /root/GDB761/gdb-6.7.1/gdb/gdbserver/configure
--target=--target=mips-montavista-linux-gnu --host=i686-pc-linux-gnu
--prefix=/opt/gdbthen I did make[root@ads target]# makethis make resuts into number of errors like-mips-linux.c updated./root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `MMLO' undeclaredhere (not in a function)/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: initializer elementis not constant/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: (near initializationfor `mips_regmap[33]')/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `MMHI' undeclaredhere (not in a function)/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: initializer elementis not constant/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: (near initializationfor `mips_regmap[34]')/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `BADVADDR'Am I missing out any step here??Please help me out in finding the right way to install gdb.Thanks and regards,Sudhindra

--=_290e7cbe630acb0c390eb4709e907944
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, <br /><br />I have been trying to setup a remote debugger GDB for a MIP=
S platform.<br />Tried to install the gdb with the information that I could=
 gather on net.<br /><br />I downloaded gdb-6.7.1 from net. Have kept all t=
hese file on a Linux PC.<br /><br />following are the steps I followd.<br /=
><br />1.<br /><br /><span style=3D"color: rgb(255, 102, 102);">[root@ads
target]#&nbsp; /root/GDB761/gdb-6.7.1/configure
--target=3Dmips-montavista-linux-gnu --host=3Di686-pc-linux-gnu
--prefix=3D/opt/gdb</span><br /><br />2.&nbsp; <br /><span style=3D"color: =
rgb(255, 102, 102);">[root@ads target]# make</span><br /><br />3.<br /><spa=
n style=3D"color: rgb(255, 102, 102);">[root@ads target]# make install</spa=
n><br /><br />Having done these, I was not able to find the gdbserver execu=
table in /opt/gdb.<br /><br />Thus I tried configuring the gdbserver explic=
itely.<br />i.e:<br /><span style=3D"color: rgb(255, 102, 102);">[root@ads
target]#&nbsp; /root/GDB761/gdb-6.7.1/gdb/gdbserver/configure
--target=3D--target=3Dmips-montavista-linux-gnu --host=3Di686-pc-linux-gnu
--prefix=3D/opt/gdb</span><br style=3D"color: rgb(255, 102, 102);" /><br />=
then I did make<br /><span style=3D"color: rgb(255, 102, 102);">[root@ads t=
arget]# make</span><br /><br />this make resuts into number of errors like-=
<br /><span style=3D"color: rgb(51, 51, 255);">mips-linux.c updated.</span>=
<br style=3D"color: rgb(51, 51, 255);" /><span style=3D"color: rgb(51, 51, =
255);">/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `MMLO' und=
eclared</span><br style=3D"color: rgb(51, 51, 255);" /><span style=3D"color=
: rgb(51, 51, 255);">here (not in a function)</span><br style=3D"color: rgb=
(51, 51, 255);" /><span style=3D"color: rgb(51, 51, 255);">/root/GDB761/gdb=
-6.7.1/gdb/gdbserver/linux-mips-low.c:57: initializer element</span><br sty=
le=3D"color: rgb(51, 51, 255);" /><span style=3D"color: rgb(51, 51, 255);">=
is not constant</span><br style=3D"color: rgb(51, 51, 255);" /><span style=
=3D"color: rgb(51, 51, 255);">/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mi=
ps-low.c:57: (near initialization</span><br style=3D"color: rgb(51, 51, 255=
);" /><span style=3D"color: rgb(51, 51, 255);">for `mips_regmap[33]')</span=
><br style=3D"color: rgb(51, 51, 255);" /><span style=3D"color: rgb(51, 51,=
 255);">/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `MMHI' un=
declared</span><br style=3D"color: rgb(51, 51, 255);" /><span style=3D"colo=
r: rgb(51, 51, 255);">here (not in a function)</span><br style=3D"color: rg=
b(51, 51, 255);" /><span style=3D"color: rgb(51, 51, 255);">/root/GDB761/gd=
b-6.7.1/gdb/gdbserver/linux-mips-low.c:57: initializer element</span><br st=
yle=3D"color: rgb(51, 51, 255);" /><span style=3D"color: rgb(51, 51, 255);"=
>is not constant</span><br style=3D"color: rgb(51, 51, 255);" /><span style=
=3D"color: rgb(51, 51, 255);">/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mi=
ps-low.c:57: (near initialization</span><br style=3D"color: rgb(51, 51, 255=
);" /><span style=3D"color: rgb(51, 51, 255);">for `mips_regmap[34]')</span=
><br style=3D"color: rgb(51, 51, 255);" /><span style=3D"color: rgb(51, 51,=
 255);">/root/GDB761/gdb-6.7.1/gdb/gdbserver/linux-mips-low.c:57: `BADVADDR=
'</span><br style=3D"color: rgb(51, 51, 255);" /><br />Am I missing out any=
 step here??<br />Please help me out in finding the right way to install gd=
b.<br /><br /><br />Thanks and regards,<br />Sudhindra
<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D'font-family:Verdana;font-size:11px;line-height:15px;'><TR><td=
><a href=3D'http://adworks.rediff.com/cgi-bin/AdWorks/click.cgi/www.rediff.=
com/signature-home.htm/1050715198@Middle5/2031830_2024620/2031710/1?PARTNER=
=3D3&OAS_QUERY=3Dnull' target=3Dnew ><img src =3D'http://imadworks.rediff.c=
om/cgi-bin/AdWorks/adimage.cgi/2031830_2024620/creative_2031710.gif'  alt=
=3D'Jeevan Sathi'  border=3D0></a></td></TR></Table>
--=_290e7cbe630acb0c390eb4709e907944--
