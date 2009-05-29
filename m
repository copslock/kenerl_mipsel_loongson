Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 19:30:51 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:40160 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024742AbZE2Sao (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 19:30:44 +0100
X-IronPort-AV: E=Sophos;i="4.41,272,1241395200"; 
   d="scan'208";a="313151576"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-6.cisco.com with ESMTP; 29 May 2009 18:30:35 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n4TIUZwp001273;
	Fri, 29 May 2009 11:30:35 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n4TIUZxX008012;
	Fri, 29 May 2009 18:30:35 GMT
Date:	Fri, 29 May 2009 11:30:35 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 0/3] mips:powertv: Introduction to new Cisco Powertv
	platform, v2
Message-ID: <20090529183035.GA12446@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=821; t=1243621835; x=1244485835;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=200/3]=20mips=3Apowertv=3A=20Introductio
	n=20to=20new=20Cisco=20Powertv=0A=09platform,=20v2
	|Sender:=20;
	bh=efU4IbRwGKdcEs1fLuqdJnM/+sBaMVvlPKPiU81GNqA=;
	b=B2rGvvlqg2M68q03640Q8aMl4YcbNYHC5FqWtrhC7LQSl/XAScf8hSpPWn
	+/a4DhMzS52WVutM8FoEcrLq1+9lYmXGXmFaBNM49jfdDEGR8OvOpM+s5uY6
	yYM/RnTA1I;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

The following series of patches adds the Cisco Powertv cable settop box to
the MIPS tree. The following patches are included:

powertv-intro.patch
	This file
powertv-base.patch
	Base kernel files
powertv-config-cmdline-size.patch
	Allow configurable command line buffer size
powertv-integrate.patch
	Integrate the Powertv platform with other MIPS-based platforms

This code has been out of the tree *way* too long and, though it has no
checkpatch errors, it a few checkpatch warnings and other non-standard things
in it. Still, you have to start sometime, so this is where things are today.

History
v2	Dropped DMA fixes and PowerTV-specific USB code. They are required
	for the PowerTV platform, but will be posted separately.
v1	Original version

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
