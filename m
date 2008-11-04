Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 07:17:32 +0000 (GMT)
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:49035
	"EHLO QMTA08.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23098501AbYKDHRa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 07:17:30 +0000
Received: from OMTA14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by QMTA08.westchester.pa.mail.comcast.net with comcast
	id avCL1a0031HzFnQ58vH3tH; Tue, 04 Nov 2008 07:17:03 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA14.westchester.pa.mail.comcast.net with comcast
	id avHS1a00A58Be2l3avHTSi; Tue, 04 Nov 2008 07:17:27 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=m81FFIYZSgF5laOgjGIA:9 a=XiyBFaq89-dWcDhccUwA:7
 a=HG96_pgb9b2vyHGBjqac8pZ6f60A:4 a=WeOa-AV5lc8A:10 a=Mz_smNXqyOQA:10
Message-ID: <490FF6E4.9000300@gentoo.org>
Date:	Tue, 04 Nov 2008 02:16:52 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	James Perkins <james@loowit.net>
CC:	libc-ports@sources.redhat.com, Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
References: <490A912A.8030901@gentoo.org> <490C907A.40005@loowit.net>
In-Reply-To: <490C907A.40005@loowit.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

James Perkins wrote:
>       "move	%1,%3\n\t"		      \
>       "sc	%1,%4\n\t"		      \
> -     "beqz	%1,1b\n"		      \
> +     R10K_BEQZ_INSN			      \
>       acq	"\n\t"			      \
>       ".set	pop\n"			      \
> 
> Is it possible to leave the parameters in the inline code and
> remove them from the macro definition? I feel the code is more
> readable without having to refer to the macro definition if
> the parameters are left in place.

Makes sense, I'll keep this in mind for the next patch revision I make.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
