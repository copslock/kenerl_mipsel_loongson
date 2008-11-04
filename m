Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 14:26:50 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61653 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23125456AbYKDO0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Nov 2008 14:26:48 +0000
Date:	Tue, 4 Nov 2008 14:26:48 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <20081104090410.GC7291@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0811041423290.7233@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
 <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org> <20081104090410.GC7291@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Nov 2008, Ralf Baechle wrote:

> Makes me wonder if there is a point in having a single gcc option, something
> like -march=generic which selects something like this, including all
> workarounds?

 No, please don't.  If we decide to introduce it, someone will actually 
decide to use it wasting computing power of good machines to handle corner 
cases.  If somebody has a broken machine or a hardware vendor or a 
distributor has interest in supporting a particular flavour of breakage, 
then they are of course free to do so.  But please do not make it too easy 
to spread.  Let's give the hardware folks some incentive to fix their 
bugs. ;)

  Maciej
