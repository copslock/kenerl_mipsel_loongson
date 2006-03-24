Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 14:26:51 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.197]:28100 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133904AbWCXO0m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 14:26:42 +0000
Received: by zproxy.gmail.com with SMTP id 9so893003nzo
        for <linux-mips@linux-mips.org>; Fri, 24 Mar 2006 06:36:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=TZ1RCpf7shea/Q1kaI1Tak3+PuKuSSgWI1gOFkQE3+1y07DnlJs0MMhJ2J01FfoJSkseOA9hnNUlx0idA9H13XKhFR68YpdHF1Hlxvs7+L60tztmM9jB00OVMeir7StsrEn51ST/KuG4MxX7b4IvWgppxX3N5cSQTYK4MTq8U4k=
Received: by 10.36.224.61 with SMTP id w61mr468902nzg;
        Fri, 24 Mar 2006 06:36:43 -0800 (PST)
Received: by 10.36.49.7 with HTTP; Fri, 24 Mar 2006 06:36:43 -0800 (PST)
Message-ID: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com>
Date:	Fri, 24 Mar 2006 20:06:43 +0530
From:	"Kishore K" <hellokishore@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: 2.6.14 - problem with malta
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11306_1887912.1143211003021"
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11306_1887912.1143211003021
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi
I am trying to bring up the malta board (MIPS 4kec), using the 2.6.14 kerne=
l
downloaded from linux-mips. The kernel is built with malta_defconfig locate=
d
in arch/mips/configs. After loading this kernel, board halts after printing
"Linux Started
Config serial console: console=3DttyS0, 38400n8r"

Kernel is built with the tool chain based on gcc 3.3.6, binutils 2.14.90.0.=
8
.

Could any one tell me what the problem is .

thanks,
--kishore

------=_Part_11306_1887912.1143211003021
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi<br>I am trying to bring up the malta board (MIPS 4kec), using the 2.6.14=
 kernel downloaded from linux-mips. The kernel is built with malta_defconfi=
g located in arch/mips/configs. After loading this kernel, board halts afte=
r printing=20
<br>&quot;Linux Started<br>Config serial console: console=3DttyS0, 38400n8r=
&quot;<br><br>Kernel is built with the tool chain based on gcc 3.3.6, binut=
ils 2.14.90.0.8.<br><br>Could any one tell me what the problem is .<br><br>
thanks,<br>--kishore<br><br>

------=_Part_11306_1887912.1143211003021--
