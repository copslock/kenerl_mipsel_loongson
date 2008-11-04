Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 14:23:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:725 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23125353AbYKDOXG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Nov 2008 14:23:06 +0000
Date:	Tue, 4 Nov 2008 14:23:06 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <490FF63A.7010900@gentoo.org>
Message-ID: <alpine.LFD.1.10.0811041418230.7233@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
 <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Nov 2008, Kumba wrote:

> But I guess the question I'm pondering, is just how rare would it be for
> someone to actually need a MIPS-I binary with ll/sc and branch-likely fixes to
> run on something like an R10000?  Rare enough to justify denying them that
> particular command argument combination, and thus taking Option #1?  Or go the
> extra mile for Option #2?  I don't know if that's my call to really make,
> since I lack the statistical data to know who would be affected, and in what
> ways (i.e., do they have alternative methods, such as MIPS-II, etc..).

 Workarounds should be as cheap as possible maintenance-wise.  My vote is 
for requiring people in the need to use broken R10k revisions to choose a 
compatible ISA.  It actually makes sense to use 64-bit software on these 
systems implying at least MIPS III, which is also another argument not to 
try to bend backwards and support MIPS I with R10k workarounds.

  Maciej
