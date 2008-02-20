Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2008 19:20:45 +0000 (GMT)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:13581 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20031897AbYBTTUm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Feb 2008 19:20:42 +0000
X-IronPort-AV: E=Sophos;i="4.25,382,1199692800"; 
   d="scan'208";a="13784531"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-5.cisco.com with ESMTP; 20 Feb 2008 11:20:35 -0800
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m1KJKZK5017938
	for <linux-mips@linux-mips.org>; Wed, 20 Feb 2008 11:20:35 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id m1KJKYvn001403
	for <linux-mips@linux-mips.org>; Wed, 20 Feb 2008 19:20:34 GMT
Received: from cuplxvomd01.corp.sa.net ([64.100.151.124]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id TAA24520 for <linux-mips@linux-mips.org>; Wed, 20 Feb 2008 19:20:33 GMT
Message-ID: <47BC7D81.8030309@cisco.com>
Date:	Wed, 20 Feb 2008 11:20:33 -0800
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1012; t=1203535235; x=1204399235;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Does=20HIGHMEM=20work=20on=2032-bit=20M
	IPS=20ports?
	|Sender:=20;
	bh=fdlKmnPPaTIDqN6RSn6d2/XzjLBNPmfG8LWQkG/iM7A=;
	b=XT8XApEHIpydW15nFQHLzltbXc6i4LsETqS+WDB7tD2vnvlWWxzMcy5+Zn
	nNZFuUBXRRjXs3yNeAK9T+kSaWd2DKr67FqnxPGduZANzAV3dGdMdhTW3bOs
	FRlEeT3tCgCGhvoryiXQta80MGIjFTH3j+eJWZCKG/jUJtPW08fFc=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

 > I've written MIPS highmem support in late 2002 for a customer who
 > back then wasn't interested in being the first through the 64-bit
 > minefield. Which back then certainly was justified - but there are
 > now fairly stable 64-bit Linux kernels available so if you happen to
 > be running on 64-bit hardware don't even spend a nanosecond on
 > thinking about 32-bit highmem kernels.  Highmem fundamentally sucks
 > rocks through a straw.
 >
 > Coming back to your question.  Highmem was only ever tested to work
 > on SB1 and somewhat later PMC-Sierra RM9000 cores, both being 64-bit.
 > With the increasing maturity of 64-bit Linux interest in these went
 > away and as the result the highmem code started a slow bitrot -
 > unnoticed for many moons.

Hmm, this is not good. I've got a MIPS 24Kc processor with a very 
awkward memory layout. Any hints?

 >   Ralf
-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my 
employer's...
