Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Feb 2005 23:23:53 +0000 (GMT)
Received: from amsfep15-int.chello.nl ([IPv6:::ffff:213.46.243.28]:36939 "EHLO
	amsfep15-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225203AbVB0XXh>; Sun, 27 Feb 2005 23:23:37 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep15-int.chello.nl
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20050227232331.GNKX12698.amsfep15-int.chello.nl@[127.0.0.1]>
          for <linux-mips@linux-mips.org>; Mon, 28 Feb 2005 00:23:31 +0100
Message-ID: <422256A3.2030407@amsat.org>
Date:	Mon, 28 Feb 2005 00:24:19 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: sparse and mips
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

Hi,

I tried compiling my switch driver with sparse to see if I did some 
stupid casts and got a lot of warnings.... (attached below)
Are others using sparse with mips kernels and getting the same?
Or has nobody taken the time to fix it up?
(The byteorder stuff should creap up everywhere or not?)

Jeroen


pe1rxq@laptop:~/edimax/linux-2.6.10-adm$ make vmlinuz C=1              
  CHK     include/linux/version.h
make[1]: `arch/mips/kernel/offset.s' is up to date.
  CHK     include/asm-mips/offset.h
make[1]: `arch/mips/kernel/reg.s' is up to date.
  CHK     include/asm-mips/reg.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CHECK   drivers/net/adm5120sw.c
include/asm/byteorder.h:27:4: warning: "MIPS, but neither __MIPSEB__, 
nor __MIPSEL__???"
include/linux/kernel.h:200:2: warning: "Please fix asm/byteorder.h"
include/linux/aio_abi.h:59:2: warning: edit for your odd byteorder.
include/linux/types.h:24:26: warning: Expected ; at end of declaration
include/linux/types.h:24:26: warning: got nlink_t
include/linux/types.h:64:26: warning: Expected ; at end of declaration
include/linux/types.h:64:26: warning: got size_t
include/linux/types.h:69:26: warning: Expected ; at end of declaration
include/linux/types.h:69:26: warning: got ssize_t
include/linux/types.h:74:28: warning: Expected ; at end of declaration
include/linux/types.h:74:28: warning: got ptrdiff_t
include/asm/bitops.h:75:9: warning: Expected ) after asm
include/asm/bitops.h:75:9: warning: got __LL
include/asm/bitops.h:83:9: warning: Expected ) after asm
include/asm/bitops.h:83:9: warning: got __LL
include/asm/bitops.h:135:9: warning: Expected ) after asm
include/asm/bitops.h:135:9: warning: got __LL
include/asm/bitops.h:143:9: warning: Expected ) after asm
include/asm/bitops.h:143:9: warning: got __LL
include/asm/bitops.h:194:9: warning: Expected ) after asm
include/asm/bitops.h:194:9: warning: got __LL
include/asm/bitops.h:205:9: warning: Expected ) after asm
include/asm/bitops.h:205:9: warning: got __LL
include/asm/bitops.h:256:9: warning: Expected ) after asm
include/asm/bitops.h:256:9: warning: got __LL
include/asm/bitops.h:275:9: warning: Expected ) after asm
include/asm/bitops.h:275:9: warning: got __LL
include/asm/bitops.h:346:9: warning: Expected ) after asm
include/asm/bitops.h:346:9: warning: got __LL
include/asm/bitops.h:366:9: warning: Expected ) after asm
include/asm/bitops.h:366:9: warning: got __LL
include/asm/bitops.h:438:9: warning: Expected ) after asm
include/asm/bitops.h:438:9: warning: got __LL
include/asm/bitops.h:457:9: warning: Expected ) after asm
include/asm/bitops.h:457:9: warning: got __LL
include/linux/kernel.h:83:40: warning: Expected ) in function declarator
include/linux/kernel.h:83:40: warning: got size
include/linux/kernel.h:85:40: warning: Expected ) in function declarator
include/linux/kernel.h:85:40: warning: got size
include/linux/kernel.h:86:41: warning: Expected ) in function declarator
include/linux/kernel.h:86:41: warning: got size
include/linux/kernel.h:88:41: warning: Expected ) in function declarator
include/linux/kernel.h:88:41: warning: got size
include/asm/string.h:44:77: warning: Expected ) in function declarator
include/asm/string.h:44:77: warning: got __n
include/asm/string.h:48:11: warning: Expected ) in function declarator
include/asm/string.h:48:11: warning: got ==
include/asm/string.h:48:3: warning: Trying to use reserved word 'if' as 
identifier
make[2]: *** [drivers/net/adm5120sw.o] Error 139
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
