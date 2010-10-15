Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 19:31:03 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:8703 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab0JORa6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 19:30:58 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHYsuEytJV2b/2dsb2JhbAChJHGjepxfhUkEhFSFB4N5
X-IronPort-AV: E=Sophos;i="4.57,337,1283731200"; 
   d="scan'208";a="170954699"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rtp-iport-1.cisco.com with ESMTP; 15 Oct 2010 17:30:49 +0000
Received: from xbh-rcd-202.cisco.com (xbh-rcd-202.cisco.com [72.163.62.201])
        by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id o9FHUnsO030422;
        Fri, 15 Oct 2010 17:30:49 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-202.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 12:30:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Device Tree questions WRT MIPS/Octeon SOCs.
Date:   Fri, 15 Oct 2010 12:30:48 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
In-Reply-To: <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Device Tree questions WRT MIPS/Octeon SOCs.
Thread-Index: ActsCHyzufODr76eQ+uEjV45kXfTVAAhOMUA
References: <4CB79D93.6090500@caviumnetworks.com> <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com> <20101014.191309.515504596.imp@bsdimp.com> <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
From:   "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:     "Grant Likely" <grant.likely@secretlab.ca>,
        "Warner Losh" <imp@bsdimp.com>
Cc:     <ddaney@caviumnetworks.com>, <prasun.kapoor@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, <devicetree-discuss@lists.ozlabs.org>
X-OriginalArrivalTime: 15 Oct 2010 17:30:49.0808 (UTC) FILETIME=[B5997500:01CB6C8E]
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

If this is really a question of needing to dynamically generate the device tree, then you have no choice. It's worth mentioning, though, that the device tree compiler (dtc) does have the ability to include files, making it easier to create and maintain device trees that are static but which share devices.

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Grant Likely
> Sent: Thursday, October 14, 2010 6:29 PM
> To: Warner Losh
> Cc: ddaney@caviumnetworks.com; prasun.kapoor@caviumnetworks.com; linux-
> mips@linux-mips.org; devicetree-discuss@lists.ozlabs.org
> Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
> 
> On Thu, Oct 14, 2010 at 7:13 PM, Warner Losh <imp@bsdimp.com> wrote:
> > In message: <AANLkTi=UM2p26JJMqv-
> cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
> >            Grant Likely <grant.likely@secretlab.ca> writes:
> > : Overall the plan makes sense, however I would suggest the
> following.
> > : instead of 'live' modifying the tree, another option is to carry a
> set
> > : of 'stock' device trees in the kernel; one per board.  Of course
> this
> > : assumes that your current ad-hoc code is keying on the specific
> board.
> > :  If it is interpreting data provided by the firmware, then your
> > : suggestion of modifying a single stock tree probably makes more
> sense,
> > : or possibly a combination of the too.  In general you should avoid
> > : live modification as much as possible.
> >
> > The one draw back on this is that there's lots of different "stock"
> > boards that the Cavium Octeon SDK supports.  These will be difficult
> > to drag along for every kernel.  And they'd be mostly the same to,
> > which is why I think that David is suggesting the live modification
> > thing...
> 
> Okay.  Do what makes the most sense for your platform.
> 
> g.
