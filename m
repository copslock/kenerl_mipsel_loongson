Received:  by oss.sgi.com id <S553916AbQJaVoo>;
	Tue, 31 Oct 2000 13:44:44 -0800
Received: from u-142.karlsruhe.ipdial.viaginterkom.de ([62.180.10.142]:43532
        "EHLO u-142.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553845AbQJaVo0>; Tue, 31 Oct 2000 13:44:26 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869089AbQJaUOb>;
        Tue, 31 Oct 2000 21:14:31 +0100
Date:   Tue, 31 Oct 2000 21:14:31 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
Message-ID: <20001031211431.C28909@bacchus.dhis.org>
References: <20001030151736.C2687@paradigm.rfc822.org> <39FDB50A.4919D84E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39FDB50A.4919D84E@mvista.com>; from jsun@mvista.com on Mon, Oct 30, 2000 at 09:51:06AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 09:51:06AM -0800, Jun Sun wrote:

> > Could
> > there be a runtime linking thing with a cpu detection wether we
> > have ll/sc or not ?
> 
> This is a wonderful idea.  It should incorporate into future MIPS CPU
> support structure.

But what is the better alternative?  Emulating ll/sc is a generic facility.
Aside of making that more efficient the only idea I have is putting entire
atomic operations into the kernel such that the standard case should result
in at most one exception to be handled in the kernel.

Btw, could somebody put a counter into the ll/sc emulator and test how
often it gets called on a R3000 machine?

  Ralf
