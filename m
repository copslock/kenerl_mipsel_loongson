Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 09:56:22 +0100 (BST)
Received: from bay1-f112.bay1.hotmail.com ([IPv6:::ffff:65.54.245.112]:3591
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225203AbTD3I4U>; Wed, 30 Apr 2003 09:56:20 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 30 Apr 2003 01:56:11 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Wed, 30 Apr 2003 08:56:10 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Cc: geert@linux-m68k.org, edotkumar@yahoo.com
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Wed, 30 Apr 2003 01:56:10 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F1122ig4yorAxC0001d6ec@hotmail.com>
X-OriginalArrivalTime: 30 Apr 2003 08:56:11.0305 (UTC) FILETIME=[58EB1190:01C30EF6]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

More info...

After
$ make ARCH=mips menuconfig

I did,
$ make ARCH=mips dep

all the commands where operating on the arch/mips foler files. But at the 
end it wrote arch/i386 references in the tmp_include_depends file.

make[2]: Leaving directory `/usr/src/linux-2.4.20-6/arch/mips/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.20-6'
make update-modverfile
make[1]: Entering directory `/usr/src/linux-2.4.20-6'
/usr/src/linux-2.4.20-6/include/linux/modversions.h was not updated
make[1]: Leaving directory `/usr/src/linux-2.4.20-6'
(find /usr/src/linux-2.4.20-6 \( -name .depend -o -name .hdepend \) -print | 
xargs awk -f scripts/include_deps) > tmp_include_depends


clipping from the tmp_include_depends file:
------------------------------------------

/usr/src/linux-2.4.20-6/arch/i386/math-emu/exception.h: \
   /usr/src/linux-2.4.20-6/arch/i386/math-emu/fpu_emu.h
	@touch /usr/src/linux-2.4.20-6/arch/i386/math-emu/exception.h
/usr/src/linux-2.4.20-6/arch/i386/math-emu/fpu_asm.h: \
   /usr/src/linux-2.4.20-6/include/linux/linkage.h
	@touch /usr/src/linux-2.4.20-6/arch/i386/math-emu/fpu_asm.h


I even tried issuing these commands after $ make clean, still the same old 
problem. I guess I am close to get the Linux binaries for my Atlas board. 
Please help me with this.

Also do let me know if this binary is for RAM? Can I run this on top of 
Redboot without any issues?

Thanks,
-Mike.


_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail
