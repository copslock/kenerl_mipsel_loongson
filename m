Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 19:33:30 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13534 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S870424AbSLFSdU>; Fri, 6 Dec 2002 19:33:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA03359;
	Fri, 6 Dec 2002 19:30:04 +0100 (MET)
Date: Fri, 6 Dec 2002 19:30:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <20021206172438.GJ23743@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1021206192349.26674T-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Dec 2002, Thiemo Seufer wrote:

> Maybe I wasn't clear about it, I meant kernels with 32 bit address
> space but 64 bit register width, allowing for userland N32 ABI.
> 
> E.g. the old DECstations with R4k CPU and limited memory would fit
> in this scheme. :-)

 I'm only going to support n64 on the DECstation.  You are welcomed to do
n32 stuff yourself if you want to. 

> >  Remember we are writing of the kernel -- we don't know what userland is
> > going to bring us
> 
> I don't understand this. The kernel _defines_ what the userland is allowed
> to do.

 I haven't considered you may mean crippling the available user address
space.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
