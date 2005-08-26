Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 09:38:32 +0100 (BST)
Received: from [IPv6:::ffff:62.13.170.159] ([IPv6:::ffff:62.13.170.159]:47114
	"EHLO mail.h3g.it") by linux-mips.org with ESMTP
	id <S8224975AbVHZIiL>; Fri, 26 Aug 2005 09:38:11 +0100
Received: from MIEXC05.h3g.it ([10.215.31.110]) by mail.h3g.it with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 26 Aug 2005 10:44:29 +0200
Received: from [10.212.33.13] ([10.212.33.13]) by MIEXC05.h3g.it with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 26 Aug 2005 10:43:47 +0200
Message-ID: <430ED658.6050008@tiscali.it>
Date:	Fri, 26 Aug 2005 10:44:08 +0200
From:	Piccio <unfarco@tiscali.it>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: problem making kernel from CVS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Aug 2005 08:43:47.0942 (UTC) FILETIME=[468CA060:01C5AA1A]
Return-Path: <unfarco@tiscali.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unfarco@tiscali.it
Precedence: bulk
X-list: linux-mips

Hello all,

I'm getting the following error building the kernel from latest CVS (at 
the end, I think), on a R5000 O2.
I can send the kernel config, if needed.

Some ideas?
Thanks

Massimo



  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/mips/kernel/built-in.o(.text+0x2a10): In function `$L3':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2a18): In function `$L3':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2b40): In function `$L21':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2a1c): In function `$L3':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2a3c): In function `$L3':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2a44): more undefined references to 
`atomic_lock' follow
