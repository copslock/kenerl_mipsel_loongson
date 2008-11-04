Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 14:32:32 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:62899 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23125631AbYKDOca (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 14:32:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA4EVRTR025799;
	Tue, 4 Nov 2008 14:31:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA4EVRYA025797;
	Tue, 4 Nov 2008 14:31:27 GMT
Date:	Tue, 4 Nov 2008 14:31:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Message-ID: <20081104143127.GB24906@linux-mips.org>
References: <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org> <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org> <20081104090410.GC7291@linux-mips.org> <alpine.LFD.1.10.0811041423290.7233@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0811041423290.7233@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 04, 2008 at 02:26:48PM +0000, Maciej W. Rozycki wrote:

> > Makes me wonder if there is a point in having a single gcc option, something
> > like -march=generic which selects something like this, including all
> > workarounds?
> 
>  No, please don't.  If we decide to introduce it, someone will actually 
> decide to use it wasting computing power of good machines to handle corner 
> cases.  If somebody has a broken machine or a hardware vendor or a 
> distributor has interest in supporting a particular flavour of breakage, 
> then they are of course free to do so.  But please do not make it too easy 
> to spread.  Let's give the hardware folks some incentive to fix their 
> bugs. ;)

I guess honorable mention for the years to come in the GCC man page
(see -mfix-two-by-two-equals-five ;-)  can do wonders.

  Ralf
