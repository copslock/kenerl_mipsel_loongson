Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 20:41:11 +0100 (BST)
Received: from cpc1-cmbg3-5-0-cust123.cmbg.cable.ntl.com ([IPv6:::ffff:81.96.64.123]:59334
	"EHLO cuddles.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S8225773AbUFJTlH>; Thu, 10 Jun 2004 20:41:07 +0100
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by cuddles.cambridge.redhat.com (8.12.8/8.12.8) with ESMTP id i5AJdQVL023960;
	Thu, 10 Jun 2004 20:39:36 +0100
Received: (from aph@localhost)
	by redhat.com (8.12.8/8.12.8/Submit) id i5AJdP4I023956;
	Thu, 10 Jun 2004 20:39:25 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.47341.874148.879473@cuddles.cambridge.redhat.com>
Date: Thu, 10 Jun 2004 20:39:25 +0100
To: David Daney <ddaney@avtrex.com>, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: [RFC] MIPS division by zero and libgcj...
In-Reply-To: <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
References: <40C8B29B.3090501@avtrex.com>
	<16584.46883.332620.513805@cuddles.cambridge.redhat.com>
X-Mailer: VM 7.14 under Emacs 21.3.50.1
Return-Path: <aph@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph@redhat.com
Precedence: bulk
X-list: linux-mips

Andrew Haley writes:
 > David Daney writes:
 >  > It appears that gcc configured for mipsel-linux will execute a "break 7" 
 >  > instruction on integer division by zero.
 > 
 > I thought that the MIPS never generated a hardware trap for division,
 > but instead there was an assembler macro that did the test for
 > overflow, and the "div" instruction actually generates this test
 > inline.  Maybe do a disassembly to check.

Here we are:

MIPS Dependent Features

--trap
--no-break

    automatically macro expands certain division and multiplication
    instructions to check for overflow and division by zero. This
    option causes to generate code to take a trap exception rather
    than a break exception when an error is detected. The trap
    instructions are only supported at Instruction Set Architecture
    level 2 and higher.

--break
--no-trap

    Generate code to take a break exception rather than a trap
    exception when an error is detected. This is the default.

Andrew.
