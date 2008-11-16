Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2008 07:36:01 +0000 (GMT)
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:14027 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23705584AbYKPHf6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2008 07:35:58 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id fjXm1a0040mlR8UA2jbr67; Sun, 16 Nov 2008 07:35:51 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id fjbo1a00E58Be2l8Xjbp6s; Sun, 16 Nov 2008 07:35:51 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=Vlc_l-ZfwTSD0nRG1OoA:9 a=e14HrLU3lErFfhwQ80sA:7
 a=V0d3tr767ETY-eN2rUgWOQ9m2okA:4 a=0Pil5MYkW-IA:10 a=WeOa-AV5lc8A:10
 a=4iXfik_MsjQA:10
Message-ID: <491FCD2C.2070900@gentoo.org>
Date:	Sun, 16 Nov 2008 02:35:08 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org>	<87y6zphn5b.fsf@firetop.home> <491A88E8.3050108@gentoo.org>	<873ahvgr39.fsf@firetop.home> <491D3381.4050505@gentoo.org> <87vduprrkl.fsf@firetop.home>
In-Reply-To: <87vduprrkl.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> 
> Yeah, it looks generally good.  I think we've got to the point where
> it's easier for me to make changes directly rather than ask you to
> follow a tortuous list of vaguely-described requests, so:

Tortuous isn't the word I'd use.  More like fun and challenging!  Still a ways 
to go understand things, but it's getting easier to walk around in the mips 
backend of gcc and have an idea of what's going on somewhat.

Thanks for answering all my questions!


>   - I added a missing @gol after "-mfix-r4400".

Yeah, I wasn't sure if I needed that or not.  I was building the info pages and 
comparing the output, and noticed a somewhat logical order where alike arguments 
were grouped onto their own line (i.e., the fix-4000 and fix-4400 were separated 
from the fix-sb1 and fix-vr* args).  Don't know Texi code at all, so I thought 
omitting the @gol would allow the patch to stay in the 80-char limit, but allow 
the info output to place fix-r10000 on the same line as the 4000/4400 args, 
since it appears all three were better related (in terms of implementation) than 
the sb1 and vr* args.


>   - I tweaked the documentation so that it was more consistent with the
>     other -mfix-* options.  Let me know if you spot a problem with the
>     new version, or if you aren't happy with it.

Looks good to me.  I added the bit about MIPS-II stuff and mentioning it won't 
work on MIPS-I, but wasn't sure if that level of detail was necessary.


>   - ...I changed the name of the parameter from TEMPLATE to LOOP to
>     avoid a bootstrap-breaking warning about using a C++ identifier.
>     (Again my fault.  I'd used TEMPLATE when suggesting the function,
>     but it was a completely untested suggestion.)
> 
>   - I added a prototype to mips-protos.h, again to avoid a bootstrap-
>     breaking warning.
> 
>   - I fixed a typo: s/!TARGET_BRANCHLIKEL/!TARGET_BRANCHLIKELY/.
>     GCC wouldn't build without this, so perhaps the posted patch
>     wasn't the final one.

Ah, I probably would have caught these but PR38052 was getting in the way of a 
full build.  Although, building as a cross-compiler might've avoided that bug.


> Applied with those changes.  I've attached the final changelog and
> patch below.  Thanks for the contribution, and for your patience.

Looks good to me.  This'll let me play with the glibc-side of things next.  I 
think I did stumble on one or two omissions from my R10000 scheduling patch I'll 
send over in a separate e-mail (it's a one-line fix I believe).


Thanks again!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
