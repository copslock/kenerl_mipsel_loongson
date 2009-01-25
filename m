Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 01:59:53 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:33455 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21366344AbZAYB7u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2009 01:59:50 +0000
X-IronPort-AV: E=Sophos;i="4.37,320,1231113600"; 
   d="scan'208";a="34805453"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-1.cisco.com with ESMTP; 25 Jan 2009 01:59:43 +0000
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n0P1xhsb026661;
	Sat, 24 Jan 2009 20:59:43 -0500
Received: from xbh-rtp-201.amer.cisco.com (xbh-rtp-201.cisco.com [64.102.31.12])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n0P1xhgx021990;
	Sun, 25 Jan 2009 01:59:43 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-201.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 24 Jan 2009 20:59:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.28 will not boot on 24K processor, ebase incorrectly modified in set_uncached_handler
Date:	Sat, 24 Jan 2009 20:59:42 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A28976825D@xmb-rtp-218.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.28 will not boot on 24K processor, ebase incorrectly modified in set_uncached_handler
Thread-Index: Acl+kJaro0S6RTnZTS6pVkaviRzJAg==
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	<linux-mips@linux-mips.org>
Cc:	"Dezhong Diao (dediao)" <dediao@cisco.com>,
	"Victor Williams Jr (williavi)" <williavi@cisco.com>,
	"Michael Sundius -X (msundius - Yoh Services LLC at Cisco)" 
	<msundius@cisco.com>
X-OriginalArrivalTime: 25 Jan 2009 01:59:43.0592 (UTC) FILETIME=[97526680:01C97E90]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=676; t=1232848783; x=1233712783;
	c=relaxed/simple; s=rtpdkim1001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=202.6.28=20will=20not=20boot=20on=2024K=20process
	or,=20ebase=20incorrectly=20modified=20in=20set_uncached_han
	dler
	|Sender:=20
	|To:=20<linux-mips@linux-mips.org>;
	bh=TLeCNFAsy+bYEhPXFDWM8OyPL5qx09X8z2ozNv/p5Vg=;
	b=OOT3xTMuZNY7PPSRLuMZsb3tE0n6NGn4eTklXKU+qtu/YkrrgfNgU/dKS5
	f6tb9DbWnntTaKpo7iS9JXWkVz82t9YPLQwzvq1D3xsXfPnBA4u6IwVmKrKD
	nOqm9ahLkg;
Authentication-Results:	rtp-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim1001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

The 2.6.28 kernel dies in memcpy when called from set_vi_srs_handler on
a
24K processor. The problem is that ebase has an invalid value. The
original
value of ebase comes from a bootmem allocation, but the following code
in
set_uncached_handler takes a perfectly good kseg0 address and turns it
into
an invalid kseg1 address.

	if (cpu_has_mips_r2)
		ebase += (read_c0_ebase() & 0x3ffff000);

This code was added in commit 566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e.
I
have no idea why ebase needs to be modified at all, so I have no patch
to
offer. When I removed these two lines, my kernel booted to a shell
prompt.
--
David VomLehn, dvomlehn@cisco.com
