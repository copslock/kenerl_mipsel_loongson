Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:08:29 +0000 (GMT)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225385AbUA1PI2>; Wed, 28 Jan 2004 15:08:28 +0000
Date: Wed, 28 Jan 2004 15:08:28 +0000
From: Ladislav Michl <ladis@linux-mips.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Kevin Paul Herbert <kph@cisco.com>, linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
Message-ID: <20040128150828.A19525@linux-mips.org>
References: <1075255111.8744.4.camel@shakedown> <20040128094032.GB900@kopretinka> <yq07jzcz6sp.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq07jzcz6sp.fsf@wildopensource.com>; from jes@wildopensource.com on Wed, Jan 28, 2004 at 05:49:58AM -0500
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 05:49:58AM -0500, Jes Sorensen wrote:
> >>>>> "Ladislav" == Ladislav Michl <ladis@linux-mips.org> writes:
> 
> Ladislav> On Tue, Jan 27, 2004 at 05:58:31PM -0800, Kevin Paul Herbert
> Ladislav> wrote:
> >> In edit 1.68, the non-interrupt locking versions of
> >> raw_readq()/raw_writeq() were removed, in favor of locking
> >> ones. While this makes sense in general, it breaks the compilation
> >> of the sb1250 which uses the non-locking versions (____raw_readq()
> >> and ____raw_writeq()) in interrupt handlers.
> 
> Ladislav> Why was someone using these function at all? if you don't
> Ladislav> need locking simply do *reg_addr = val;
> 
> ARGHHHHHHHHHH!
> 
> If you are accessing memory mapped registers or memory on a PCI
> device, ie. likely on a 1250, you *must* use the readX/__raw_readX
> macros. Anybody just doing *reg = val on a PCI device should be
> banned from writing code for life!

eh? I said nothing about PCI device. These ____raw_writeq are
used in board specific code. Anyway, defining struct sb_registers
and ioremaping it would be nice solution (I didn't read code too
carefully, so maybye not in this particular case where registers
are 64bit width, but I definitely prefer it in board specific code
over read[bwl]/write[bwl]). Also readq/writeq seems mips specific,
so rants about portability doesn't apply.

	ladis
