Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 00:16:58 +0100 (BST)
Received: from 205-200-7-228.static.mts.net ([IPv6:::ffff:205.200.7.228]:57871
	"EHLO librestream.com") by linux-mips.org with ESMTP
	id <S8225938AbVD1XQo> convert rfc822-to-8bit; Fri, 29 Apr 2005 00:16:44 +0100
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: iptables/vmalloc issues on alchemy
Date:	Thu, 28 Apr 2005 18:16:36 -0500
Message-ID: <8230E1CC35AF9F43839F3049E930169A137236@yang.LibreStream.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: iptables/vmalloc issues on alchemy
thread-index: AcVMP/eWlU8Fu2RfT3y2gnsK31YrNwACB8mw
From:	"Christian Gan" <christian.gan@librestream.com>
To:	"Dan Malek" <dan@embeddedalley.com>
Cc:	"Josh Green" <jgreen@users.sourceforge.net>,
	"Herbert Valerio Riedel" <hvr@hvrlab.org>,
	<linux-mips@linux-mips.org>,
	"Pete Popov" <ppopov@embeddedalley.com>
Return-Path: <christian.gan@librestream.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christian.gan@librestream.com
Precedence: bulk
X-list: linux-mips

Sorry, I should have been more clear:  The little test module I created
worked without CONFIG_64BIT_PHYS_ADDR, I realize that it would fail for
the PCI device though.

Thanks!

Christian

-----Original Message-----
From: Dan Malek [mailto:dan@embeddedalley.com] 
Sent: Thursday, April 28, 2005 5:17 PM
To: Christian Gan
Cc: Josh Green; Herbert Valerio Riedel; linux-mips@linux-mips.org; Pete
Popov
Subject: Re: iptables/vmalloc issues on alchemy


On Apr 28, 2005, at 5:22 PM, Christian Gan wrote:

> ..... Again it would be okay if I used
> kmalloc or if I disabled CONFIG_64BIT_PHYS_ADDR.

An Au1500 or Au1550 isn't likely to work with this disabled.
PCI and other peripherals exist in the 36-bit space, unless you
disable them.  I suspect all of this got broken with the dynamic
exception handler building.  Prior to that, I suspect it works
fine.  I guess we need to do some regression testing ....

Thanks.


	-- Dan
