Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 06:51:49 +0100 (BST)
Received: from smtp127.iad.emailsrvr.com ([207.97.245.127]:8676 "HELO
	smtp127.iad.emailsrvr.com") by ftp.linux-mips.org with SMTP
	id S20023223AbYE1Fvr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 06:51:47 +0100
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 617DB44C160;
	Wed, 28 May 2008 01:51:39 -0400 (EDT)
Received: from vaultinfo.com (webmail15.webmail.iad.mlsrvr.com [192.168.1.39])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 5AC0A44C030;
	Wed, 28 May 2008 01:51:39 -0400 (EDT)
Received: by webmail.mailsin.net
    (Authenticated sender: abhiruchi.g@vaultinfo.com, from: abhiruchi.g@vaultinfo.com) 
    with HTTP; Wed, 28 May 2008 01:51:39 -0400 (EDT)
Date:	Wed, 28 May 2008 01:51:39 -0400 (EDT)
Subject: Re: MIPS kernel hangs: Warning: unable to open an initial console. /sbin/init
From:	abhiruchi.g@vaultinfo.com
To:	"Jun Ma" <sync.jma@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Reply-To: abhiruchi.g@vaultinfo.com
MIME-Version: 1.0
Content-Type: multipart/alternative;boundary="----=_20080528015139_72659"
Importance: Normal
X-Priority: 3 (Normal)
X-Type:	2
Message-ID: <57994.192.168.1.70.1211953899.webmail@192.168.1.70>
X-Mailer: webmail6.6.1
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

------=_20080528015139_72659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=0AHi,=0AI already added   "console=3DttyS0,115200" to the kernel command l=
ine.=0AActually problem was with /sbin/init .=0AThat got resolved.=0A=0ATha=
nks for the reply.=0A=0A-----Original Message-----=0AFrom: Jun Ma <sync.jma=
@gmail.com>=0ASent: Tuesday, May 27, 2008 11:15pm=0ATo: Manuel Lauss <mano@=
roarinelk.homelinux.net>=0ACc: abhiruchi.g@vaultinfo.com, linux-kernel@vger=
.kernel.org, linux-mips@linux-mips.org <linux-mips@linux-mips.org>, kernel-=
testers <kernel-testers@vger.kernel.org>=0ASubject: Re: MIPS kernel hangs: =
Warning: unable to open an initial console. /sbin/init=0A=0AOn Thu, May 15,=
 2008 at 9:38 PM, Manuel Lauss=0A wrote:=0A> On Thu, May 15, 2008 at 08:55:=
39AM -0400, abhiruchi.g@vaultinfo.com wrote:=0A>> Hi,=0A>>=0A>> My kernel h=
angs by initializing the system. My target is Alchemy DB1200. I use crossto=
ol-ng to build MIPS cross toolchain and ptxdist to build ext2 filesystem.=
=0A>> kernel version:linux-2.6.22=0A>=0A> Try and add "console=3DttyS0,1152=
00" to the kernel commandline (either in=0A> yamon or kernel config).=0A>=
=0A>=0A=0AAnd you must have a tty node in your /dev directory, e.g. /dev/tt=
yS0=0A=0A=0A-- =0AFIXME if it is wrong.=0A--=0ATo unsubscribe from this lis=
t: send the line "unsubscribe linux-kernel" in=0Athe body of a message to m=
ajordomo@vger.kernel.org=0AMore majordomo info at  http://vger.kernel.org/m=
ajordomo-info.html=0APlease read the FAQ at  http://www.tux.org/lkml/=0A
------=_20080528015139_72659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2"><br>Hi,<br>I already added&nbsp;  "console=
=3DttyS0,115200" to the kernel command line.<br>Actually problem was with /=
sbin/init .<br>That got resolved.<br><br>Thanks for the reply.<br><br>-----=
Original Message-----<br>From: Jun Ma &lt;sync.jma@gmail.com&gt;<br>Sent: T=
uesday, May 27, 2008 11:15pm<br>To: Manuel Lauss &lt;mano@roarinelk.homelin=
ux.net&gt;<br>Cc: abhiruchi.g@vaultinfo.com, linux-kernel@vger.kernel.org, =
linux-mips@linux-mips.org &lt;linux-mips@linux-mips.org&gt;, kernel-testers=
 &lt;kernel-testers@vger.kernel.org&gt;<br>Subject: Re: MIPS kernel hangs: =
Warning: unable to open an initial console. /sbin/init<br><br>On Thu, May 1=
5, 2008 at 9:38 PM, Manuel Lauss<br><mano@roarinelk.homelinux.net> wrote:<b=
r>&gt; On Thu, May 15, 2008 at 08:55:39AM -0400, abhiruchi.g@vaultinfo.com =
wrote:<br>&gt;&gt; Hi,<br>&gt;&gt;<br>&gt;&gt; My kernel hangs by initializ=
ing the system. My target is Alchemy DB1200. I use crosstool-ng to build MI=
PS cross toolchain and ptxdist to build ext2 filesystem.<br>&gt;&gt; kernel=
 version:linux-2.6.22<br>&gt;<br>&gt; Try and add "console=3DttyS0,115200" =
to the kernel commandline (either in<br>&gt; yamon or kernel config).<br>&g=
t;<br>&gt;<br><br>And you must have a tty node in your /dev directory, e.g.=
 /dev/ttyS0<br><br><br>-- <br>FIXME if it is wrong.<br>--<br>To unsubscribe=
 from this list: send the line "unsubscribe linux-kernel" in<br>the body of=
 a message to majordomo@vger.kernel.org<br>More majordomo info at  http://v=
ger.kernel.org/majordomo-info.html<br>Please read the FAQ at  http://www.tu=
x.org/lkml/<br></mano@roarinelk.homelinux.net></font>
------=_20080528015139_72659--
