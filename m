Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 20:59:45 +0100 (BST)
Received: from cpc1-cmbg3-5-0-cust123.cmbg.cable.ntl.com ([IPv6:::ffff:81.96.64.123]:8135
	"EHLO cuddles.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S8225786AbUFJT7l>; Thu, 10 Jun 2004 20:59:41 +0100
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by cuddles.cambridge.redhat.com (8.12.8/8.12.8) with ESMTP id i5AJw1VL024113;
	Thu, 10 Jun 2004 20:58:11 +0100
Received: (from aph@localhost)
	by redhat.com (8.12.8/8.12.8/Submit) id i5AJw08f024109;
	Thu, 10 Jun 2004 20:58:00 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.48456.389968.903435@cuddles.cambridge.redhat.com>
Date: Thu, 10 Jun 2004 20:58:00 +0100
To: David Daney <ddaney@avtrex.com>
Cc: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
In-Reply-To: <40C8BAF0.9070007@avtrex.com>
References: <40C8B29B.3090501@avtrex.com>
	<16584.46883.332620.513805@cuddles.cambridge.redhat.com>
	<40C8BAF0.9070007@avtrex.com>
X-Mailer: VM 7.14 under Emacs 21.3.50.1
Return-Path: <aph@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph@redhat.com
Precedence: bulk
X-list: linux-mips

David Daney writes:
 > Andrew Haley wrote:
 > 
 > MIPS div instructions never trap.  However I think that GCC always emits 
 > things like this when it cannot determine that the divisor is non zero:
 > 
 >         div     $0,$17,$16
 >         bne     $16,$0,1f
 >         nop
 >         break   7
 > 1:
 >  
 > 

 > >No, there's no reason not to do it.  You'll have to write some hairy
 > >code to satisfy all the rules, though.
 > >
 > What are the rules?  Are they more complicated then throw an 
 > ArithmeticException when the divisor is zero?

Yes.  You also have to do

  if (dividend == (jint) 0x80000000L && divisor == -1)
    return dividend;
  
and not throw an exception.

 > > > Q3: Will using SIGTRAP in this manner make debugging programs that 
 > > > divide things by zero very difficult to debug under gdb?
 > >
 > >No.
 > >  
 > >
 > I have not tried it.  But I think gdb uses "break" and SIGTRAP for 
 > breakpoints.  Is it possible to get gdb to pass the signal to the 
 > debugee, so that it could be handled by the runtime support?

Well, gcj will generate either break or trap instructions.  You can
tell gdb to ignore either.

Andrew.
