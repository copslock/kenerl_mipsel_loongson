Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 06:56:22 +0100 (BST)
Received: from vanessarodrigues.com ([IPv6:::ffff:192.139.46.150]:48520 "EHLO
	jaguar.mkp.net") by linux-mips.org with ESMTP id <S8225226AbUJTF4R>;
	Wed, 20 Oct 2004 06:56:17 +0100
Received: by jaguar.mkp.net (Postfix, from userid 1655)
	id C907A286D23; Wed, 20 Oct 2004 01:56:02 -0400 (EDT)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
References: <416DE31E.90509@mvista.com>
	<20041014191754.GB30516@linux-mips.org>
	<Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl>
	<416EFBAB.8050600@mvista.com>
	<Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
	<20041014225553.GA13597@linux-mips.org>
	<Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl>
	<yq0zn2ks9em.fsf@jaguar.mkp.net>
	<20041018191507.GA14440@linux-mips.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 20 Oct 2004 01:56:02 -0400
In-Reply-To: <20041018191507.GA14440@linux-mips.org>
Message-ID: <yq0pt3erkzx.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@wildopensource.com
Precedence: bulk
X-list: linux-mips

>>>>> "Ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

Ralf> On Mon, Oct 18, 2004 at 04:44:17AM -0400, Jes Sorensen wrote:
>> Dual address cycles, ie. 64 bit addressing is fscked on the 1250
>> from what I remember. Correct way to work around this is to stick
>> all physical memory outside the 32 bit space into ZONE_HIGHMEM -
>> had a patch for 2.4, but I lost it ages ago ;-(

Ralf> The Momentum Jaguar suffers from similar problems, so I've
Ralf> implemented that for Linux 2.6 as CONFIG_LIMITED_DMA.

Wouldn't it be better to always have the highmem zone configured and
then just fill it up with pages if you have a b0rked platform? The
cost of this is miniscule.

>> One can just hope Broadcom will learn how to make chips some day
>> ;-(

Ralf> Well, they've just done their homework, also known as the 1450.
Ralf> Pick your red pen and give grades ;-)

The moment I receive one in my mailbox ;-)

Cheers,
Jes
