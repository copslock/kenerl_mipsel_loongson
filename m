Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 09:37:19 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5147
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225211AbUKVJhP>; Mon, 22 Nov 2004 09:37:15 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CWAdG-0002Qj-00; Mon, 22 Nov 2004 10:37:14 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CWAdG-0001rz-00; Mon, 22 Nov 2004 10:37:14 +0100
Date: Mon, 22 Nov 2004 10:37:14 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Improve o32 syscall handling
Message-ID: <20041122093714.GC902@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122061854.GA25433@linux-mips.org> <20041122070003.GA902@rembrandt.csv.ica.uni-stuttgart.de> <20041122071313.GC25433@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122071313.GC25433@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Nov 22, 2004 at 08:00:04AM +0100, Thiemo Seufer wrote:
> 
> > > Why bother, the unaligned exception handler should take care of this.
> > 
> > It really does so for unaligned accesses from kernel space?
> 
> Yes.  In fact it's crucially important for this very case.

Ok, I'll update the patch accordingly when I'm back to better
connectivity than I have now.

[snip]
> > has 4 bytes and is loaded with lw. Using a macro which abstracts for
> > 32/64bit compilation hides this needlessly, and can even lead to the
> > erraneous impression the code would be useful for 64bit, too.
> 
> I'm more following the religion of using such abstractions everywhere
> because code tends to be copied around mindlessly ...

I would agree if there was a roughly similiar 64bit version of the code.
But due to the differences between 32bit and 64bit kernel there will
never be one, so it's IMHO best to make them as distinct as reasonable
in this case.


Thiemo
