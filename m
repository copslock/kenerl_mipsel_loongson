Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 00:39:09 +0000 (GMT)
Received: from 50.69-93-10.reverse.theplanet.com ([IPv6:::ffff:69.93.10.50]:55020
	"EHLO spaghetti.theross.com") by linux-mips.org with ESMTP
	id <S8225217AbTL2AjG>; Mon, 29 Dec 2003 00:39:06 +0000
Received: from pcp02792195pcs.roylok01.mi.comcast.net ([68.62.5.21] helo=bitglue.com)
	by spaghetti.theross.com with smtp (Exim 4.22)
	id 1AalQy-00007Z-Nq
	for linux-mips@linux-mips.org; Sun, 28 Dec 2003 19:39:00 -0500
Received: (qmail 3008 invoked by uid 100); 29 Dec 2003 00:38:58 -0000
Date: Sun, 28 Dec 2003 19:38:58 -0500
From: Phil Frost <indigo@bitglue.com>
To: Maitland Bottoms <bottoms@debian.org>
Cc: linux-mips@linux-mips.org
Message-ID: <20031229003858.GA3018@europa.lair>
Mail-Followup-To: Maitland Bottoms <bottoms@debian.org>,
	linux-mips@linux-mips.org
References: <16365.48740.594791.853479@airborne.nrl.navy.mil>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16365.48740.594791.853479@airborne.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
X-SA-Exim-Mail-From: indigo@bitglue.com
Subject: Re: Origin 200
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built Wed Aug 20 09:38:54 PDT 2003)
X-SA-Exim-Scanned: Yes
Return-Path: <indigo@bitglue.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: indigo@bitglue.com
Precedence: bulk
X-list: linux-mips

It can be netbooted. Simply configure a bootp (dhcp) and tftp server, then type
bootp() at the SGI maintenance prompt.

However, currently the kernel does not run on uniprocessor origins. Someone was
working on this though...

On Sat, Dec 27, 2003 at 12:16:20PM -0500, Maitland Bottoms wrote:
> Hi,
> 
> I would like to bring up Linux on an Origin 200.
> 
> Has anyone netbooted one of these? Is there a bootable
> CDROM image around?
> 
> I would prefer to netboot/nfsroot, but if I must I could
> find a SCSI disk.
> 
> Thanks,
> -Maitland
> 
