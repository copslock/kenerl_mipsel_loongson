Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 23:46:10 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:49302 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22944923AbYKAXp7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2008 23:45:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA1NjAUm017801;
	Sat, 1 Nov 2008 23:45:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA1Nj9Ld017800;
	Sat, 1 Nov 2008 23:45:09 GMT
Date:	Sat, 1 Nov 2008 23:45:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Richard Sandiford <rdsandiford@googlemail.com>,
	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Message-ID: <20081101234509.GA14265@linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <alpine.LFD.1.10.0811012024390.28895@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0811012024390.28895@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 01, 2008 at 08:33:03PM +0000, Maciej W. Rozycki wrote:

> > There are two ways we could handle this:
> > 
> >   - Make -mfix-r10000 require -mbranch-likely.  (It mustn't _imply_
> >     -mbranch-likely.  It should simply check that -mbranch-likely is
> >     already in effect.)
> > 
> >   - Make -mfix-r10000 insert nops when -mbranch-likely is not in effect.
> 
>  If I recall right, these is something special about the pipeline in this 
> context making the branch-likely instructions the only ones that work.  
> Which would make the option you proposed first the only viable.  I am not 
> absolutely sure and I have no reference handy.  Perhaps Ralf or someone at 
> linux-mips will know?

There are two possible workarounds.  The other which IRIX and the Linux
kernel are using is based on the branch-likely instruction.  The way it
works is that R10000 family processors have a fairly cheesy branch
prediction for branch likely (unlike all MIPS32 and MIPS64 processors I
know of!) which predicts branch likely instructions as always taken.  So
if a SC instruction succeeds the loop closure branch of the usual LL/SC
loop will be miss-predicted and the pipeline restarted.

The alternative is to put enough NOPs (upto 28) after the loop closure
brach to avoid a sequence of 4 problematic instructions being active in
the pipeline at the same time.

SSNOP won't cut it btw.  SSNOP don't have any influence on the predecode
and reordering buffers - even assuming the R10000 actually honors SSNOP.
Implementing the special treatment of SSNOP (which is encoded as
SLL $0, $0, 1) just doesn't make sense for an R10000 calibre processor.

Is gcc capable of guaranteeing a certain minimum number of instructions
between one LL and another LL instruction?  Then this knowledge could be
used to avoid the branch likely or cut down the padding NOPs.

  Ralf
