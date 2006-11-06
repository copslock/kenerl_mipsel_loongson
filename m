Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2006 14:43:01 +0000 (GMT)
Received: from ams-iport-1.cisco.com ([144.254.224.140]:28990 "EHLO
	ams-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20038498AbWKFOmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2006 14:42:55 +0000
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 06 Nov 2006 15:42:42 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FALjWTkWQ/uCKY2dsb2JhbACMQBQPKg
X-IronPort-AV: i="4.09,391,1157320800"; 
   d="scan'208"; a="117491114:sNHT1670059248"
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11.20060308/8.12.11) with ESMTP id kA6EgbkS032147
	for <linux-mips@linux-mips.org>; Mon, 6 Nov 2006 15:42:37 +0100
Received: from xbh-ams-331.emea.cisco.com (xbh-ams-331.cisco.com [144.254.231.71])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id kA6EgZ4Z013558
	for <linux-mips@linux-mips.org>; Mon, 6 Nov 2006 15:42:37 +0100 (MET)
Received: from xmb-ams-33b.cisco.com ([144.254.231.86]) by xbh-ams-331.emea.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 6 Nov 2006 15:42:35 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Sync operation in atomic_add_return()
Date:	Mon, 6 Nov 2006 15:42:32 +0100
Message-ID: <E98CBCB9ACC07244969BE4541EC0A78303137105@xmb-ams-33b.emea.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sync operation in atomic_add_return()
Thread-Index: AccBscqczM/yLc/WQ56lzFz+PK98Aw==
From:	"Gideon Stupp \(gstupp\)" <gstupp@cisco.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Nov 2006 14:42:35.0245 (UTC) FILETIME=[CC5721D0:01C701B1]
DKIM-Signature:	a=rsa-sha1; q=dns; l=238; t=1162824157; x=1163688157;
	c=relaxed/simple; s=amsdkim1002; h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=gstupp@cisco.com; z=From:=22Gideon=20Stupp=20\(gstupp\)=22=20<gstupp@cisco.com>
	|Subject:Sync=20operation=20in=20atomic_add_return();
	X=v=3Dcisco.com=3B=20h=3DrA689xsvf+eeyP6dQ0ll9jEY8OU=3D; b=V9BwL6QiSKOdZVbxqTwfwoiHZJPtSM2//QDR9JpOT1sPkssECddqxb8AZ77NE/G9u6Vb8dgq
	omfwn/CLHocotMijhYimOWcRUUhLVX3ZdN/VftlXObussOil+YfGcIPO;
Authentication-Results:	ams-dkim-1; header.From=gstupp@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Return-Path: <gstupp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gstupp@cisco.com
Precedence: bulk
X-list: linux-mips

Hi,
I am trying to figure out why there is a sync operation in
linux/include/asm-mips/atomic.h:atomic_add_return(). 
I believe it was added in the linux-2.4.19 patch, but can't trace the
reason. Can anyone help?

Thanks, Gideon.
