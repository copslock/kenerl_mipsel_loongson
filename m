Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 23:02:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:11249 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225209AbTGYWC1>;
	Fri, 25 Jul 2003 23:02:27 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6PM2OX26421;
	Fri, 25 Jul 2003 15:02:24 -0700
Date: Fri, 25 Jul 2003 15:02:24 -0700
From: Jun Sun <jsun@mvista.com>
To: Teresa Tao <Teresat@tridentmicro.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: mmap'ed memory cacheable or uncheable
Message-ID: <20030725150224.C25784@mvista.com>
References: <61F6477DE6BED311B69F009027C3F58403AA3969@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <61F6477DE6BED311B69F009027C3F58403AA3969@EXCHANGE>; from Teresat@tridentmicro.com on Thu, Jul 24, 2003 at 08:26:59PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 24, 2003 at 08:26:59PM -0700, Teresa Tao wrote:
> Hi there,
> 
> I got a question regarding the mmap'ed memory. Is the mmap'ed memory cacheable or uncheable? My driver just use the remap_page_range to map a reserved physical memory.
>

I am pretty much sure it is cached, although I can't pin down exactly
where in the mm subsystem it does so - I have had cache bugs related
to mmap().

Jun
