Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 18:50:57 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:43688
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225242AbTENRuz>; Wed, 14 May 2003 18:50:55 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19G0OJ-001ESI-00; Wed, 14 May 2003 19:50:11 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19G0OJ-00047G-00; Wed, 14 May 2003 19:50:11 +0200
Date: Wed, 14 May 2003 19:50:11 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030514175011.GD8833@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030514151212.GC8833@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030514181714.26213I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030514181714.26213I-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> On Wed, 14 May 2003, Thiemo Seufer wrote:
> 
> > >  Why unfortunate?  You use "32" and "64" for normal stuff, and the rest
> > > for special cases ("n32" isn't really 32-bit and "o64" isn't really 64-bit
> > > -- both lie in the middle).
> > 
> > Exactly this is the sort of confusion which makes the naming unfortunate.
> > -32 and -64 had never much to do with 32/64 bit but designate ABIs.
> 
>  Well, "32" is 32-bit address/data and "64" is 64-bit address/data. 
> That's essentially pure 32-bit and 64-bit, respectively.  Of course some
> data format has to be emitted by tools, so there has to be an ABI
> associated with each of these variants. 

That's just backwards. An ABI defines much more, e.g. calling
conventions and GOT sizes. The register size is just another
property of the ABI.

> And "n32" and "o64" are 32-bit address/64-bit data -- you can use 64-bit
> data, e.g. in gas, but you cannot use 64-bit addressing, e.g. a
> section/segment cannot be bigger than 4 GB. 
> 
>  The naming isn't consistent, indeed -- there could be, say:
> 
> - "32" for 32-bit support -- unambiguous, since there is only one
> variation,

This assumption fails if there will ever be an improved 32bit ABI with
e.g. NewABI calling conventions, as the MEABI tried some time ago.

> - "64" for 64-bit support -- requiring an additional option for selecting
> the ABI, bailing out without one (or defaulting to a preconfigured ABI).

Argh! Once again, the _ABI_ defines if it supports 64bit. For an
ABI-compliant system, there's no point in having a register-size
selection option.

>  Alternatively, there could be no "32" option -- tools configured for
> "mips" would only emit 32-bit binaries

What is a "32-bit binary"? o32, EABI, MEABI or another
yet-to-be-invented one?

> and tools configured for "mips64" 
> -- 64-bit and mixed ones, depending on one of the "64", "o64" and "n32"
> options. 

What's desireable here depends on the target system. For Linux,
the current way is IMHO the best: o32 only for mips-linux, and
o32, n32 and n64 for mips64-linux, with n32 as default.
o64 isn't useful for Linux, and only interesting for backward
compatibility elsewhere.


Thiemo
