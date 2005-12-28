Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2005 07:35:24 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.200]:49895 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126502AbVL1HfG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Dec 2005 07:35:06 +0000
Received: by xproxy.gmail.com with SMTP id s19so808114wxc
        for <linux-mips@linux-mips.org>; Tue, 27 Dec 2005 23:36:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=MUNq21E50pgL+4QMwF6qt44DS2+QmrALwqtVGWDLr2tRIHQeO+s9o3raUa2KREzaqIeZHE2g/odn0OasGr0xqj+rynqWRhr966gOjogbChWMQKPCxZhGhUHBEWjMjGIHIAfmvoJK594/1kB8NQrbwU29eDTuUdnzBtU6nm0eAos=
Received: by 10.70.99.13 with SMTP id w13mr7580710wxb;
        Tue, 27 Dec 2005 23:36:54 -0800 (PST)
Received: by 10.70.96.11 with HTTP; Tue, 27 Dec 2005 23:36:54 -0800 (PST)
Message-ID: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com>
Date:	Wed, 28 Dec 2005 12:36:54 +0500
From:	Adil Hafeez <adilhafeez80@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Fixed kernel entry point suggestion
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_46479_25644177.1135755414286"
Return-Path: <adilhafeez80@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adilhafeez80@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_46479_25644177.1135755414286
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Everytime we add/remove a feature from kernel location of entry_point symbo=
l
changes. As a result we 've to recompile bootloader with new entry_point
location. Adding a simply jump instruction to kernel_entry point in
head.Scan solve this problem. Why dont we make this change permanent
in kernel.

- Adil

------=_Part_46479_25644177.1135755414286
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div><br>Everytime we add/remove a feature from kernel location of entry_po=
int symbol changes. As a result we 've to recompile bootloader with new ent=
ry_point location. Adding a simply jump instruction to kernel_entry point i=
n=20
head.S can solve this problem. Why dont we make this change permanent in ke=
rnel.</div>
<div>&nbsp;</div>
<div>- Adil</div>

------=_Part_46479_25644177.1135755414286--
