Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 19:49:08 +0200 (CEST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:61414 "EHLO
        rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491837Ab0JORtE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 19:49:04 +0200
Authentication-Results: rtp-iport-2.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHMwuEytJV2b/2dsb2JhbAChJHGjZ5xehUkEhFSFB4N5
X-IronPort-AV: E=Sophos;i="4.57,337,1283731200"; 
   d="scan'208";a="171171010"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rtp-iport-2.cisco.com with ESMTP; 15 Oct 2010 17:48:56 +0000
Received: from xbh-rcd-101.cisco.com (xbh-rcd-101.cisco.com [72.163.62.138])
        by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id o9FHmuvE004097;
        Fri, 15 Oct 2010 17:48:56 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-101.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 12:48:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Device Tree questions WRT MIPS/Octeon SOCs.
Date:   Fri, 15 Oct 2010 12:48:55 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D01B50924@XMB-RCD-208.cisco.com>
In-Reply-To: <4CB89275.8020502@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Device Tree questions WRT MIPS/Octeon SOCs.
Thread-Index: ActskE8vd9TjQebmTqGwbJeCFGF5zgAALYxw
References: <4CB79D93.6090500@caviumnetworks.com> <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com> <20101014.191309.515504596.imp@bsdimp.com> <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com> <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com> <4CB89275.8020502@caviumnetworks.com>
From:   "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
Cc:     "Grant Likely" <grant.likely@secretlab.ca>,
        "Warner Losh" <imp@bsdimp.com>, <prasun.kapoor@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, <devicetree-discuss@lists.ozlabs.org>
X-OriginalArrivalTime: 15 Oct 2010 17:48:56.0392 (UTC) FILETIME=[3D410480:01CB6C91]
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

We're in much the same situation. Almost all of the device tree is
static, but we add on/overwrite little bits. I'm not the device tree
expert, but if I understand correctly, you can even have dtc emit labels
that you can reference to make the fix-up simpler.

> -----Original Message-----
> From: David Daney [mailto:ddaney@caviumnetworks.com]
> Sent: Friday, October 15, 2010 10:42 AM
> To: David VomLehn (dvomlehn)
> Cc: Grant Likely; Warner Losh; prasun.kapoor@caviumnetworks.com;
linux-
> mips@linux-mips.org; devicetree-discuss@lists.ozlabs.org
> Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
> 
> On 10/15/2010 10:30 AM, David VomLehn (dvomlehn) wrote:
> 
> > If this is really a question of needing to dynamically generate the
> > device tree, then you have no choice. It's worth mentioning, though,
> > that the device tree compiler (dtc) does have the ability to include
> > files, making it easier to create and maintain device trees that are
> > static but which share devices.
> 
> Some experimentation will be necessary.  We will have to patch in some
> properties like the Ethernet MAC address as that is stored in a
> separate eeprom.  Also some boards have pluggable I/O modules, so we
> may not know at dtb generation time what is there.
> 
> David Daney
> 
> 
> >> -----Original Message-----
> >> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-
> bounce@linux-
> >> mips.org] On Behalf Of Grant Likely
> >> Sent: Thursday, October 14, 2010 6:29 PM
> >> To: Warner Losh
> >> Cc: ddaney@caviumnetworks.com; prasun.kapoor@caviumnetworks.com;
> linux-
> >> mips@linux-mips.org; devicetree-discuss@lists.ozlabs.org
> >> Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
> >>
> >> On Thu, Oct 14, 2010 at 7:13 PM, Warner Losh<imp@bsdimp.com>
wrote:
> >>> In message:<AANLkTi=UM2p26JJMqv-
> >> cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
> >>>             Grant Likely<grant.likely@secretlab.ca>  writes:
> >>> : Overall the plan makes sense, however I would suggest the
> >> following.
> >>> : instead of 'live' modifying the tree, another option is to carry
> a
> >> set
> >>> : of 'stock' device trees in the kernel; one per board.  Of course
> >> this
> >>> : assumes that your current ad-hoc code is keying on the specific
> >> board.
> >>> :  If it is interpreting data provided by the firmware, then your
> >>> : suggestion of modifying a single stock tree probably makes more
> >> sense,
> >>> : or possibly a combination of the too.  In general you should
> avoid
> >>> : live modification as much as possible.
> >>>
> >>> The one draw back on this is that there's lots of different
"stock"
> >>> boards that the Cavium Octeon SDK supports.  These will be
> difficult
> >>> to drag along for every kernel.  And they'd be mostly the same to,
> >>> which is why I think that David is suggesting the live
modification
> >>> thing...
> >>
> >> Okay.  Do what makes the most sense for your platform.
> >>
> >> g.
> >
> >
