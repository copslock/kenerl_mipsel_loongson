Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 18:09:43 +0000 (GMT)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:30479 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225223AbTCMSJm> convert rfc822-to-8bit; Thu, 13 Mar 2003 18:09:42 +0000
Received: from 10.3.12.12 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Thu, 13 Mar 2003 10:09:04 -0800
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: Disabling lwl and lwr instruction generation
Date: Thu, 13 Mar 2003 10:09:03 -0800
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB07968241@ex-eng-corp.efi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disabling lwl and lwr instruction generation
Thread-Index: AcLpAJ3NhIG4bZ4lTiedoyVdN97f4gAigrvw
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: "Ralf Baechle" <ralf@linux-mips.org>,
	"Richard Hodges" <rh@matriplex.com>
Cc: <linux-mips@linux-mips.org>
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

From the gcc sources, the compiler generates the lwl,lwr etc. in the block move code in gcc/config/mips/mips.c ( output_block_move ). 

There is an option -mmemcpy which tells gcc to use a memcpy compiled in with the sources for this block move instead of gcc genetrating code. The problem however with this is that arch/mips/lib/memcpy.S is optimized using lwl,lwr,swl,swr. If this can be  modified so that lwl,lwr,swl,swr is used if enabled as a kernel option, it might work very well. 

Any ideas / suggestions?

Thanks

Ranjan

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Wednesday, March 12, 2003 5:34 PM
To: Richard Hodges
Cc: Ranjan Parthasarathy; 'linux-mips@linux-mips.org'
Subject: Re: Disabling lwl and lwr instruction generation


On Wed, Mar 12, 2003 at 04:50:53PM -0800, Richard Hodges wrote:

> I got lwl and lwr from a memcpy() with two void pointers...
> 
> I quickly changed those to the (aligned) structure pointers instead, and
> then memcpy() changed to ordinary word loads and stores.
> 
> So, is somebody starting a toolchain for that new Chinese CPU? :-)

Wouldn't be the first processor without lwl/lwr instructions.  There have
been a few that didn't implement it for silly bean^Wgate counting issues
others have done it for patent and licensing reasons.

(Afair MIPS's patent is about to expire and IBM's prior art patent in the
same area is even way older but that legalese ...)

  Ralf
