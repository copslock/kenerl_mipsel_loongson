Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 07:16:49 +0000 (GMT)
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:11999
	"EHLO QMTA07.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23098494AbYKDHQq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 07:16:46 +0000
Received: from OMTA08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by QMTA07.westchester.pa.mail.comcast.net with comcast
	id av791a0030Fqzac57vGB3i; Tue, 04 Nov 2008 07:16:11 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA08.westchester.pa.mail.comcast.net with comcast
	id avGf1a00G58Be2l3UvGfLV; Tue, 04 Nov 2008 07:16:40 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=MYXyyX_-kbTf0ocPCMQA:9 a=y_SrRMj2HFMETmdtJKYA:7
 a=P6CIcvTiMdE7gXlkRojVOyVIo3UA:4 a=WeOa-AV5lc8A:10 a=QJAqVYndk0IA:10
Message-ID: <490FF6B3.9030906@gentoo.org>
Date:	Tue, 04 Nov 2008 02:16:03 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	libc-ports@sources.redhat.com
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
References: <490A912A.8030901@gentoo.org> <20081101112643.GA2249@linux-mips.org>
In-Reply-To: <20081101112643.GA2249@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> In the kernel we have very good knowledge about what types of processors
> are being used for what configuration; much less in userland and the code
> as suggested by you would result in a silent failure on affected R10000
> machines if version built not for the R10000 was being used - iow no
> improvment over what we have right now.  So for userland I'd prefer to
> 
>  o MIPS I builds: use the some 28 nops.
>  o Builds for MIPS II or better: always use the branch likely
>  o A runtime test would have to be implemented pessimisticall because it
>    would have to rely on /proc being mounted which isn't available early in
>    the boot process.  It's probably going to add more overhead than it
>    saves anyway.
> 
> There is a price for using branch likely - but not that high.  In the grand
> picture it'll almost certainly vanish in the benchmarking noise.

Good idea.  I'll tinker with this once I wrap my head around the gcc-side of things.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
