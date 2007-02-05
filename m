Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 09:18:30 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.229]:8984 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037479AbXBEJS0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 09:18:26 +0000
Received: by qb-out-0506.google.com with SMTP id e12so500519qba
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 01:17:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ak7dU5kNPSpeOXrsesvrNkmvqbP9XZzUNuyciDldtNxOR257nTwE5cD3hzBKFOUA3sjDtQVfqi25q0/M6Fyc4klahot6D6RhF0Qg5UiFjNLF2YBxx5sUCIAaHNGIj9E2lQcY9yBcqwDUaQBQCuk3f+/NuvghtTImPcZYCBpK8sw=
Received: by 10.114.93.1 with SMTP id q1mr574219wab.1170667044554;
        Mon, 05 Feb 2007 01:17:24 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 5 Feb 2007 01:17:24 -0800 (PST)
Message-ID: <cda58cb80702050117k68bcbe07o56471051bad14acb@mail.gmail.com>
Date:	Mon, 5 Feb 2007 10:17:24 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Daniel Jacobowitz" <dan@debian.org>
Subject: Re: Question about signal syscalls !
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"David Daney" <ddaney@avtrex.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070205023039.GA5438@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
	 <45C3611D.7000702@avtrex.com>
	 <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
	 <45C36D46.5040409@avtrex.com>
	 <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com>
	 <45C3A1E3.8010802@avtrex.com> <20070205005516.GA1581@nevyn.them.org>
	 <20070205011048.GA26654@linux-mips.org>
	 <20070205023039.GA5438@nevyn.them.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/5/07, Daniel Jacobowitz <dan@debian.org> wrote:
> I'm sure that, if we tried, we could get GDB to work.  Every time this
> comes up I just worry about other things that we don't know about which
> use the saved information.  These structures are just in too many
> places to change comfortably.
>

It seems pretty dangerous if some tools use this saved hw context.
Because if the signal handler is handled during a return from a system
call (not from interrupt) then most information in the saved
information are random...

Well maybe we could just make a new version sig context functions
which does not save/restore static registers and make it an disabled
by default. That would let some people to play with and to see if it
break some user tools ?

-- 
               Franck
