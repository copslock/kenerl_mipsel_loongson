Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:35:51 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.236]:21336 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038463AbWI2Jfu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:35:50 +0100
Received: by wx-out-0506.google.com with SMTP id h30so947494wxd
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 02:35:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=T004vuaPAJp+hZoCNC2jWKkhhcWjB1CUnVsJz8/wpBGi/NIG8obkPLzm1M+KGmwn6L748I3UvzV2Ihojn0CUwx3VJROHFJsDm9MALgk1LDTkaVzgiUE46Wn34rNc/clC22wAuVItGriDPDfWfXLcB1xoUtFX45R2v9iFW7Rd+OM=
Received: by 10.90.105.19 with SMTP id d19mr1233562agc;
        Fri, 29 Sep 2006 02:35:48 -0700 (PDT)
Received: by 10.90.31.10 with HTTP; Fri, 29 Sep 2006 02:35:48 -0700 (PDT)
Message-ID: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
Date:	Fri, 29 Sep 2006 17:35:48 +0800
From:	"David Lee" <receive4me@gmail.com>
To:	linux-mips@linux-mips.org
Subject: HELP: opcode not supported on this processor
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5159_14564575.1159522548397"
Return-Path: <receive4me@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: receive4me@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_5159_14564575.1159522548397
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am trying to port some code over to MIPSEL from i386. However, I got the
following error:

gcc -I/usr/include -O6 -DMODULE -D__KERNEL__ -DEXPORT_SYMTAB
-I/usr/src/linux/drivers/net -Wal
l -I. -Wstrict-prototypes -fomit-frame-pointer
-I/usr/src/linux/drivers/net/wan -I /usr/src/li
nux/include -I/usr/src/linux/include/net -DMODVERSIONS -include
/usr/src/linux-2.4/include/lin
ux/modversions.h  zip.c
/tmp/ccwOZSG3.s: Assembler messages:
/tmp/ccwOZSG3.s:5143: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($2)'
/tmp/ccwOZSG3.s:5145: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($2)'
/tmp/ccwOZSG3.s:5175: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($13)'
/tmp/ccwOZSG3.s:5177: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($13)'
/tmp/ccwOZSG3.s:5232: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($8)'
/tmp/ccwOZSG3.s:5234: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($8)'
/tmp/ccwOZSG3.s:5523: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($17)'
/tmp/ccwOZSG3.s:5525: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($17)'
/tmp/ccwOZSG3.s:6525: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($2)'
/tmp/ccwOZSG3.s:6527: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($2)'
/tmp/ccwOZSG3.s:6553: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($2)'
/tmp/ccwOZSG3.s:6555: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($2)'
/tmp/ccwOZSG3.s:6595: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($6)'
/tmp/ccwOZSG3.s:6597: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($6)'
/tmp/ccwOZSG3.s:6645: Error: opcode not supported on this processor: mips1
(mips1) `ll $4,16($7)'
/tmp/ccwOZSG3.s:6647: Error: opcode not supported on this processor: mips1
(mips1) `sc $4,16($7)'

Please advise what should be the appropriate opcodes for MIPS.

Thanks.

David

------=_Part_5159_14564575.1159522548397
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I&nbsp;am trying to port&nbsp;some code&nbsp;over to MIPSEL from i386. However, I got the following error:</div>
<div>&nbsp;</div>
<div>gcc -I/usr/include -O6 -DMODULE -D__KERNEL__ -DEXPORT_SYMTAB -I/usr/src/linux/drivers/net -Wal<br>l -I. -Wstrict-prototypes -fomit-frame-pointer -I/usr/src/linux/drivers/net/wan -I /usr/src/li<br>nux/include -I/usr/src/linux/include/net -DMODVERSIONS -include /usr/src/linux-
2.4/include/lin<br>ux/modversions.h&nbsp; zip.c<br>/tmp/ccwOZSG3.s: Assembler messages:<br>/tmp/ccwOZSG3.s:5143: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($2)'<br>/tmp/ccwOZSG3.s:5145: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($2)'
<br>/tmp/ccwOZSG3.s:5175: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($13)'<br>/tmp/ccwOZSG3.s:5177: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($13)'<br>/tmp/ccwOZSG3.s:5232: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($8)'
<br>/tmp/ccwOZSG3.s:5234: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($8)'<br>/tmp/ccwOZSG3.s:5523: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($17)'<br>/tmp/ccwOZSG3.s:5525: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($17)'
<br>/tmp/ccwOZSG3.s:6525: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($2)'<br>/tmp/ccwOZSG3.s:6527: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($2)'<br>/tmp/ccwOZSG3.s:6553: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($2)'
<br>/tmp/ccwOZSG3.s:6555: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($2)'<br>/tmp/ccwOZSG3.s:6595: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($6)'<br>/tmp/ccwOZSG3.s:6597: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($6)'
<br>/tmp/ccwOZSG3.s:6645: Error: opcode not supported on this processor: mips1 (mips1) `ll $4,16($7)'<br>/tmp/ccwOZSG3.s:6647: Error: opcode not supported on this processor: mips1 (mips1) `sc $4,16($7)'<br>&nbsp;</div>
<div>Please advise what should be the appropriate opcodes&nbsp;for MIPS.</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>David</div>
<div>&nbsp;</div>

------=_Part_5159_14564575.1159522548397--
