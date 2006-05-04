Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 15:30:22 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.194]:13759 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133772AbWEDOaL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 15:30:11 +0100
Received: by nz-out-0102.google.com with SMTP id z6so462226nzd
        for <linux-mips@linux-mips.org>; Thu, 04 May 2006 07:30:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UAS32J/0q4ZaLRcZ7gMQYK/8DYf+ODVc/SAyD+Ljkw0xT2NZyFqw/RJuoJnjxu8Y9FiPdxwRMjdYl6+m9lyiu0R8bMOeox7krtZ95XmsGTV9NrOC3RloDs81p1Ah53WueBwqSB1u5Ar0DyDryCSE7+EDVs+0rdKYqYCovoXGw/s=
Received: by 10.36.121.12 with SMTP id t12mr627511nzc;
        Thu, 04 May 2006 07:30:04 -0700 (PDT)
Received: by 10.36.49.4 with HTTP; Thu, 4 May 2006 07:30:04 -0700 (PDT)
Message-ID: <f07e6e0605040730qfdd85b2o52fe1988f57e6775@mail.gmail.com>
Date:	Thu, 4 May 2006 20:00:04 +0530
From:	"Kishore K" <hellokishore@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Compilation problem with eepro100 in 2.6.16
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9997_33203890.1146753004401"
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_9997_33203890.1146753004401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi
2.6.16 kernel (from linux-mips) build is failing when enabled the support
for eepro100 ethernet driver (error is given below). But, I don't see the
same problem, if the kernel from kernel.org is used. I guess the problem is
due to the changes in the files arch/mips/lib/iomap.c and
include/asm-mips/io.h. In general, the problem is observed for all the
drivers which use ioread*, iowrite* calls.

I observe that changes are minimal between kernel.org and linux-mips
branches for 2.6.16. May, I know, what is the current procedure being
followed for taking the mips kernels? Is it from linux-mips or kernel.org ?
Could you please advise.


drivers/built-in.o(.text+0x27b8c): In function `do_slow_command':
: undefined reference to `ioread8'
drivers/built-in.o(.text+0x27bb4): In function `do_slow_command':
: undefined reference to `ioread8'
drivers/built-in.o(.text+0x27bd4): In function `do_slow_command':
: undefined reference to `iowrite8'
drivers/built-in.o(.text+0x27be4): In function `do_slow_command':
: undefined reference to `ioread8'
drivers/built-in.o(.text+0x27c08): In function `do_slow_command':
: undefined reference to `ioread8'
drivers/built-in.o(.text+0x27c44): In function `do_slow_command':
: undefined reference to `ioread32'
drivers/built-in.o(.text+0x27cb8): In function `mdio_read':
: undefined reference to `iowrite32'
drivers/built-in.o(.text+0x27cc0): In function `mdio_read':
: undefined reference to `ioread32'
drivers/built-in.o(.text+0x27d50): In function `mdio_write':
: undefined reference to `iowrite32'
drivers/built-in.o(.text+0x27d58): In function `mdio_write':
: undefined reference to `ioread32'
drivers/built-in.o(.text+0x27e48): In function `speedo_open':
: undefined reference to `iowrite16'
drivers/built-in.o(.text+0x27ed4): In function `speedo_open':
: undefined reference to `ioread16'
drivers/built-in.o(.text+0x27fbc): In function `speedo_resume':
: undefined reference to `ioread8'
drivers/built-in.o(.text+0x28008): In function `speedo_resume':
: undefined reference to `iowrite32'
drivers/built-in.o(.text+0x28038): In function `speedo_resume':
: undefined reference to `iowrite32'
drivers/built-in.o(.text+0x28040): In function `speedo_resume':
: undefined reference to `ioread32'
drivers/built-in.o(.text+0x28090): In function `speedo_resume':
: undefined reference to `iowrite32'
drivers/built-in.o(.text+0x28098): In function `speedo_resume':
: undefined reference to `ioread32'
drivers/built-in.o(.text+0x280a4): In function `speedo_resume':
: undefined reference to `iowrite8'
drivers/built-in.o(.text+0x280dc): In function `speedo_resume':

Thanks,
--kishore

------=_Part_9997_33203890.1146753004401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi<br>2.6.16 kernel (from linux-mips) build is failing when enabled the sup=
port for eepro100 ethernet driver (error is given below). But, I don't see =
the same problem, if the kernel from <a href=3D"http://kernel.org">kernel.o=
rg
</a> is used. I guess the problem is due to the changes in the files arch/m=
ips/lib/iomap.c and include/asm-mips/io.h. In general, the problem is obser=
ved for all the drivers which use ioread*, iowrite* calls.<br><br>I observe=
 that changes are minimal between=20
<a href=3D"http://kernel.org">kernel.org</a> and linux-mips branches for 2.=
6.16. May, I know, what is the current procedure being followed for taking =
the mips kernels? Is it from linux-mips or <a href=3D"http://kernel.org">ke=
rnel.org
</a> ?&nbsp; Could you please advise.<br><br><br>drivers/built-in.o(.text+0=
x27b8c): In function `do_slow_command':<br>: undefined reference to `ioread=
8'<br>drivers/built-in.o(.text+0x27bb4): In function `do_slow_command':<br>=
: undefined reference to `ioread8'
<br>drivers/built-in.o(.text+0x27bd4): In function `do_slow_command':<br>: =
undefined reference to `iowrite8'<br>drivers/built-in.o(.text+0x27be4): In =
function `do_slow_command':<br>: undefined reference to `ioread8'<br>driver=
s/built-
in.o(.text+0x27c08): In function `do_slow_command':<br>: undefined referenc=
e to `ioread8'<br>drivers/built-in.o(.text+0x27c44): In function `do_slow_c=
ommand':<br>: undefined reference to `ioread32'<br>drivers/built-in.o(.text=
+0x27cb8): In function `mdio_read':
<br>: undefined reference to `iowrite32'<br>drivers/built-in.o(.text+0x27cc=
0): In function `mdio_read':<br>: undefined reference to `ioread32'<br>driv=
ers/built-in.o(.text+0x27d50): In function `mdio_write':<br>: undefined ref=
erence to `iowrite32'
<br>drivers/built-in.o(.text+0x27d58): In function `mdio_write':<br>: undef=
ined reference to `ioread32'<br>drivers/built-in.o(.text+0x27e48): In funct=
ion `speedo_open':<br>: undefined reference to `iowrite16'<br>drivers/built=
-
in.o(.text+0x27ed4): In function `speedo_open':<br>: undefined reference to=
 `ioread16'<br>drivers/built-in.o(.text+0x27fbc): In function `speedo_resum=
e':<br>: undefined reference to `ioread8'<br>drivers/built-in.o(.text+0x280=
08): In function `speedo_resume':
<br>: undefined reference to `iowrite32'<br>drivers/built-in.o(.text+0x2803=
8): In function `speedo_resume':<br>: undefined reference to `iowrite32'<br=
>drivers/built-in.o(.text+0x28040): In function `speedo_resume':<br>: undef=
ined reference to `ioread32'
<br>drivers/built-in.o(.text+0x28090): In function `speedo_resume':<br>: un=
defined reference to `iowrite32'<br>drivers/built-in.o(.text+0x28098): In f=
unction `speedo_resume':<br>: undefined reference to `ioread32'<br>drivers/=
built-
in.o(.text+0x280a4): In function `speedo_resume':<br>: undefined reference =
to `iowrite8'<br>drivers/built-in.o(.text+0x280dc): In function `speedo_res=
ume':<br><br>Thanks,<br>--kishore<br>

------=_Part_9997_33203890.1146753004401--
