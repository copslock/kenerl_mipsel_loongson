Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 18:29:19 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47350 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225253AbTBTSY2>;
	Thu, 20 Feb 2003 18:24:28 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA30119;
	Thu, 20 Feb 2003 10:23:39 -0800
Subject: Re: Ramdisk image on flash.
From: Pete Popov <ppopov@mvista.com>
To: krishnakumar@naturesoft.net
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <200302201135.09154.krishnakumar@naturesoft.net>
References: <200302201135.09154.krishnakumar@naturesoft.net>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045765647.30379.262.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 10:27:27 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1472
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
> Hi,
> 
> Is there any way that I can keep 
> a ramdisk image (containing the root filesystem)
> in a flash device and boot to it.

Yes, and other architectures have support for passing arguments to the
kernel that tell it where the ramdisk is. I don't know that we've done
that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
this list is already working on it (I think someone actually is working
on it and was preparing a patch for Ralf).

> The ramdisk should be separate from the kernel image.

Pete
