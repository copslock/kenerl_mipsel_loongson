Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 15:59:31 +0000 (GMT)
Received: from [IPv6:::ffff:209.116.120.7] ([IPv6:::ffff:209.116.120.7]:2317
	"EHLO tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S8225393AbUANP7b>; Wed, 14 Jan 2004 15:59:31 +0000
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <Z8T14LDD>; Wed, 14 Jan 2004 10:58:42 -0500
Message-ID: <37A3C2F21006D611995100B0D0F9B73C04F11125@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: linux-mips@linux-mips.org
Subject: Correct assembler/compiler options for 4KC core?
Date: Wed, 14 Jan 2004 10:58:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <nmckee@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nmckee@telogy.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to use the following opcodes: movz, movn, clo, clz, madd, msub on
both a 4KC and 4KeC core. What gas options should I use to get the above
opcodes to work (mips4?  mips32?)  How would one link against closed source
libraries that were compiled for mips2?  Is there a list of what opcodes
correspond to the various ISA's and gas flags?  The best reference I saw was
from fsf that just mentions the -mips1/-mips2/-mips3/-mips4.  I did notice
in the latest gas docs -march option, but I don't see that available in my
toolchain.  I'm running on a development system with gas 2.9.5 and gcc 2.96.

TIA,

Nick Zajerko-McKee
