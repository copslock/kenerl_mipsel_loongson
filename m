Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 17:55:05 +0100 (BST)
Received: from fed1rmmtao11.cox.net ([IPv6:::ffff:68.230.241.28]:17284 "EHLO
	fed1rmmtao11.cox.net") by linux-mips.org with ESMTP
	id <S8225347AbUJOQy5>; Fri, 15 Oct 2004 17:54:57 +0100
Received: from liberty.homelinux.org ([68.2.43.39]) by fed1rmmtao11.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041015165439.DGMX17415.fed1rmmtao11.cox.net@liberty.homelinux.org>;
          Fri, 15 Oct 2004 12:54:39 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id JAA01762;
	Fri, 15 Oct 2004 09:54:38 -0700
Date: Fri, 15 Oct 2004 09:54:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Karl Lessard <klessard@sunrisetelecom.com>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: Duplicated allocation in AU1xxx OHCI driver
Message-ID: <20041015095437.A1500@home.com>
References: <416ED763.2090501@sunrisetelecom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <416ED763.2090501@sunrisetelecom.com>; from klessard@sunrisetelecom.com on Thu, Oct 14, 2004 at 03:45:39PM -0400
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2004 at 03:45:39PM -0400, Karl Lessard wrote:
> Hello,
> 
> I was looking at the code of the new ohci-au1xxx, and I've figured out 
> that operationnal regiters resource
> is allocated two times: once when registering the OHCI platform device 
> (check in drivers/base/platform.c),
> and once in OHCI driver probe.
> Is that ok?? I'm kind of surprised that the second allocation doesn't 
> failed. Removing it seems to works
> well for me.

These are two different calls. request_resource() versus
request_region() (this is wrappered by request_mem_region()).

The request_resource() call is used by the bus driver to show
allocatable resources.

The request_region() call allocates new busy regions and checks
that the requested regions are not already busy.

The request_mem_region() call is correct and does not fail because
no other call has requested the same region.

If you look at a complex /proc/iomem like on a PCI-equipped system
with many devices, you can see how the bus driver shows allocatable
resources and then some drivers have claimed portions of those
resources as regions (because they are tagged with a driver name).
Here's a dump from such a system:

...
cde00000-cfefffff : PCI Bus #01
  ce000000-ceffffff : 0000:01:00.0
    ce000000-ceffffff : nvidia
cffdd000-cffddfff : 0000:00:03.0
  cffdd000-cffddfff : sis900
cfffdf00-cfffdfff : 0000:00:13.2
  cfffdf00-cfffdfff : ehci_hcd
cfffe000-cfffefff : 0000:00:02.2
  cfffe000-cfffefff : ohci_hcd
cffff000-cfffffff : 0000:00:02.3
  cffff000-cfffffff : ohci_hcd
...

Note that the platform bus code requests the bus allocatable resources
in generic code, whereas for something like PCI it's done in
arch-specific pci code since each arch requires a lot of fixup to
those resources due to the nature of PCI. The platform bus code
doesn't have any inherent knowledge of bus resources beyond what
it gains from a platform_add_device() call.

-Matt
