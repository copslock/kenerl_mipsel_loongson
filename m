Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 20:10:26 +0100 (BST)
Received: from mra05.ch.as12513.net ([82.153.254.73]:42705 "EHLO
	mra05.ch.as12513.net") by ftp.linux-mips.org with ESMTP
	id S20022673AbXGLTKX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 20:10:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra05.ch.as12513.net (Postfix) with ESMTP id 40234C4661;
	Thu, 12 Jul 2007 20:10:18 +0100 (BST)
Received: from mra05.ch.as12513.net ([127.0.0.1])
 by localhost (mra05.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 16058-01-32; Thu, 12 Jul 2007 20:10:17 +0100 (BST)
Received: from mcrowe.com (deneb.mcrowe.com [82.152.148.4])
	by mra05.ch.as12513.net (Postfix) with ESMTP id 8C354C46AE;
	Thu, 12 Jul 2007 20:10:17 +0100 (BST)
Received: from mac by mcrowe.com with local (Exim 4.63)
	(envelope-from <mac@mcrowe.com>)
	id 1I943L-0001Xh-8U; Thu, 12 Jul 2007 20:10:15 +0100
Date:	Thu, 12 Jul 2007 20:10:15 +0100
From:	Mike Crowe <mac@mcrowe.com>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Strange gp corruption problem
Message-ID: <20070712191015.GA5167@mcrowe.com>
References: <20070712170624.GA31776@mcrowe.com> <20070712172152.GC30622@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070712172152.GC30622@networkno.de>
X-url:	http://www.mcrowe.com/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <mac@mcrowe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mac@mcrowe.com
Precedence: bulk
X-list: linux-mips

I wrote:
>> We have a function that does some string manipulation (not
>> particularly dangerous manipulation and I've been through it
>> carefully) and then calls atol. As expected the prologue of this
>> function calculates the value of the gp register by applying an offset
>> to the t9 register which contains the address of the start of the
>> function like this:
>> 
>>  47995c:       3c1c0fba        lui     gp,0xfba
 
On Thu, Jul 12, 2007 at 06:21:52PM +0100, Thiemo Seufer wrote:
> Looks weird as an entry point. Normally entries are 8 byte aligned.

Many of the entry points in the image are only four byte aligned. :(

>> The only user-space reason I can come up with for this happening is if
>> the caller jumped into this function one instruction late. This seems
>> unlikely because t9 contains the correct value and the stack looks
>> fine.
> 
> Check the value of $ra (e.g. with a gdb breakpoint) after entering the
> function.

I should have mentioned that this problem doesn't occur every time the
function is called. The reproduction case I have calls the function
over and over again from a higher level (in fact the loop is in a
scripting language). I believe that it usually fails on the second
invocation but if I make unrelated changes to the code it can
sometimes happen after ten or twenty invocations. As soon as I try and
put breakpoints into the function it doesn't happen (although if I
disable the breakpoint and continue it does tend to strike). It looks
like something asynchronous but it's difficult to work out why it
likes to strike only this function.

At the point of the segfault $ra = 0x479fe8 which is the value I would
expect.

  479fcc:       8fc20048        lw      v0,72(s8)
  479fd0:       8c420000        lw      v0,0(v0)
  479fd4:       8fc40040        lw      a0,64(s8)
  479fd8:       00402821        move    a1,v0
  479fdc:       8f999750        lw      t9,-26800(gp)
  479fe0:       0320f809        jalr    t9
  479fe4:       00000000        nop
  479fe8:       8fdc0010        lw      gp,16(s8)
  479fec:       afc20018        sw      v0,24(s8)

I also failed to mention that we're using binutils-2.16.1.

Thanks for your response.

Mike.
