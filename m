Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jan 2003 23:11:35 +0000 (GMT)
Received: from web40412.mail.yahoo.com ([IPv6:::ffff:66.218.78.109]:62260 "HELO
	web40412.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225256AbTA3XLe>; Thu, 30 Jan 2003 23:11:34 +0000
Message-ID: <20030130231119.65802.qmail@web40412.mail.yahoo.com>
Received: from [157.165.41.125] by web40412.mail.yahoo.com via HTTP; Thu, 30 Jan 2003 15:11:19 PST
Date: Thu, 30 Jan 2003 15:11:19 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: register declared variable for no optimization
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I have a question on the GCC optimization. I am using
GCC3.0.4 MIPS crosscompiler on Redhat 7.1. In a
function I did the following:

init()
{
  register unsigned int temp;
      .
      .
  temp = devict.dev1.devtc
      .
} 

I compiled the code with optimization level 0 and
found something weird about the register variable
temp. This is shows in the disassembly file:

for temp = devict.dev1.devtc
    lui $3, 0xb801
    lw  $3, 28($3)

This is right since the CPU loads the
devict.dev1.devtc value from memory to the register 3.
However, after the above instructions, I found:

     nop
     sw $3, 0($30)
     lw $2, 0($30)

now the compiler asked the CPU to store the register
in the stack. However, I declared the variable as a
register, how come it still needs to go to the stack?
I compiled the same code with gcc-2.8.1, optimization
level 0, and did not find the same issue there. 

Why the gcc-3.0.4 did the weird stuff? Do I have to
use at least level 1 to make the register declared
work for it?

Thanks a lot!


Long

 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
