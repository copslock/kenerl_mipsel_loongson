Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 21:32:56 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:17117 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225787AbUFJUcw>;
	Thu, 10 Jun 2004 21:32:52 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 10 Jun 2004 13:30:43 -0700
Message-ID: <40C8C512.2020607@avtrex.com>
Date: Thu, 10 Jun 2004 13:31:14 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Haley <aph@redhat.com>
CC: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
References: <40C8B29B.3090501@avtrex.com>	<16584.46883.332620.513805@cuddles.cambridge.redhat.com>	<40C8BAF0.9070007@avtrex.com> <16584.48456.389968.903435@cuddles.cambridge.redhat.com>
In-Reply-To: <16584.48456.389968.903435@cuddles.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2004 20:30:43.0868 (UTC) FILETIME=[CDD3CDC0:01C44F29]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Andrew Haley wrote:

>David Daney writes:
> > Andrew Haley wrote:
> > 
> > MIPS div instructions never trap.  However I think that GCC always emits 
> > things like this when it cannot determine that the divisor is non zero:
> > 
> >         div     $0,$17,$16
> >         bne     $16,$0,1f
> >         nop
> >         break   7
> > 1:
> >  
> > 
>
> > >No, there's no reason not to do it.  You'll have to write some hairy
> > >code to satisfy all the rules, though.
> > >
> > What are the rules?  Are they more complicated then throw an 
> > ArithmeticException when the divisor is zero?
>
>Yes.  You also have to do
>
>  if (dividend == (jint) 0x80000000L && divisor == -1)
>    return dividend;
>  
>and not throw an exception.
>
That is evidently what you have to do on i386.  MIPS gives the right 
answer without faulting (i.e. hitting the break 7).

David Daney.
