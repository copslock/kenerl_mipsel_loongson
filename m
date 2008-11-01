Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 20:33:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:34510 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22939350AbYKAUdD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Nov 2008 20:33:03 +0000
Date:	Sat, 1 Nov 2008 20:33:03 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rdsandiford@googlemail.com>
cc:	Kumba <kumba@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>,
	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <87abcjibsl.fsf@firetop.home>
Message-ID: <alpine.LFD.1.10.0811012024390.28895@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 1 Nov 2008, Richard Sandiford wrote:

> There are two ways we could handle this:
> 
>   - Make -mfix-r10000 require -mbranch-likely.  (It mustn't _imply_
>     -mbranch-likely.  It should simply check that -mbranch-likely is
>     already in effect.)
> 
>   - Make -mfix-r10000 insert nops when -mbranch-likely is not in effect.

 If I recall right, these is something special about the pipeline in this 
context making the branch-likely instructions the only ones that work.  
Which would make the option you proposed first the only viable.  I am not 
absolutely sure and I have no reference handy.  Perhaps Ralf or someone at 
linux-mips will know?

  Maciej
