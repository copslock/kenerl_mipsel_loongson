Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 05:49:03 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:58995 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0JPDtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Oct 2010 05:49:00 +0200
Received: by pxi12 with SMTP id 12so291035pxi.36
        for <linux-mips@linux-mips.org>; Fri, 15 Oct 2010 20:48:53 -0700 (PDT)
Received: by 10.142.237.4 with SMTP id k4mr1331851wfh.171.1287200932634;
        Fri, 15 Oct 2010 20:48:52 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id y42sm10906925wfd.10.2010.10.15.20.48.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 20:48:51 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 39A133C00E5; Fri, 15 Oct 2010 21:48:50 -0600 (MDT)
Date:   Fri, 15 Oct 2010 21:48:50 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:     Warner Losh <imp@bsdimp.com>, ddaney@caviumnetworks.com,
        prasun.kapoor@caviumnetworks.com, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
Message-ID: <20101016034850.GC21170@angua.secretlab.ca>
References: <4CB79D93.6090500@caviumnetworks.com>
 <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
 <20101014.191309.515504596.imp@bsdimp.com>
 <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2010 at 12:30:48PM -0500, David VomLehn (dvomlehn) wrote:
> If this is really a question of needing to dynamically generate the
> device tree, then you have no choice. It's worth mentioning, though,
> that the device tree compiler (dtc) does have the ability to include
> files, making it easier to create and maintain device trees that are
> static but which share devices.

Yes.  In fact, John Bonesio is working right now of polishing the last
details of this to allow for example a board-level .dts file to
include an SoC level .dts and add/remove/modify nodes as needed.
Should be sorted out in a week or two.  Once that is done then we'll
update the copy of dtc in the kernel (probably looking at the 2.6.38
timeframe realistically).

g.

> 
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> > mips.org] On Behalf Of Grant Likely
> > Sent: Thursday, October 14, 2010 6:29 PM
> > To: Warner Losh
> > Cc: ddaney@caviumnetworks.com; prasun.kapoor@caviumnetworks.com; linux-
> > mips@linux-mips.org; devicetree-discuss@lists.ozlabs.org
> > Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
> > 
> > On Thu, Oct 14, 2010 at 7:13 PM, Warner Losh <imp@bsdimp.com> wrote:
> > > In message: <AANLkTi=UM2p26JJMqv-
> > cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
> > >            Grant Likely <grant.likely@secretlab.ca> writes:
> > > : Overall the plan makes sense, however I would suggest the
> > following.
> > > : instead of 'live' modifying the tree, another option is to carry a
> > set
> > > : of 'stock' device trees in the kernel; one per board.  Of course
> > this
> > > : assumes that your current ad-hoc code is keying on the specific
> > board.
> > > :  If it is interpreting data provided by the firmware, then your
> > > : suggestion of modifying a single stock tree probably makes more
> > sense,
> > > : or possibly a combination of the too.  In general you should avoid
> > > : live modification as much as possible.
> > >
> > > The one draw back on this is that there's lots of different "stock"
> > > boards that the Cavium Octeon SDK supports.  These will be difficult
> > > to drag along for every kernel.  And they'd be mostly the same to,
> > > which is why I think that David is suggesting the live modification
> > > thing...
> > 
> > Okay.  Do what makes the most sense for your platform.
> > 
> > g.
> 
