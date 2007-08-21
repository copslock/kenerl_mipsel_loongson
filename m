Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2007 13:44:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15271 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021918AbXHUMoD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Aug 2007 13:44:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7LCgPcH027158;
	Tue, 21 Aug 2007 13:42:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7LCgOim027156;
	Tue, 21 Aug 2007 13:42:24 +0100
Date:	Tue, 21 Aug 2007 13:42:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Carl van Schaik <carl@ok-labs.com>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: TLS register for NPTL
Message-ID: <20070821124223.GA26709@linux-mips.org>
References: <46C93BB5.9050809@ok-labs.com> <20070820080627.GF4479@networkno.de> <20070820145449.GA11766@linux-mips.org> <46CA45AD.8080203@ok-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46CA45AD.8080203@ok-labs.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 21, 2007 at 11:53:49AM +1000, Carl van Schaik wrote:

> > Aside, latest MIPS processors support a hardware implementation of rdhwr $29,
> > so there is no more emulation overhead for this instruction at full binary
> > compatibility.
> >   
> Ok, I agree that this is probably the best way to go. In the L4
> microkernel we have for a long time used k0 (sony did this as well?),

For the PS2, yes.  Then again the R5900 design is screwed to the point where
it can't reasonably be exploited without adding another AI variant - but that
only makes the use of k0 a slightly less bad idea.

  Ralf
