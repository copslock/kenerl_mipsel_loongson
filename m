Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 20:33:37 +0100 (BST)
Received: from cpc1-cmbg3-5-0-cust123.cmbg.cable.ntl.com ([IPv6:::ffff:81.96.64.123]:52934
	"EHLO cuddles.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S8225778AbUFJTdd>; Thu, 10 Jun 2004 20:33:33 +0100
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by cuddles.cambridge.redhat.com (8.12.8/8.12.8) with ESMTP id i5AJVmVL023902;
	Thu, 10 Jun 2004 20:31:58 +0100
Received: (from aph@localhost)
	by redhat.com (8.12.8/8.12.8/Submit) id i5AJVlGH023898;
	Thu, 10 Jun 2004 20:31:47 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
Date: Thu, 10 Jun 2004 20:31:47 +0100
To: David Daney <ddaney@avtrex.com>
Cc: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: [RFC] MIPS division by zero and libgcj...
In-Reply-To: <40C8B29B.3090501@avtrex.com>
References: <40C8B29B.3090501@avtrex.com>
X-Mailer: VM 7.14 under Emacs 21.3.50.1
Return-Path: <aph@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph@redhat.com
Precedence: bulk
X-list: linux-mips

David Daney writes:
 > It appears that gcc configured for mipsel-linux will execute a "break 7" 
 > instruction on integer division by zero.

I thought that the MIPS never generated a hardware trap for division,
but instead there was an assembler macro that did the test for
overflow, and the "div" instruction actually generates this test
inline.  Maybe do a disassembly to check.

 > This causes the kernel (I am using 2.4.25) to send SIGTRAP.
 > 
 > Gcj when configured for this platform uses the -f-use-divide-subroutine 
 > option, causing it to never generate inline division instructions (nor 
 > the accompanying break 7), but instead call a runtime function that 
 > properly handles throwing ArithmeticException.
 > 
 > Q1:  Is this behavior (use of break 7 and SIGTRAP) part of some ABI 
 > specification?  I'll admit a bit of ignorance in this area.

See above.

 > Q2: Does anyone see any reason that libgcj should not be configured to 
 > handle the SIGTRAP and throw the ArithmeticException from the signal 
 > handler (similar to what is done on i386).

No, there's no reason not to do it.  You'll have to write some hairy
code to satisfy all the rules, though.

 > Q3: Will using SIGTRAP in this manner make debugging programs that 
 > divide things by zero very difficult to debug under gdb?

No.

 > Q4: I appears that on the i386, a divide overflow causes SIGFPE.  Why 
 > doesn't the mips-linux kernel sent SIGFPE on "break 7"
 > 
 > Q5: prims.cc in libgcj implies that we should be handling SIGFPE to do 
 > all this.  If I make these changes, won't it be a little confusing that 
 > all references to SIGFPE are really SIGTRAP?

Feel free to change the comments.  :-)

Andrew.
