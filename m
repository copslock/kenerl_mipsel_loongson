Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 20:29:21 +0200 (CEST)
Received: from syd-iport-2.cisco.com ([64.104.193.197]:27573 "EHLO
	syd-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492483AbZGHS3P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 20:29:15 +0200
X-IronPort-AV: E=Sophos;i="4.42,369,1243814400"; 
   d="scan'208";a="55020891"
Received: from syd-dkim-1.cisco.com ([64.104.193.116])
  by syd-iport-2.cisco.com with ESMTP; 08 Jul 2009 18:29:07 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by syd-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n68IT6B2016248;
	Thu, 9 Jul 2009 04:29:07 +1000
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id n68IT6V3023634;
	Wed, 8 Jul 2009 18:29:06 GMT
Date:	Wed, 8 Jul 2009 11:29:06 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	joe seb <joe.seb8@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Linux port failing on MIPS32 24Kc
Message-ID: <20090708182906.GB31285@cuplxvomd02.corp.sa.net>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com> <20090708103756.GB22308@linux-mips.org> <4f9abdc70907080547l501128bg7c920e206e0068c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9abdc70907080547l501128bg7c920e206e0068c3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=773; t=1247077747; x=1247941747;
	c=relaxed/simple; s=syddkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Linux=20port=20failing=20on=20MIPS32=20
	24Kc
	|Sender:=20;
	bh=rGEMG+z+MiJln2WlfdgF9NNnpi5nVSrAcgUvZ7ov3Yo=;
	b=gpTIObR9AJ7JIdkqqs5vqFeO7Kzi272/XSmujML9h4/1zZk3zyM46qCh9c
	pLPYzhswImpHNuTyxTcvwmf1cwdUi3plh00If7mnHx8o+4QQ9jQkPVOiAL5C
	O2a5cUfYSubRQzzXyVXiX8+xGjlkQ1PrAq/SapJ29S2qta/VxvdL4=;
Authentication-Results:	syd-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/syddkim1002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 08, 2009 at 06:17:42PM +0530, joe seb wrote:
> Hi,
> 
> We made the following changes and tried,
> 
> -> applied the patch given by you.
> -> changed the PHYS_OFFSET to 0x10000000 to match our memory offset.
> -> cache write back mode enabled
> 
> Still we face the same problem. It crashes at different points when it
> enters the user space. I have attached one of the logs.
> 
> But in cache write through mode it works.

Another thought: if it works with write through, but not write back, you
may have a device driver that isn't flushing/invalidating cache appropriately
before doing DMA. This is much more important on MIPS than many other
processors.

Is this a new platform or one that has been working for a while?

David VomLehn
