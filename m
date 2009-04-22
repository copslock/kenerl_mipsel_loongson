Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 02:56:52 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:17400 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S29582311AbZDVSbi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:31:38 +0100
X-IronPort-AV: E=Sophos;i="4.40,231,1238976000"; 
   d="scan'208";a="175362245"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 22 Apr 2009 18:31:29 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n3MIVTDn002633;
	Wed, 22 Apr 2009 11:31:29 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n3MIVTFS000919;
	Wed, 22 Apr 2009 18:31:29 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id SAA09527; Wed, 22 Apr 2009 18:31:29 GMT
Date:	Wed, 22 Apr 2009 11:31:29 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/2] MIPS: Move signal return trampolines off the stack.
Message-ID: <20090422183129.GB9184@cuplxvomd02.corp.sa.net>
References: <49EE3B0F.3040506@caviumnetworks.com> <20090422180447.GC28623@cuplxvomd02.corp.sa.net> <49EF5E58.2040901@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49EF5E58.2040901@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=985; t=1240425089; x=1241289089;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=200/2]=20MIPS=3A=20Move=20signal
	=20return=20trampolines=20off=20the=20stack.
	|Sender:=20;
	bh=kcR923mbTDjr9rXjt9rxXyMkAL/MrrcXZfofdE84y8k=;
	b=D1kzQCsT2goWlvE53eqvtHHIocMoiCV5xU1m5DVY6ENrDCrvJrgMLD8Sk+
	up+Epbk/8AJPgGKMm1i3xiuNAnzoYVBYSkS5Re3vDa4WclC6wXF908g2nNhH
	puDFT0Ftso;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 11:13:44AM -0700, David Daney wrote:
> David VomLehn wrote:
...
>> Only one comment, which I would not want to hold up acceptance:
>> based on some numbers sent out recently, it looks like the kernel is
>> experiencing some performance issues with exec() and I think this change will
>> make it slightly slower. You could avoid this by deferring installation of
>> the trampoline to the first use of a system call that registers a signal
>> handler.
>
> I should try to measure this too.  Although this is what x86 et al. do.  
> It is by far much simpler and less prone to bugs that trying to hook  
> into the system calls.  After an executable has had the chance to start  
> additional threads and establish arbitrary mappings things get 
> complicated.

I suspect the overhead is quite small and agree that hooking into the
system calls a bit risky. This might be better done as a phase two, if
at all.

> David Daney

David VomLehn
