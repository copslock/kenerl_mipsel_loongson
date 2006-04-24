Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 16:01:10 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.177]:43572 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133747AbWDXPBC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 16:01:02 +0100
Received: by pproxy.gmail.com with SMTP id d80so1170023pyd
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2006 08:14:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=NWSOh0DB/hLjkZrCo98mF9m/Imf68lDoDNbKt8o1ODWayVSDvHT+0+lXPg/kNHh1ZRRB4kStdfvmZMQJ+sRqVWG/pey6DTuPbFoMCfbZPvAuR4AMTVFvF8bOpekMGoIZN6H2VYlcCCeO3dAq6A5L8D6kr+Iw4avYuMsGgI1UrQw=
Received: by 10.35.78.13 with SMTP id f13mr268969pyl;
        Mon, 24 Apr 2006 08:14:02 -0700 (PDT)
Received: by 10.35.96.20 with HTTP; Mon, 24 Apr 2006 08:14:01 -0700 (PDT)
Message-ID: <5800c1cc0604240814i1caf3f76ofaa2a668ca5e1b2b@mail.gmail.com>
Date:	Mon, 24 Apr 2006 23:14:01 +0800
From:	"Bin Chen" <binary.chen@gmail.com>
To:	linux-mips@linux-mips.org
Subject: what will be caused by setting TLB's virtual address part to unmapped address?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22246_11584823.1145891641996"
Return-Path: <binary.chen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: binary.chen@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_22246_11584823.1145891641996
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

In MIPS64, the 0xFFFFFFFF80000000 is a kernel unmapped area, what will be
caused by setting up a TLB entry with the virtual address be
0xFFFFFFFF80000000?

I ask this question because I noticed u-boot's TLB init code use the addres=
s
from 0xFFFFFFFF80000000 to fill in the blank tlb, but I don't know the
purpose of this operation.

Thanks in advance.

B.C

------=_Part_22246_11584823.1145891641996
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
In MIPS64, the 0xFFFFFFFF80000000 is a kernel unmapped area, what will
be caused by setting up a TLB entry with the virtual address be
0xFFFFFFFF80000000?<br>
<br>
I ask this question because I noticed u-boot's TLB init code use the
address from 0xFFFFFFFF80000000 to fill in the blank tlb, but I don't
know the purpose of this operation.<br>
<br>
Thanks in advance.<br>
<br>
B.C<br>

------=_Part_22246_11584823.1145891641996--
