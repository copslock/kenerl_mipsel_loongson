Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 07:30:26 +0000 (GMT)
Received: from web41509.mail.yahoo.com ([IPv6:::ffff:66.218.93.92]:6548 "HELO
	web41509.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224847AbTCFHaZ>; Thu, 6 Mar 2003 07:30:25 +0000
Message-ID: <20030306073017.65521.qmail@web41509.mail.yahoo.com>
Received: from [81.218.92.190] by web41509.mail.yahoo.com via HTTP; Wed, 05 Mar 2003 23:30:17 PST
Date: Wed, 5 Mar 2003 23:30:17 -0800 (PST)
From: Tinga Shilo <tingashilo@yahoo.com>
Subject: static variables access and gp
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <tingashilo@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tingashilo@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
I am implementing a kernel mechanism which is 
very performance oriented. Along my long critical
path,
there is a static variable that needs to be accessed
quite a few times. This variable is a structure which
is approximately 60 bytes big.
In there any way I can "convince" my kernel (compiled
with gcc) to access this variable using gp ?
Is gp usually used for this purpose in mips-linux ?
Can it be ?

A while ago I saw a small discussion here about usage
of gp for static variables, but it didn't provide
any definite answers.
TIA
T


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
