Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 01:40:16 +0200 (CEST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:3452 "EHLO
        rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492343Ab0ECXkL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 01:40:11 +0200
Authentication-Results: rtp-iport-2.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEALn73kutJV2b/2dsb2JhbACdL3GjC5lShRIEgz4
X-IronPort-AV: E=Sophos;i="4.52,322,1270425600"; 
   d="scan'208";a="107726689"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rtp-iport-2.cisco.com with ESMTP; 03 May 2010 23:40:04 +0000
Received: from xbh-rcd-202.cisco.com (xbh-rcd-202.cisco.com [72.163.62.201])
        by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id o43Ne4p8015600
        for <linux-mips@linux-mips.org>; Mon, 3 May 2010 23:40:04 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-202.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 3 May 2010 18:40:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Apply kmap_high_get with MIPS
Date:   Mon, 3 May 2010 18:40:04 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400DBBA5E5@XMB-RCD-208.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Apply kmap_high_get with MIPS
Thread-Index: AcrrGfR3mULuXIX/T1CGox04GHFUYg==
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 03 May 2010 23:40:04.0175 (UTC) FILETIME=[F478D5F0:01CAEB19]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

Hi all,

The changes mentioned in the link below are intended to apply on MIPS
dma functions.


http://lkml.org/lkml/2009/3/7/137
