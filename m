Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:33:37 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:37699 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870562AbaA0UZU0-qpQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 21:25:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 7F7D521B8B1;
        Mon, 27 Jan 2014 22:25:18 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id famKgLZ7ivUu; Mon, 27 Jan 2014 22:25:13 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 541605BC015;
        Mon, 27 Jan 2014 22:25:11 +0200 (EET)
Date:   Mon, 27 Jan 2014 22:24:35 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: i8042-io - Exclude mips platforms when
 allocating/deallocating IO regions.
Message-ID: <20140127202435.GA589@drone.musicnaut.iki.fi>
References: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
 <20140126214952.GD18840@core.coreip.homeip.net>
 <E2EE47005FA75F44B80E1019FDD2EBBB6E38B06D@BADAG02.ba.imgtec.org>
 <20140127065638.GB11945@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140127065638.GB11945@core.coreip.homeip.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

On Sun, Jan 26, 2014 at 10:56:38PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 27, 2014 at 12:32:36AM +0000, Raghu Gandham wrote:
> > > On Sat, Jan 25, 2014 at 11:01:54AM -0800, Raghu Gandham wrote:
> > > > The standard IO regions are already reserved by the platform code on
> > > > most MIPS devices(malta, cobalt, sni). The Commit
> > > > 197a1e96c8be5b6005145af3a4c0e45e2d651444
> > > > ("Input: i8042-io - fix up region handling on MIPS") introduced a bug
> > > > on these MIPS platforms causing i8042 driver to fail when trying to
> > > > reserve IO ports.
> > > > Prior to the above mentioned commit request_region is skipped on MIPS
> > > > but release_region is called.
> > > >
> > > > This patch reverts commit 197a1e96c8be5b6005145af3a4c0e45e2d651444
> > > > and also avoids calling release_region for MIPS.
> > > 
> > > The problem is that IO regions are reserved on _most_, but not _all_
> > > devices.
> > > MIPS should figure out what they want to do with i8042 registers and be
> > > consistent on all devices.
> > 
> > Please examine the attached patch which went upstream in April of 2004.
> > Since then it had been a convention not to call request_region routine in
> > i8042 for MIPS. The attached patch had a glitch that it guarded
> > request_region in i8042-io.h but skipped guarding release_region in
> > i8042-io.h. I believe that the issue Aaro saw was due to this 
> > glitch. Below is the error quoted in Aaro's commit message.
> > 
> >     [    2.112000] Trying to free nonexistent resource <0000000000000060-000000000000006f>
> > 
> > My patch reinstates the convention followed on MIPS devices along with
> > fixing Aaro's issue.
> 
> I assume that Aaro did test his patch and on his box request_region()
> succeeds. That would indicate that various MIPS sub-arches still not
> settled on the topic.

request_region() succeeds on Loongson and OCTEON.

On OCTEONs without PCI, request_region() will fail which is correct as
there is no I/O space.

I wasn't aware of that 2004 patch (it pre-dates GIT history of mainline
Linux). Why the regions are already reserved by the platform code?

A.
