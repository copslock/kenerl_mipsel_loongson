Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2005 12:28:44 +0000 (GMT)
Received: from host238-156.pool80180.interbusiness.it ([IPv6:::ffff:80.180.156.238]:39666
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225400AbVCEM22>; Sat, 5 Mar 2005 12:28:28 +0000
Received: by localhost.localdomain (Postfix, from userid 501)
	id 543F7110DF5; Sat,  5 Mar 2005 14:28:01 +0100 (CET)
Subject: still ip27 problems
From:	Michele Carla` <goldfinger@member.fsf.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 05 Mar 2005 14:28:00 +0100
Message-Id: <1110029280.3448.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Return-Path: <goldfinger@member.fsf.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: goldfinger@member.fsf.org
Precedence: bulk
X-list: linux-mips

Hi, I'm still trying to run linux on an ip27...
the only kernel that I can boot succesfully (via network) is the iluxa's
one:
http://www.selfsoft.com/progs/mips/kernels/vmlinux.ip27-20040428
(except for networking, it has some problem with the IOC3 network
interface)

all other precompiled image (I have found... if you have others, please
tell me) fails.

I'm trying to compile another one. is there a "suggested" version (of
the kernel and compiler) ?

should I abilitate the Dallas 1-wire, or the IOC3 driver has an
hardcoded support for this ?

Thanks

Michele Carla`
goldfinger@member.fsf.org
