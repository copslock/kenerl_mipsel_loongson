Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 09:34:58 +0000 (GMT)
Received: from guri.is.scarlet.be ([IPv6:::ffff:193.74.71.22]:7616 "EHLO
	guri.is.scarlet.be") by linux-mips.org with ESMTP
	id <S8225275AbVANJex> convert rfc822-to-8bit; Fri, 14 Jan 2005 09:34:53 +0000
Received: from (everest.is.scarlet.be [193.74.71.40]) 
	by guri.is.scarlet.be  with ESMTP id j0E9YqC11603; 
	Fri, 14 Jan 2005 10:34:52 +0100
Date: Fri, 14 Jan 2005 10:34:52 +0100
Message-Id: <IAAVY4$88D392D5C6A28D5ADF92D6FDBEDF4E7A@scarlet.be>
Subject: Re: unresolved (soft)float symbols
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "Philippe De Swert" <philippedeswert@scarlet.be>
To: "ralf" <ralf@linux-mips.org>
Cc: "linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type: 0
X-SenderIP: 195.144.76.34
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <IAAVY4$88D392D5C6A28D5ADF92D6FDBEDF4E7A
Envelope-Id: <IAAVY4$88D392D5C6A28D5ADF92D6FDBEDF4E7A
X-archive-position: 6913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Thank you all for the answers I got already,

> On Thu, Jan 13, 2005 at 03:08:24PM +0100, Philippe De Swert wrote:
> 
> > The module builds fine also, but when insmodding I get the following error.
> > 
> > insmod: unresolved symbol __fixdfsi
> > insmod: unresolved symbol __floatsidf
> > insmod: unresolved symbol __muldf3
> > insmod: unresolved symbol __adddf3
> > 
> > As these are all float operations I am wondering about the following things:
> > 
> > 1.why they are in there? I have a soft-float toolchain....
> 
> That's why they are there.

After looking further into it I found out that they are softfloat symbols and
that they should be in the libgcc.a of my toolchain. (David Daney confirmed
this, but I don't understand however how I am supposed to regenerate the
libgcc.a with his method. So David if you could tell me more about it. Is it
supposed to be build during the final gcc stages?) According to Steve I have a
faulty toolchain, after looking into his build method I cannot find anything
very different expect for the gxx-include-dir configuration option, but I
guess this is not causing the problem.

I found a toolchain that works, but I would prefer to have my own (with
sources) And I am trying to learn something here. So I am trying to understand
what is happening. Am I correct if the problem lies in the fact that libgcc.a
is putting/used to put in these symbols in the module. The kernel does not
understand these symbols because they are supposed to be userland only, so the
solution would be to have a libgcc.a which does not do that?

How do I generate one (or which is the specific thing I have to take care of
to avoid that the problem occurs)? Can I make my toolchain link against
something else?

Of course is this is not in the context of the mailing list I would appreciate
any pointers for a mips-toolchain mailing list.

> The simple answer is no FP in the kernel.

This is what I expected, but I got confused by some answers on other mailing
lists. But it is good to have a clear point.

Thank you,

Philippe
 
| Philippe De Swert -GNU/linux - uClinux freak-      
|      
| Stag developer http://stag.mind.be/  
| Emdebian developer: http://www.emdebian.org  
|   
| Please do not send me documents in a closed format. (*.doc,*.xls,*.ppt)    
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)    
| Why? http://pallieter.is-a-geek.org:7832/~johan/word/english/    

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be
Please make the necessary changes in your address book. 
