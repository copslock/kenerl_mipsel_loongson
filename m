Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2009 09:37:39 +0100 (BST)
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:38555
	"EHLO QMTA11.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S28582723AbZDHIhO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2009 09:37:14 +0100
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA11.emeryville.ca.mail.comcast.net with comcast
	id cdAS1b00C0EPchoABsFkmR; Wed, 08 Apr 2009 04:15:44 +0000
Received: from [10.0.0.109] ([24.6.28.106])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id csFi1b0072HMlxk8MsFjLY; Wed, 08 Apr 2009 04:15:43 +0000
Message-ID: <49DC24E4.7000704@notav8.com>
Date:	Tue, 07 Apr 2009 21:15:32 -0700
From:	Chris Rhodin <chris@notav8.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Enabling and Disabling Interrupts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@notav8.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips

On cpus without the ei/di instructions, the macros local_irq_enable and 
local_irq_disable use a read-modify-write of the status register to 
change the IE bit.  Doesn't this leave a window where an interrupting 
context can change the status registers interrupt mask bits and have 
that change reversed when the interrupted context resumes?  Or possibly 
this is covered by a policy I haven't figured out yet?

Thanks,

Chris Rhodin
