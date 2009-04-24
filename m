Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 02:18:25 +0100 (BST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:59506 "EHLO
	sj-iport-4.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20021851AbZDXBSU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 02:18:20 +0100
X-IronPort-AV: E=Sophos;i="4.40,238,1238976000"; 
   d="scan'208";a="34296494"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-4.cisco.com with ESMTP; 24 Apr 2009 01:17:59 +0000
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n3O1I0ve021857;
	Thu, 23 Apr 2009 18:18:00 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.13.8/8.13.8) with ESMTP id n3O1I0qA029786;
	Fri, 24 Apr 2009 01:18:00 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id BAA02003; Fri, 24 Apr 2009 01:17:54 GMT
Date:	Thu, 23 Apr 2009 18:17:54 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: HIGHMEM fix for r24k
Message-ID: <20090424011754.GA28984@cuplxvomd02.corp.sa.net>
References: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1237; t=1240535880; x=1241399880;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20HIGHMEM=20fix=20for=20r24k
	|Sender:=20;
	bh=ZlJBXiFpLeNiGJsT4mAV7ZeNuHxvNCRcmEQkWoKCYqk=;
	b=ufmst877XXHotDmrwU1cZvP7ocGwZm05Fr5kVg4UsbG7R5n3KbpwrEO+aI
	TOsIi7c8BcyL0rceEBeDvT1HXuieE5qzcEj7trfYKrC/Zs3GXD2UlKkEJWUy
	1uDXzIZF5E;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 23, 2009 at 06:23:44PM -0400, Jon Fraser wrote:
> For all you guys working on HIGMEM.
> 
> I found a bug that was keeping HIGHMEM from working on mips 24k
> processors starting at 2.6.26.  
> 
> 
> 2008-04-28 Chris Dearman [MIPS] Allow setting of the cache attribute at
> run ...
> 
> This commit introduces the variable _page_cachable_default, which
> defaults to zero.
> 
> arch/mips/mm/cache.c:
> 	unsigned long _page_cachable_default;
> 
> The variable is used to create the prototype PTE for __kmap_atomic in
> arch/mips/mm/init.c:kmap_init.
> 
> The variable is initialized in arch/mips/mm/c-r4k.c:coherency_setup.
> 
> Unfortunately, the variable is used before it is initialized properly.
> As a result, all kmap_atomic PTE have the cache coherency algorithm mode set to 0.  
> Mode 0 is "cacheable, nocoherent, write-through, no write allocate".
> This is not valid on my r24k and my not be on any r24k.
> 
> The result is that writes to kmap_atomic pages get corrupted.  This was confirmed
> using a jtag probe, examining uncached memory, the D cache itself, and cached memory.

Ouch, sounds like a nasty bit of work finding this...thanks!

> Jon Fraser
> Broadcom

David VomLehn
