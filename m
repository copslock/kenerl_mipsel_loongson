Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 16:38:48 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53911 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365663AbZCDQip (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Mar 2009 16:38:45 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49aeae400000>; Wed, 04 Mar 2009 11:37:20 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 08:36:45 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 08:36:45 -0800
Message-ID: <49AEAE1D.5030205@caviumnetworks.com>
Date:	Wed, 04 Mar 2009 08:36:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Brian Foster <brian.foster@innova-card.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304121732.GA28381@caradoc.them.org>
In-Reply-To: <20090304121732.GA28381@caradoc.them.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Mar 2009 16:36:45.0367 (UTC) FILETIME=[680A8C70:01C99CE7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:
>>  moving the signal trampoline to a vdso (which
>>  is(? was?) called, maybe misleadingly, ‘vsyscall’,
>>  on other architectures) is the obvious solution to
>>  that part of the puzzle.  and yes, it is possible
>>  to maintain the ABI; the signal trampoline is still
>>  also put on the stack, and modulo XI, would work if
>>  used — the trampoline-on-stack is simply not used
>>  if there is a vdso with the signal trampoline.
> 
> That won't quite retain the ABI: you need to make sure everyone
> locates it by using the stack pointer instead of the return pc.
> Fortunately, GCC uses the return PC only for instruction matching
> today.  I have a vague memory it used to use the stack pointer but
> this was more reliable.

That is correct.  Due to various errata the trampoline cannot always be 
at a fixed offset to the signal context bits.  So we had to use the 
return PC as you indicate.

David Daney
