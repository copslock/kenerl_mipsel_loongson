Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 18:03:07 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:57051 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225242AbTENRDE>; Wed, 14 May 2003 18:03:04 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA01371;
	Wed, 14 May 2003 19:03:51 +0200 (MET DST)
Date: Wed, 14 May 2003 19:03:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
In-Reply-To: <20030514151212.GC8833@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030514181714.26213I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2003, Thiemo Seufer wrote:

> >  Why unfortunate?  You use "32" and "64" for normal stuff, and the rest
> > for special cases ("n32" isn't really 32-bit and "o64" isn't really 64-bit
> > -- both lie in the middle).
> 
> Exactly this is the sort of confusion which makes the naming unfortunate.
> -32 and -64 had never much to do with 32/64 bit but designate ABIs.

 Well, "32" is 32-bit address/data and "64" is 64-bit address/data. 
That's essentially pure 32-bit and 64-bit, respectively.  Of course some
data format has to be emitted by tools, so there has to be an ABI
associated with each of these variants. 

 And "n32" and "o64" are 32-bit address/64-bit data -- you can use 64-bit
data, e.g. in gas, but you cannot use 64-bit addressing, e.g. a
section/segment cannot be bigger than 4 GB. 

 The naming isn't consistent, indeed -- there could be, say:

- "32" for 32-bit support -- unambiguous, since there is only one
variation,

- "64" for 64-bit support -- requiring an additional option for selecting
the ABI, bailing out without one (or defaulting to a preconfigured ABI).

 Alternatively, there could be no "32" option -- tools configured for
"mips" would only emit 32-bit binaries and tools configured for "mips64" 
-- 64-bit and mixed ones, depending on one of the "64", "o64" and "n32"
options. 

 Of course all options could be renamed to avoid confusion.

> > Additional aliases of the "n64" and "o32"
> > form would make more confusion, IMHO. 
> 
> I disagree.

 I won't insist -- if people find this suitable for them, then it's great.
I won't use these additional aliases, so that's irrelevant for me.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
