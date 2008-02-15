Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2008 20:17:57 +0000 (GMT)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:32905 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20032207AbYBOURz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Feb 2008 20:17:55 +0000
X-IronPort-AV: E=Sophos;i="4.25,359,1199692800"; 
   d="scan'208";a="13075016"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-5.cisco.com with ESMTP; 15 Feb 2008 12:17:47 -0800
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m1FKHl33032550
	for <linux-mips@linux-mips.org>; Fri, 15 Feb 2008 12:17:47 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id m1FKHkJg008016
	for <linux-mips@linux-mips.org>; Fri, 15 Feb 2008 20:17:47 GMT
Received: from cuplxvomd01.corp.sa.net ([64.100.151.91]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id UAA11242 for <linux-mips@linux-mips.org>; Fri, 15 Feb 2008 20:17:45 GMT
Message-ID: <47B5F369.7060600@cisco.com>
Date:	Fri, 15 Feb 2008 12:17:45 -0800
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: NFS mount fails with CONFIG_HIGHMEM on MIPS 24Kc system on 2.6.24
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=636; t=1203106667; x=1203970667;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20NFS=20mount=20fails=20with=20CONFIG_HIGHMEM=20o
	n=20MIPS=2024Kc=20system=20on=202.6.24
	|Sender:=20;
	bh=Gqxf+LL/cgKtixLMLIpuAArwCnZrGVEqJXRQX786yBI=;
	b=mR4bSFQBs2pt95OttS+PuR/qphfg/WEld/MUHID2iHE/jTd4vFh+l0jnJc
	UapwlkkC7z1mlq30pQzbOnukGp2HF8oHPagpAkrjttIlLWIahVdhMM9J2qbO
	O210Ocj/TJoLm5ENvy4yzNJNDfPg7GWxhn/te/HNHz/J+bcbGXgNY=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

We have a 2.6.24final port to a MIPS 24Kc-based system which works 
normally without CONFIG_HIGHMEM enabled. When we enable HIGHMEM, the 
system boots normally using a CRAMFS root filesystem. If we use an NFS 
root filesystem, however, it appears to go through a normal boot, 
including the freeing of init memory, but then just sits indefinitely in 
r4k_wait().

I can see that using HIGHMEM enables use of kmap_atomic in networking 
code. Are there issues with networking or NFS with HIGHMEM enabled?

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
