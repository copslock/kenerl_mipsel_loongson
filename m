Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 02:44:51 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:28432 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S29571309AbZDVSE5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:04:57 +0100
X-IronPort-AV: E=Sophos;i="4.40,231,1238976000"; 
   d="scan'208";a="290940698"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 22 Apr 2009 18:04:48 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n3MI4lod032264;
	Wed, 22 Apr 2009 11:04:48 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n3MI4lKu001328;
	Wed, 22 Apr 2009 18:04:47 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id SAA27575; Wed, 22 Apr 2009 18:04:47 GMT
Date:	Wed, 22 Apr 2009 11:04:47 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/2] MIPS: Move signal return trampolines off the stack.
Message-ID: <20090422180447.GC28623@cuplxvomd02.corp.sa.net>
References: <49EE3B0F.3040506@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49EE3B0F.3040506@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1183; t=1240423488; x=1241287488;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=200/2]=20MIPS=3A=20Move=20signal
	=20return=20trampolines=20off=20the=20stack.
	|Sender:=20;
	bh=jhHO92VnA3I6Qsv5v4n6kn+lZierwWpDxADI99XzRz8=;
	b=R88WL/XCxkfHY+juI541CkXJWyM6a/x6GViJbCO6Ig8ln8oybS7HqMpJn2
	Ib5sgJzAefMRAV120b++8EY3IMrfaXMOIVUids+9VoAyYUFGX57XLYiLzPuN
	6hbbQ6jaAr;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 21, 2009 at 02:30:55PM -0700, David Daney wrote:
> This patch set (against 2.6.29.1) creates a vdso and moves the signal
> trampolines to it from their previous home on the stack.
>
> Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
> following results from lmbench2:
>
> Before:
> n64 - Signal handler overhead: 14.517 microseconds
> n32 - Signal handler overhead: 14.497 microseconds
> o32 - Signal handler overhead: 16.637 microseconds
>
> After:
>
> n64 - Signal handler overhead: 7.935 microseconds
> n32 - Signal handler overhead: 7.334 microseconds
> o32 - Signal handler overhead: 8.628 microseconds

Nice numbers, and something that will be even more critical as real-time
features are added and used!

> Comments encourged.

Only one comment, which I would not want to hold up acceptance:
based on some numbers sent out recently, it looks like the kernel is
experiencing some performance issues with exec() and I think this change will
make it slightly slower. You could avoid this by deferring installation of
the trampoline to the first use of a system call that registers a signal
handler.

David VomLehn
