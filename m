Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 02:50:59 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:65029 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S29567973AbZDVR5v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 18:57:51 +0100
X-IronPort-AV: E=Sophos;i="4.40,231,1238976000"; 
   d="scan'208";a="290935396"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-6.cisco.com with ESMTP; 22 Apr 2009 17:57:33 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n3MHvWUh031950;
	Wed, 22 Apr 2009 10:57:32 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n3MHvW9l022583;
	Wed, 22 Apr 2009 17:57:32 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA25322; Wed, 22 Apr 2009 17:57:32 GMT
Date:	Wed, 22 Apr 2009 10:57:32 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Move signal trampolines off of the stack.
Message-ID: <20090422175732.GB28623@cuplxvomd02.corp.sa.net>
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240349605-1921-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=530; t=1240423052; x=1241287052;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/2]=20MIPS=3A=20Move=20signal
	=20trampolines=20off=20of=20the=20stack.
	|Sender:=20;
	bh=Z6lFNZuBwLa4bXdMlVEUxri/yoqUYJ42Htj4f3iYvnM=;
	b=qasB7TuDly6lWvxpAz2Z9AqYAf/8MZUGk1VB7zhEvrmpmQLSJq27MGStmy
	KBlaQ0+e6hbaIzF5qBD1NO3Ff8zQUp6rRvfsL/9L2lSWDlr02HX7BijVP98H
	18eOUjQU7S;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 21, 2009 at 02:33:25PM -0700, David Daney wrote:
> This is a follow on to the vdso patch.
> 
> Since all processes now have signal trampolines permanently mapped, we
> can use those instead of putting the trampoline on the stack and
> invalidating the corresponding icache across all CPUs.  We also get
> rid of a bunch of ICACHE_REFILLS_WORKAROUND_WAR code.

This sure gets rid of some ugly code!

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Reviewed by: David VomLehn <dvomlehn@cisco.com>
