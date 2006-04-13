Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Apr 2006 21:43:19 +0100 (BST)
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253]:29841 "HELO
	smtp105.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133706AbWDMUnK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Apr 2006 21:43:10 +0100
Received: (qmail 54308 invoked from network); 13 Apr 2006 20:55:06 -0000
Received: from unknown (HELO ?192.168.1.103?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp105.biz.mail.mud.yahoo.com with SMTP; 13 Apr 2006 20:55:06 -0000
Subject: mips64 kgdb fpu access bug
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 13 Apr 2006 13:54:59 -0700
Message-Id: <1144961699.8372.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


I'm running into a random problem with a mips64 kernel (2.6.14 based). I
see the problem on the MIPS Malta 5kf board but it seems like a generic
bug to me. What happens is that CP0 FR bit is zero and an add register
is accessed by an instruction whose datatype is 64 bits. That results in
a reserved instruction kernel fault. I see this bug in gdb-low.S - the
code checks to see if CU1 is enabled but then it seems to assume that FR
is always 1 when running a 64bit kernel. However, I also randomly see
the bug without kgdb being enabled when we hit _save_fp and this macro:

.macro  fpu_save_double thread status tmp1 tmp2
        sll     \tmp2, \tmp1, 5
        bgez    \tmp2, 2f
        fpu_save_16odd \thread
2:
        fpu_save_16even \thread \tmp1                   # clobbers t1
        .endm

tmp1 is "t0" and it's not clear to me why we're checking t0 instead of
status in order to decide whether to save the odd registers or not. I
must be missing something because others would have hit this bug by now.
Any clues would be appreciated.

Thanks,

Pete
