Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 19:18:39 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:14334 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492221Ab0ELRSf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 May 2010 19:18:35 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiMFALF/6kutJV2Y/2dsb2JhbACRaoxEcaJTmV6FEgSDQA
X-IronPort-AV: E=Sophos;i="4.53,216,1272844800"; 
   d="scan'208";a="110444404"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rtp-iport-1.cisco.com with ESMTP; 12 May 2010 17:18:28 +0000
Received: from xbh-rcd-302.cisco.com (xbh-rcd-302.cisco.com [72.163.63.9])
        by rcdn-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id o4CHIS7v023509;
        Wed, 12 May 2010 17:18:28 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-302.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 12 May 2010 12:18:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH resend] Apply kmap_high_get on MIPS
Date:   Wed, 12 May 2010 12:18:26 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400DC645CC@XMB-RCD-208.cisco.com>
In-Reply-To: <20100511230609.GB13271@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH resend] Apply kmap_high_get on MIPS
Thread-Index: AcrxXpBfOoNutrGeRxue6FwB8zv2iAAl9VYw
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     <linux-mips@linux-mips.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>
X-OriginalArrivalTime: 12 May 2010 17:18:28.0306 (UTC) FILETIME=[23303B20:01CAF1F7]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26693
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
