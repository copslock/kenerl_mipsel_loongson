Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 10:35:59 +0000 (GMT)
Received: from jaguar.mkp.net ([IPv6:::ffff:192.139.46.146]:33419 "EHLO
	jaguar.mkp.net") by linux-mips.org with ESMTP id <S8225309AbUA2Kf7>;
	Thu, 29 Jan 2004 10:35:59 +0000
Received: from jes by jaguar.mkp.net with local (Exim 3.35 #1)
	id 1Am9WV-0001YN-00; Thu, 29 Jan 2004 05:35:47 -0500
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Kevin Paul Herbert <kph@cisco.com>, linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
References: <1075255111.8744.4.camel@shakedown>
	<20040128094032.GB900@kopretinka> <yq07jzcz6sp.fsf@wildopensource.com>
	<20040128150828.A19525@linux-mips.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 29 Jan 2004 05:35:47 -0500
In-Reply-To: <20040128150828.A19525@linux-mips.org>
Message-ID: <yq0znc79h4s.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@wildopensource.com
Precedence: bulk
X-list: linux-mips

>>>>> "Ladislav" == Ladislav Michl <ladis@linux-mips.org> writes:

Ladislav> On Wed, Jan 28, 2004 at 05:49:58AM -0500, Jes Sorensen
Ladislav> wrote:
>> If you are accessing memory mapped registers or memory on a PCI
>> device, ie. likely on a 1250, you *must* use the readX/__raw_readX
>> macros. Anybody just doing *reg = val on a PCI device should be
>> banned from writing code for life!

Ladislav> eh? I said nothing about PCI device. These ____raw_writeq
Ladislav> are used in board specific code. Anyway, defining struct
Ladislav> sb_registers and ioremaping it would be nice solution (I
Ladislav> didn't read code too carefully, so maybye not in this
Ladislav> particular case where registers are 64bit width, but I
Ladislav> definitely prefer it in board specific code over
Ladislav> read[bwl]/write[bwl]). Also readq/writeq seems mips
Ladislav> specific, so rants about portability doesn't apply.

Very wrong!

the readX/writeX macro names are for PCI and busses with similar
properties. One should never access anything through readX/writeX
without ioremaping it first.

readq/writeq are not mips specific, they are available on all/most 64
bit architectures, so portability rants do apply.

Jes
