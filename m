Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 07:11:48 +0000 (GMT)
Received: from mail013.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.67]:38373
	"EHLO mail013.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225216AbUAQHLr>; Sat, 17 Jan 2004 07:11:47 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail013.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0H7Bde29937
	for <linux-mips@linux-mips.org>; Sat, 17 Jan 2004 18:11:41 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Trouble compiling MIPS cross-compiler
Date: Sat, 17 Jan 2004 17:11:34 +1000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171711.34964@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

Hi,

I've been following the instructions in the FAQ on linux-mips.org but when I 
go to compile ecgs-1.1.2, half way through I get this error:

as: unrecognized option `-O2'
make[3]: *** [libgcc2.a] Error 1
make[3]: Leaving directory `/home/adam/toinstall/egcs-1.1.2/gcc'

I can post more of the error messages if you need them.  I tried upgrading my 
host binutils as well, but that didn't make a difference.  If I run 
"mips-linux-as -O2" it works, but just "as -O2" gives that same error.  
They're both the same versions now:

$ as -v -O2
GNU assembler version 2.14 (i686-pc-linux-gnu) using BFD version 2.14 20030612
as: unrecognized option `-O2'

$ mips-linux-as -v -O2
GNU assembler version 2.14 (mips-linux) using BFD version 2.14 20030612

Does anyone know how to fix this problem?

Thanks,
Adam.
