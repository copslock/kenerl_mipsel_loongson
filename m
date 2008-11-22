Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 09:54:59 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:17171 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S23830229AbYKVJys (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 09:54:48 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id DAA11387;
	Sat, 22 Nov 2008 03:53:41 -0600
Message-ID: <4927D6E0.4020009@paralogos.com>
Date:	Sat, 22 Nov 2008 03:54:40 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Chad Reese <kreese@caviumnetworks.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Is there no way to shared code with Linux and other OSes?
References: <4927C34F.4000201@caviumnetworks.com>
In-Reply-To: <4927C34F.4000201@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

[This should be good for some useless weekend flaming.]

Chad Reese wrote:
> Watching the discussion about Octeon patches submitted by Cavium
> Networks, it seems apparent the majority of the problems simply come
> from the fact that the code was written to be shared between multiple
> operating systems. Code for programming the low level details of
> hardware doesn't really change if the OS is Linux, VxWorks, BSD, or
> something else. I've found it very depressing that most of the comments
> basically come down to "this doesn't match the kernel coding standard,
> change it". Obviously rewriting code for every coding standard and OS is
> just a bug farm. Fixes will never get merged into all the rewrites.
>   
If one had a fixed list of OSes that one wanted to support, each of 
which had a stable set of coding standards, then in principle it might 
be possible to derive some lowest-common-denominator coding standards 
from the intersection of sets.  As you point out, the resulting 
constraints (no typedefs for Linux, no identifiers more than N 
characters for other environments, etc.) may directly with efficient 
coding and maintenance.  That's a trade-off you get to make versus 
maintaining multiple variants.
> Cavium can't be the first to want to share code. We'd like Octeon to be
> well supported in the Linux kernel, but we'd also like other OSes to
> work well too. There has to be some sort of middle ground here. Our base
> "library" that is completely OS agnostic is actually license under the
> BSD license to allow maximum portability between various OSes. What have
> other people done before?
>
> Through the discussion on the Octeon patches a number of bugs have been
> uncovered and code has been improved. This part of the kernel submit
> process is truly great. It just bothers me that so much needs to be
> rewritten for arbitrary reasons.
>   
A consistent coding style is, I think you'll agree, an aid to coding and 
maintenence in large-scale programming, and while the Linux kernel isn't 
really all that big as software systems go, it's big enough to warrant a 
consistent style.  What's disconcerting is the "feature creep" in the 
coding standard.  Typedefs weren't banned by Linux in the beginning, and 
there are legacy typedefs in the system for exactly the reasons why 
software engineers working in C have used them for generations.  At some 
point, if Linux isn't going to become the Latin liturgy of operating 
systems, the standard will need to move away from such arbitrary 
dogmatism.  The argument given for banning typedefs altogether is that 
nested typedefs are confusing to programmers.  I strongly suspect that 
there's a coding rule that would exclude the kinds of abuses that 
provoked the rule while allowing sensible use of typedefs for 
portability and future-proofing. But that's not going to happen any time 
real soon.
> For example, there has been lots of complaints that we use typedefs
> throughout our code. Some people may not like them, but they have been
> useful in the past. Some code used to use structures to reference chip
> registers. Later due to new features, we found it necessary to change
> the struct to a union with anonymous members. Because of the typedefs we
> were able to change the fields for the new features without breaking
> compatibility with existing code. If we'd used "struct" everywhere
> instead of a typedef, all existing code would have to change for no
> other reason except to substitute "union" for "struct". Not everyone has
>  the freedom of the kernel programmers to ignore code outside of the
> project.
>   
I had a similar experience of annoyance with Linux dogma years ago, so I 
very much sympathize with your reaction.  However, isn't there a less 
elegant but functional alternative, such as passing pointers to void 
around and casting to type as appropriate, that you could have used had 
you known in advance that the Linux priesthood would reject typedefs as 
heresy?

          Regards,

          Kevin K.
