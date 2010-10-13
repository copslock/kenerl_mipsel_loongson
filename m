Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 22:32:37 +0200 (CEST)
Received: from relais.videotron.ca ([24.201.245.36]:58193 "EHLO
        relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491123Ab0JMUce (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Oct 2010 22:32:34 +0200
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_biQp/CkVcPX5MQZ7DRo2Bg)"
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA800KVAX1ZG510@vl-mh-mrz21.ip.videotron.ca>; Wed,
 13 Oct 2010 16:32:24 -0400 (EDT)
Date:   Wed, 13 Oct 2010 16:32:31 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
X-X-Sender: nico@xanadu.home
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Gary King <gking@nvidia.com>,
        dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
In-reply-to: <AANLkTikinkyEu-ozyiHOhr1D4ZLwv0jZwbk=4jq_YM9J@mail.gmail.com>
Message-id: <alpine.LFD.2.00.1010131627220.2764@xanadu.home>
References: <f3f140ca90dc9dac2f645748bc3a0150@localhost>
 <20101013075346.GA24052@linux-mips.org>
 <AANLkTikinkyEu-ozyiHOhr1D4ZLwv0jZwbk=4jq_YM9J@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Return-Path: <nico@fluxnic.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nico@fluxnic.net
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_biQp/CkVcPX5MQZ7DRo2Bg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 13 Oct 2010, Kevin Cernekee wrote:

> On Wed, Oct 13, 2010 at 12:53 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > It's this disabling of interrupts which I don't like.  It's easy to get
> > around it by having one kmap type for each of process, softirq and
> > interrupt context.
> 
> I am curious as to why ARM opted for the "pte push/pop" strategy
> (kmap_high_l1_vipt()) instead of something along these lines?
> 
> Is there a reason why using 3 kmap types to solve the "interrupted
> flush problem" would work for MIPS, but is not a good solution on ARM?

It would probably be a good solution for ARM as well.


Nicolas

--Boundary_(ID_biQp/CkVcPX5MQZ7DRo2Bg)--
