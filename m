Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2008 04:09:56 +0000 (GMT)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:12939 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20022075AbYBTEJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Feb 2008 04:09:53 +0000
X-IronPort-AV: E=Sophos;i="4.25,379,1199692800"; 
   d="scan'208";a="13623622"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-5.cisco.com with ESMTP; 19 Feb 2008 20:09:47 -0800
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m1K49lcY017767
	for <linux-mips@linux-mips.org>; Tue, 19 Feb 2008 20:09:47 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id m1K49kJg000969
	for <linux-mips@linux-mips.org>; Wed, 20 Feb 2008 04:09:46 GMT
Received: from cuplxvomd01.corp.sa.net ([64.100.148.205]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id EAA22289 for <linux-mips@linux-mips.org>; Wed, 20 Feb 2008 04:09:45 GMT
Message-ID: <47BBA809.3050505@cisco.com>
Date:	Tue, 19 Feb 2008 20:09:45 -0800
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Does HIGHMEM work on 32-bit MIPS ports?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=621; t=1203480587; x=1204344587;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Does=20HIGHMEM=20work=20on=2032-bit=20MIPS=20po
	rts?
	|Sender:=20;
	bh=dfZtjsVYpzGueoXkb0NCcdKJuLlHxI2Gdvla2g0EqFM=;
	b=ZOxbcvdtvM3v6Gj1BCXhePpfUd6vDbBq1L6Ap+jW/WBK/1/fMhyHnzhvjc
	7z5YyqRtB8i/y59E4Tfvpknsr484l0H7usdrWuCmXGlVV5QNGlh4M1rBr8IU
	einMjBYEY3;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

As we continue to investigate using high memory on MIPS, we keep coming 
up with odd results. The basic mapping of high memory seems to be 
working correctly, and if we use an INITRAMFS root filesystem, things 
seem to work. Things also seem to work with an NFS root filesystem if we 
disable preemption, though we get someone squirrelly behavior in some 
minor ways. Has anyone else successfully been able to use high memory on 
a 32-bit MIPS Linux port?

Any feedback would be helpful.

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
