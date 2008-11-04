Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 09:05:00 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:27557 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23103265AbYKDJE6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 09:04:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA494AK3019031;
	Tue, 4 Nov 2008 09:04:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA494AY2019023;
	Tue, 4 Nov 2008 09:04:10 GMT
Date:	Tue, 4 Nov 2008 09:04:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Message-ID: <20081104090410.GC7291@linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org> <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490FF63A.7010900@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 04, 2008 at 02:14:02AM -0500, Kumba wrote:

>> Agreed, but that's just as true of option 1.  Each option is as correct
>> as the other.  It's just a question of whether we need the combination:
>>
>>   -mips1 -mllsc -mfix-r10000
>>
>> to be accepted, or whether we can treat it as a compile-time error.
>
> Hmm, which do you think makes sense?  From a usage perspective, most 

It's a crude way of asking for a generic MIPS binary that runs on anything
but works best on MIPS II+.

Makes me wonder if there is a point in having a single gcc option, something
like -march=generic which selects something like this, including all
workarounds?

  Ralf
