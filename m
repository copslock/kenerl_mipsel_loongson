Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 23:04:17 +0200 (CEST)
Received: from ns.suse.de ([213.95.15.193]:23569 "EHLO Cantor.suse.de")
	by linux-mips.org with ESMTP id <S1123903AbSJNVER>;
	Mon, 14 Oct 2002 23:04:17 +0200
Received: from Hermes.suse.de (Charybdis.suse.de [213.95.15.201])
	by Cantor.suse.de (Postfix) with ESMTP
	id B7E79145E1; Mon, 14 Oct 2002 23:04:10 +0200 (MEST)
Date: Mon, 14 Oct 2002 23:04:06 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	<rsandifo@redhat.com>, <linux-mips@linux-mips.org>,
	<gcc@gcc.gnu.org>, <binutils@sources.redhat.com>
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <orwuokzs9k.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.33.0210142301560.20702-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <matz@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matz@suse.de
Precedence: bulk
X-list: linux-mips

Hi,

On 14 Oct 2002, Alexandre Oliva wrote:

> > If gcc just emits
>
> > 	bne     $2,$0,$L7493
> > 	j       $L2
>
> IIRC, that's exactly what GCC will emit if you don't tell it to try to
> fill delay slots.  If it tries to fill delay slots and fails, I doubt
> the assembler is going to succeed at that.

I think that isn't hj's point.  He wanta gas to take advantage of
relaxation, and gcc is hindering that for no good reason.  I admit I have
no idea of Mips, though, so I don't know if relaxation somehow is
depending on delay slot filling at all ;-)


Ciao,
Michael.
