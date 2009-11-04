Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 17:19:22 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:43309 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492496AbZKDQTP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 17:19:15 +0100
Received: by ywh3 with SMTP id 3so7477655ywh.22
        for <linux-mips@linux-mips.org>; Wed, 04 Nov 2009 08:19:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=52oulsJJ9bYYDhA6K65T1ABxLjaZQ9nx4lmmTHeoDn4=;
        b=WhEg8y7ndXAZqqfAQwMVmBThiAgaf9cTz4wX2hp091coqN/g1yMpnRKONXFSidui4F
         gWWEYGaDSJDv7tMM4M/p8VwU3sQYfDTRyPyqeiAmRBN9IfzCSfNwGWSSERBO3fSUBDyc
         AeV4wJrR9zzCELYJcLfEyrjYhf/tL99dPygyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Y5pdkzRWrkBikQwV8XvTW2UHbKbwDAK3fKqClKZP0aUZjEixMKiC11jtlxikQHkLwe
         ob+u473S5zo8qtcQ/yjKWo1AX0OzO3Xnr5rqu8DW/f3yL2FGGTqZPfN1p5EG7U5U51kN
         xj9W6DQegexaPOCiu1rtRjaskNCow20TXN+7U=
MIME-Version: 1.0
Received: by 10.91.19.4 with SMTP id w4mr3813635agi.0.1257351542566; Wed, 04 
	Nov 2009 08:19:02 -0800 (PST)
Date:	Thu, 5 Nov 2009 00:19:02 +0800
Message-ID: <e997b7420911040819k21c6525fo6fa0d0151c7052aa@mail.gmail.com>
Subject: mips timer could not work
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=001485f547900d6e6c04778df829
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

--001485f547900d6e6c04778df829
Content-Type: text/plain; charset=ISO-8859-1

Hi  all,

This is a linux mips newbie's  problem when he tried to  boot a mips64 board
.

The timer seemed not working properly when booting.

He has  checked the count and compare register , found that , count register
 increased  all the time ,however, compare register remained unchanged , non
zero.

he also checked the cause register ,the exception code was zero,indicating
an external interrupt.

And he found that ,timer  interrupt seemed not triggered , for he has  put
some illegal code in handle_int function, but not found kernel even
complained of that,

 so he guess that, no external interrupt(timer intterrupt)  was triggered in
this situation.

Can someone here tell  how to solve this problem? Thank  in advance

regards,

--001485f547900d6e6c04778df829
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi=A0 all,</div>
<div>=A0</div>
<div>This is a linux mips newbie&#39;s =A0problem when he tried to=A0 boot =
a mips64 board .</div>
<div>=A0</div>
<div>The timer seemed not working properly when booting.</div>
<div>=A0</div>
<div>He has =A0checked the count and compare register , found that , count =
register =A0increased=A0 all the time ,however, compare register remained u=
nchanged , non zero.</div>
<div>=A0</div>
<div>he=A0also checked the cause register ,the exception code was zero,indi=
cating an external interrupt.</div>
<div>=A0</div>
<div>And=A0he found that ,timer =A0interrupt seemed not triggered , for=A0h=
e has =A0put some illegal code in handle_int function,=A0but not found=A0ke=
rnel=A0even complained=A0of that,</div>
<div>=A0</div>
<div>=A0so he guess that, no external interrupt(timer intterrupt) =A0was tr=
iggered in this situation.</div>
<div>=A0</div>
<div>Can someone here tell =A0how to solve this problem? Thank=A0 in advanc=
e</div>
<div>=A0</div>
<div>regards,</div>
<div>=A0</div>
<div>=A0</div>

--001485f547900d6e6c04778df829--
