Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 11:39:15 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.200]:4683 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133915AbWDZKjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Apr 2006 11:39:00 +0100
Received: by nz-out-0102.google.com with SMTP id j2so1272529nzf
        for <linux-mips@linux-mips.org>; Wed, 26 Apr 2006 03:52:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=nJNvV950sa0AGkjc9eUuX2oaurFWIl9dTRmvcaIrA8LCoCNQx71wsxLfILrfzzuI/6M78gRpcHk04//Y8/PsadTdlnkDSGindXNKRacp1j0FUPiGtauXSWZLxNOM21Q9hyhe6P51Pl+sq7nuCorFsM7uRn26XJ0Y+Yh/hCwLBVM=
Received: by 10.36.118.6 with SMTP id q6mr3180001nzc;
        Wed, 26 Apr 2006 03:52:13 -0700 (PDT)
Received: by 10.36.47.2 with HTTP; Wed, 26 Apr 2006 03:52:12 -0700 (PDT)
Message-ID: <f07e6e0604260352y2789be9cxd11daa0649c0c6dc@mail.gmail.com>
Date:	Wed, 26 Apr 2006 16:22:12 +0530
From:	"Kishore K" <hellokishore@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Problem with malta 4Kc on 2.6.16
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_627_681812.1146048732872"
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_627_681812.1146048732872
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi all
When I try to bring up the malta board (MIPS 4Kc) with linux 2.6.16 kernel,
the kernel halts after printing the following two lines.

LINUX started...
Config serial console: console=3DttyS0,38400n8r

But, I _don't_ see the same problem when I replace the
arch/mips/mips-boards/generic/pci.c file in 2.6.16 with the file from
2.6.10with appropriate changes to return type and the name of the
function
pcibios_init().

Has any one faced the same problem. If  so, is there any better method to
overcome this problem. The same problem is observed for the kernels from
2.6.12 on wards and this problem doesn't exist for 2.6.10.

thanks,
--kishore

------=_Part_627_681812.1146048732872
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi all<br>When I try to bring up the malta board (MIPS 4Kc) with linux 2.6.=
16 kernel, the kernel halts after printing the following two lines.<br><br>=
LINUX started...<br>Config serial console: console=3DttyS0,38400n8r<br><br>
But, I _don't_ see the same problem when I replace the arch/mips/mips-board=
s/generic/pci.c file in 2.6.16 with the file from 2.6.10 with appropriate c=
hanges to return type and the name of the function pcibios_init(). <br>
<br>Has any one faced the same problem. If&nbsp; so, is there any better me=
thod to overcome this problem. The same problem is observed for the kernels=
 from 2.6.12 on wards and this problem doesn't exist for 2.6.10. <br><br>th=
anks,
<br>--kishore<br><br><br>

------=_Part_627_681812.1146048732872--
