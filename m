Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 18:16:06 +0000 (GMT)
Received: from p508B68B0.dip.t-dialin.net ([IPv6:::ffff:80.139.104.176]:43706
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224827AbTCZSQF>; Wed, 26 Mar 2003 18:16:05 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2QIG1I19987;
	Wed, 26 Mar 2003 19:16:01 +0100
Date: Wed, 26 Mar 2003 19:16:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Relative Checksum
Message-ID: <20030326191601.A19939@linux-mips.org>
References: <1048667601.7d003520yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048667601.7d003520yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Wed, Mar 26, 2003 at 08:33:21AM +0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 26, 2003 at 08:33:21AM +0000, Gilad Benjamini wrote:

> ip_fast_csum provides an asm version for IP checksum.
> Any available mips-asm implementation out there for 
> a relative checksum?
> 
> i.e. I get a packet, change
> a field or two, and want to compute just the 
> change in the checksum.

I suggest to look at the code for IP masquerading which already does things
like this when rewriting packets.

  Ralf
