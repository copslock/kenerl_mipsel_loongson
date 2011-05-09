Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 16:27:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58610 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491064Ab1EIO1e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 16:27:34 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p49ESTYv012443;
        Mon, 9 May 2011 15:28:29 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p49ESSiD012440;
        Mon, 9 May 2011 15:28:28 +0100
Date:   Mon, 9 May 2011 15:28:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>,
        rdsandiford@googlemail.com
Subject: Re: RFC: A new MIPS64 ABI
Message-ID: <20110509142828.GA7196@linux-mips.org>
References: <4D5990A4.2050308__41923.1521235362$1297715435$gmane$org@caviumnetworks.com>
 <87hbbxqihm.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hbbxqihm.fsf@firetop.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 21, 2011 at 07:45:41PM +0000, Richard Sandiford wrote:

> David Daney <ddaney@caviumnetworks.com> writes:
> > Background:
> >
> > Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
> > user virtual memory space.  This is due the way MIPS32 memory space is
> > segmented.  Only the range from 0..2^31-1 is available.  Pointer
> > values are always sign extended.
> >
> > Because there are not already enough MIPS ABIs, I present the ...
> >
> > Proposal: A new ABI to support 4GB of address space with 32-bit
> > pointers.
> 
> FWIW, I'd be happy to see this go into GCC.

So am I for the kernel primarily because it's not really a new ABI but
an enhancement of the existing N32 ABI.

  Ralf
