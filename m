Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 21:40:56 +0100 (CET)
Received: from alg133.algor.co.uk ([62.254.210.133]:8171 "EHLO
	oalggw.algor.co.uk") by linux-mips.org with ESMTP
	id <S8225193AbSLJUkz>; Tue, 10 Dec 2002 21:40:55 +0100
Received: from mips.com (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gBAKepW13518;
	Tue, 10 Dec 2002 20:40:51 GMT
Message-ID: <3DF6514E.8040100@mips.com>
Date: Tue, 10 Dec 2002 20:40:46 +0000
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
References: <15862.15924.283825.28108@hendon.algor.co.uk> <20021210193241.GA15908@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

>>Actually Carsten *is* trying to implement a protocol, it's just that
>>it's an extension to the gdb remote debug protocol, as used in our
>>SDE-MIPS toolchain (viz sde-gdb).  Algorithmics (now MIPS Technologies
>>UK), always extended the gdb remote debug protocol to support reading
>>and writing of single registers, and to support variable register
>>sizes (to allow a 64-bit debug stub to inter-work with gdb debugging a
>>32-bit application).
>>    
>>
>
>My point is that we implement the GDB protocol, for use with GDB -
>implementing random extensions to it is not a good idea.  I would
>strongly prefer these extensions be discussed on the GDB list before
>you try adding them to the CVS tree.  Also, I bet Andrew has a
>different idea of how the 64/32 thing ought to work than you do.  He's
>the remote protocol maintainer.
>

>These things should be planned on the GDB side before making yet more
>stubs use them.
>  
>

I thought the Linux community prided itself on inventing new and 
"non-standard" extensions to the toolchain  ;-). But yes, we should try 
to avoid incompatible changes. As part of MIPS we will hopefully have 
the resources to interface with the rest of the GNU community, and argue 
for the inclusion of our patches in the CVS trees.

>>When we first implemented these extensions we used the 'R' command to
>>write a single register, and 'r' to read one (they weren't then used
>>by gdb). Since then the remote protocol has gained the 'P' command to
>>    
>>
>
>'R' was added in 1995 according to my records.  Really?
>  
>

Yup. SDE-MIPS 1.1 shipped in 1992. :-)

>The protocol does, actually.  GDB doesn't _implement_ it, but the
>extension is documented in the manual ('p') and I wouldn't be surprised
>if Red Hat actually had an implementation somewhere.  I recommend the
>documentation of the protocol, on the GDB web site.
>
>Also note that `R' is extended restart process; the manual lists `r' as
>"restart entire target system".  I don't know when that was used but
>it's reason enough to stay away from using that letter to read a
>register.
>  
>
Yeah, that's why we dropped 'R' in our more recent gdb ports, but I 
wasn't aware of the new use of 'r' - I'll check out that page. 
 Certainly 'p' is the logical inverse of 'P', so we'll change our gdb 
remote stub to use that. So how about accepting Carsten's change, with 
the 'R' case removed, and 'r' changed to 'p'?

Nigel

-- 
                         Nigel Stephens         Mailto:nigel@mips.com
    _    _ ____  ___     MIPS Technologies (UK) Phone.: +44 1223 706200
    |\  /|||___)(___     The Fruit Farm         Direct: +44 1223 706207
    | \/ |||    ____)    Ely Road, Chittering   Fax...: +44 1223 706250
    TECHNOLOGIES (UK)    Cambridge CB5 9PH      Cell..: +44 7976 686470
 [formerly Algorithmics] England                http://www.algor.co.uk
