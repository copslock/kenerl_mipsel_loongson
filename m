Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 20:14:15 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:17367 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225769AbUFJTOK>;
	Thu, 10 Jun 2004 20:14:10 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 10 Jun 2004 12:11:56 -0700
Message-ID: <40C8B29B.3090501@avtrex.com>
Date: Thu, 10 Jun 2004 12:12:27 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcc@gcc.gnu.org, linux-mips@linux-mips.org
CC: java@gcc.gnu.org
Subject: [RFC] MIPS division by zero and libgcj...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2004 19:11:56.0741 (UTC) FILETIME=[CC3D7750:01C44F1E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

It appears that gcc configured for mipsel-linux will execute a "break 7" 
instruction on integer division by zero.

This causes the kernel (I am using 2.4.25) to send SIGTRAP.

Gcj when configured for this platform uses the -f-use-divide-subroutine 
option, causing it to never generate inline division instructions (nor 
the accompanying break 7), but instead call a runtime function that 
properly handles throwing ArithmeticException.

Q1:  Is this behavior (use of break 7 and SIGTRAP) part of some ABI 
specification?  I'll admit a bit of ignorance in this area.

Q2: Does anyone see any reason that libgcj should not be configured to 
handle the SIGTRAP and throw the ArithmeticException from the signal 
handler (similar to what is done on i386).

Q3: Will using SIGTRAP in this manner make debugging programs that 
divide things by zero very difficult to debug under gdb?

Q4: I appears that on the i386, a divide overflow causes SIGFPE.  Why 
doesn't the mips-linux kernel sent SIGFPE on "break 7"

Q5: prims.cc in libgcj implies that we should be handling SIGFPE to do 
all this.  If I make these changes, won't it be a little confusing that 
all references to SIGFPE are really SIGTRAP?


David Daney
