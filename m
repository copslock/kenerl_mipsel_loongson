Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 20:49:40 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:18395 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225773AbUFJTtg>;
	Thu, 10 Jun 2004 20:49:36 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 10 Jun 2004 12:47:29 -0700
Message-ID: <40C8BAF0.9070007@avtrex.com>
Date: Thu, 10 Jun 2004 12:48:00 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Haley <aph@redhat.com>
CC: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
References: <40C8B29B.3090501@avtrex.com> <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
In-Reply-To: <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2004 19:47:29.0878 (UTC) FILETIME=[C3B05760:01C44F23]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Andrew Haley wrote:

>David Daney writes:
> > It appears that gcc configured for mipsel-linux will execute a "break 7" 
> > instruction on integer division by zero.
>
>I thought that the MIPS never generated a hardware trap for division,
>but instead there was an assembler macro that did the test for
>overflow, and the "div" instruction actually generates this test
>inline.  Maybe do a disassembly to check.
>  
>
MIPS div instructions never trap.  However I think that GCC always emits 
things like this when it cannot determine that the divisor is non zero:

        div     $0,$17,$16
        bne     $16,$0,1f
        nop
        break   7
1:
 

> > This causes the kernel (I am using 2.4.25) to send SIGTRAP.
> > 
> > Gcj when configured for this platform uses the -f-use-divide-subroutine 
> > option, causing it to never generate inline division instructions (nor 
> > the accompanying break 7), but instead call a runtime function that 
> > properly handles throwing ArithmeticException.
> > 
> > Q1:  Is this behavior (use of break 7 and SIGTRAP) part of some ABI 
> > specification?  I'll admit a bit of ignorance in this area.
>
>See above.
>
> > Q2: Does anyone see any reason that libgcj should not be configured to 
> > handle the SIGTRAP and throw the ArithmeticException from the signal 
> > handler (similar to what is done on i386).
>
>No, there's no reason not to do it.  You'll have to write some hairy
>code to satisfy all the rules, though.
>
What are the rules?  Are they more complicated then throw an 
ArithmeticException when the divisor is zero?

>
> > Q3: Will using SIGTRAP in this manner make debugging programs that 
> > divide things by zero very difficult to debug under gdb?
>
>No.
>  
>
I have not tried it.  But I think gdb uses "break" and SIGTRAP for 
breakpoints.  Is it possible to get gdb to pass the signal to the 
debugee, so that it could be handled by the runtime support?
