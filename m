Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 22:28:09 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:38645 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225382AbUAMW2G>;
	Tue, 13 Jan 2004 22:28:06 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0DMS2T29438;
	Tue, 13 Jan 2004 14:28:02 -0800
Date: Tue, 13 Jan 2004 14:28:02 -0800
From: Jun Sun <jsun@mvista.com>
To: Charlie Brady <charlieb-linux-mips@e-smith.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Broadcom 4702?
Message-ID: <20040113142802.M11733@mvista.com>
References: <Pine.LNX.4.44.0401131655350.20844-100000@allspice.nssg.mitel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0401131655350.20844-100000@allspice.nssg.mitel.com>; from charlieb-linux-mips@e-smith.com on Tue, Jan 13, 2004 at 05:00:27PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 05:00:27PM -0500, Charlie Brady wrote:
> 
> I haven't found signs of it in the archives, but is anyone aware of any 
> efforts to fold in Broadcom's support for their 4702 processor, as used in 
> Wireless gateways such as the Linksys WRT54G? Source code for their kernel 
> port can be found here:
> 
>   http://www.linksys.com/support/gpl.asp
> 
> Would someone from Broadcom prefer to provide the patches?
> 

Mvista is in the process of supporting bcm4704, which should be close to
bcm4702.  If there is much interest, we can push the patch out to 
the linux-mips.org tree.

Jun
