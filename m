Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 22:38:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58610 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225571AbUAUWiA>;
	Wed, 21 Jan 2004 22:38:00 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0LMbr430733;
	Wed, 21 Jan 2004 14:37:53 -0800
Date: Wed, 21 Jan 2004 14:37:53 -0800
From: Jun Sun <jsun@mvista.com>
To: Nils Larson <nlarson@Crossroads.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: How to add more memory?
Message-ID: <20040121143753.C29705@mvista.com>
References: <CFD808D1D39ACB47ABFF586D484CC52EADE212@hqmailnode1.commstor.crossroads.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CFD808D1D39ACB47ABFF586D484CC52EADE212@hqmailnode1.commstor.crossroads.com>; from nlarson@Crossroads.com on Wed, Jan 21, 2004 at 03:58:24PM -0600
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 03:58:24PM -0600, Nils Larson wrote:
> Hi,
> We currently have a mips platform running Linux with 256MB of
> RAM starting at 0x8000_0000. We would like to add an additional
> 1GB of RAM, maybe starting at 0x4000_0000, that would be used
> for user apps (user virtual memory). The memory map is:
> 0x8000_0000 - 256MB RAM
> 0xA000_0000 - uncached version of the same 256MB
> 0xB000_0000 - PCI memory windows.
> This is a diskless setup booting from a ramdisk.
> So, the (sort of newbie) questions are:
> 1. How do we tell Linux to use the new memory?
> 2. Is this feasible?
> 3. Is there a better way to add more memory?
> We need more space for user data.
> Thanks,
> Nils
> 

People have done this before in 2.4 with CONFIG_HIGHMEM.  
See arch/mips/sibyte/cfe/setup.c for more details.

However, if the CPU suffers from virtual aliasing problem, I
think this won't work at all.

I think that is pretty much only way to get more RAM 
in 32bit system.  With 64bit kernel of course you don't have
any problems at all.

Jun
