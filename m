Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 15:03:34 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:24850 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225395AbVBWPDT>; Wed, 23 Feb 2005 15:03:19 +0000
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j1N3f1Hi009272;
	Tue, 22 Feb 2005 22:41:01 -0500
In-Reply-To: <1109160313.16445.20.camel@localhost.localdomain>
References: <1109157737.16445.6.camel@localhost.localdomain> <000301c5199d$3154ad40$0300a8c0@Exterity.local> <1109160313.16445.20.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: Big Endian au1550
Date:	Wed, 23 Feb 2005 10:03:01 -0500
To:	JP Foster <jp.foster@exterity.co.uk>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Feb 23, 2005, at 7:05 AM, JP Foster wrote:

> Fair enough. Has anyone got big-endian au1xxx working ever?

The only issues with big endian Au1xxx is the USB and potentially
PCI.  There have been recent patches posted for USB that could
fix this.  The PCI problem is with the read/write/in/out macros.
They were never written properly and I haven't checked to see
if this was corrected in 2.6.

That aside, I have worked on several big endian Au1xxx projects
that are successful.  I never found a way, aside from #ifdefs for
byte sex in generic files, to make the same source compile in
either mode.  It's a fairly low priority on my list of other Au1xxx 
projects :-)

The Linux sources have worked, and if they currently don't we
should fix them.


	-- Dan
