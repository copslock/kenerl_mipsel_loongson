Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 18:24:37 +0000 (GMT)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:60603
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8224827AbTCZSYg>; Wed, 26 Mar 2003 18:24:36 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7) with ESMTP id h2QJcRYf000388;
	Wed, 26 Mar 2003 19:38:27 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7/Submit) id h2QJcPau000386;
	Wed, 26 Mar 2003 19:38:25 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Relative Checksum
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20030326191601.A19939@linux-mips.org>
References: <1048667601.7d003520yaelgilad@myrealbox.com>
	 <20030326191601.A19939@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048707504.31837.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 19:38:24 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2003-03-26 at 18:16, Ralf Baechle wrote:
> On Wed, Mar 26, 2003 at 08:33:21AM +0000, Gilad Benjamini wrote:
> 
> > ip_fast_csum provides an asm version for IP checksum.
> > Any available mips-asm implementation out there for 
> > a relative checksum?
> > 
> > i.e. I get a packet, change
> > a field or two, and want to compute just the 
> > change in the checksum.
> 
> I suggest to look at the code for IP masquerading which already does things
> like this when rewriting packets.

Also read the RFC material on the danger of relative checksum updates.
There are a couple of interesting gotcha's with some stacks
