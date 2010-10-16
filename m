Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 05:46:02 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:43736 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0JPDp6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Oct 2010 05:45:58 +0200
Received: by pwi2 with SMTP id 2so524304pwi.36
        for <linux-mips@linux-mips.org>; Fri, 15 Oct 2010 20:45:51 -0700 (PDT)
Received: by 10.142.204.14 with SMTP id b14mr1312456wfg.286.1287200751230;
        Fri, 15 Oct 2010 20:45:51 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id x35sm9452520wfd.1.2010.10.15.20.45.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 20:45:50 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 9684A3C00E5; Fri, 15 Oct 2010 21:45:48 -0600 (MDT)
Date:   Fri, 15 Oct 2010 21:45:48 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Warner Losh <imp@bsdimp.com>, prasun.kapoor@caviumnetworks.com,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
Message-ID: <20101016034548.GB21170@angua.secretlab.ca>
References: <4CB79D93.6090500@caviumnetworks.com>
 <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
 <20101014.191309.515504596.imp@bsdimp.com>
 <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
 <4CB89275.8020502@caviumnetworks.com>
 <7A9214B0DEB2074FBCA688B30B04400D01B50924@XMB-RCD-208.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D01B50924@XMB-RCD-208.cisco.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

[reorganized quoting]
On Fri, Oct 15, 2010 at 12:48:55PM -0500, David VomLehn (dvomlehn) wrote:
> 
> David Daney wrote:
> > On 10/15/2010 10:30 AM, David VomLehn (dvomlehn) wrote:
> > 
> > > If this is really a question of needing to dynamically generate the
> > > device tree, then you have no choice. It's worth mentioning, though,
> > > that the device tree compiler (dtc) does have the ability to include
> > > files, making it easier to create and maintain device trees that are
> > > static but which share devices.
> > 
> > Some experimentation will be necessary.  We will have to patch in some
> > properties like the Ethernet MAC address as that is stored in a
> > separate eeprom.  Also some boards have pluggable I/O modules, so we
> > may not know at dtb generation time what is there.

If it touches firmware, then you'll need to be careful about getting
painted into a corner with an over-complex boot firmware design, but
yet this sounds like an appropriate approach.

> We're in much the same situation. Almost all of the device tree is
> static, but we add on/overwrite little bits. I'm not the device tree
> expert, but if I understand correctly, you can even have dtc emit labels
> that you can reference to make the fix-up simpler.

The labels are not available at runtime, but properties in the
'aliases' node can (and should) be used to avoid having to depend on
the full path to a device node.  It has been on my to-do list for a
while to add automatic parsing of aliases when finding a node by full
path.

g.
