Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 08:39:23 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:50887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491012Ab0JPGiQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 08:38:16 +0200
Received: by ozlabs.org (Postfix, from userid 1007)
        id CD710B70EF; Sat, 16 Oct 2010 17:38:13 +1100 (EST)
Date:   Sat, 16 Oct 2010 17:24:41 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        prasun.kapoor@caviumnetworks.com, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
Message-ID: <20101016062441.GB5036@yookeroo>
References: <4CB79D93.6090500@caviumnetworks.com>
 <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
 <20101014.191309.515504596.imp@bsdimp.com>
 <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
 <4CB89275.8020502@caviumnetworks.com>
 <7A9214B0DEB2074FBCA688B30B04400D01B50924@XMB-RCD-208.cisco.com>
 <20101016034548.GB21170@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101016034548.GB21170@angua.secretlab.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <dgibson@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2010 at 09:45:48PM -0600, Grant Likely wrote:
> [reorganized quoting]
> On Fri, Oct 15, 2010 at 12:48:55PM -0500, David VomLehn (dvomlehn) wrote:
> > 
> > David Daney wrote:
> > > On 10/15/2010 10:30 AM, David VomLehn (dvomlehn) wrote:
> > > 
> > > > If this is really a question of needing to dynamically generate the
> > > > device tree, then you have no choice. It's worth mentioning, though,
> > > > that the device tree compiler (dtc) does have the ability to include
> > > > files, making it easier to create and maintain device trees that are
> > > > static but which share devices.
> > > 
> > > Some experimentation will be necessary.  We will have to patch in some
> > > properties like the Ethernet MAC address as that is stored in a
> > > separate eeprom.  Also some boards have pluggable I/O modules, so we
> > > may not know at dtb generation time what is there.
> 
> If it touches firmware, then you'll need to be careful about getting
> painted into a corner with an over-complex boot firmware design, but
> yet this sounds like an appropriate approach.
> 
> > We're in much the same situation. Almost all of the device tree is
> > static, but we add on/overwrite little bits. I'm not the device tree
> > expert, but if I understand correctly, you can even have dtc emit labels
> > that you can reference to make the fix-up simpler.
> 
> The labels are not available at runtime, but properties in the
> 'aliases' node can (and should) be used to avoid having to depend on
> the full path to a device node.  It has been on my to-do list for a
> while to add automatic parsing of aliases when finding a node by full
> path.

Well.. the labels can be available at runtime, but only if you use
dtc's "asm" output mode and link the resulting asm code into your
kernel.  There are situations where this is a good approach, but I
suspect yours is not one of them.

libfdt already automatically expands aliases when locating a node by
full path.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
