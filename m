Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 14:25:08 +0200 (CEST)
Received: from place.org ([65.163.18.18]:8324 "EHLO zachs.place.org")
	by linux-mips.org with ESMTP id <S1122977AbSICMZH>;
	Tue, 3 Sep 2002 14:25:07 +0200
Received: from Jay-Carlsons-Computer.local. (localhost [127.0.0.1])
	by zachs.place.org (Postfix) with ESMTP
	id C9346181B4; Tue,  3 Sep 2002 07:24:57 -0500 (CDT)
Date: Tue, 3 Sep 2002 08:26:37 -0400
Subject: soft-float defines in mips-linux gcc config
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: Jay Carlson <nop@nop.com>
To: linux-mips@linux-mips.org
From: Jay Carlson <nop@nop.com>
Content-Transfer-Encoding: 7bit
Message-Id: <648A6FF8-BF38-11D6-B21F-0030658AB11E@nop.com>
X-Mailer: Apple Mail (2.543)
Return-Path: <nop@nop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nop@nop.com
Precedence: bulk
X-list: linux-mips

Right now there is a small bug in how mips-linux configures gcc for 
softfloat.

In gcc/config/mips/t-linux, we set up libgcc to include the soft 
floating point code, using the GNU names, like __addsi3.  But because 
mips/linux.h includes mips/ecoff.h, gcc produces calls to the GOFAST 
style names (like dpmul, very namespace-contaminating.)

mips/netbsd.h cleans up after mips/elf.h by doing:

#undef US_SOFTWARE_GOFAST
#undef INIT_SUBTARGET_OPTABS
#define INIT_SUBTARGET_OPTABS

which would fix the problem for mips/linux.h as well.

Jay
