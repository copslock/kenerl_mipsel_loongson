Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 20:01:42 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:36575 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S870705AbSLFTBd>; Fri, 6 Dec 2002 20:01:33 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA03902;
	Fri, 6 Dec 2002 19:58:26 +0100 (MET)
Date: Fri, 6 Dec 2002 19:58:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <20021206184133.GL23743@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1021206194914.3424A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Dec 2002, Thiemo Seufer wrote:

> >  I'm only going to support n64 on the DECstation.  You are welcomed to do
> > n32 stuff yourself if you want to. 
> 
> What does N64 on the DECstation better than N32 could do? N32 has
> more compact code, better cache usage and less memory consumption.

 Well, as you probably noticed, the DECstation is not a performance
screamer anymore.  If I needed a fast system, I'd use something else.  I
need a reference platform, though, even if it costs performance.

> >  I haven't considered you may mean crippling the available user address
> > space.
> 
> IIRC is the maximum of RAM 448 MB on some machines. Actually utilizing

 For the record, it's 480MB, actually (15 * 32MB). 

> an user address space larger than 2 GB would mean a RAM/Swap ratio of
> about 1:4, IOW, it likely gets unusable slow.

 That depends on the utility of swap -- it's usually slow, although not
always. 

> Is there any point besides of hack value to use N64 on these machines?

 Probably not.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
