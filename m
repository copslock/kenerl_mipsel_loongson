Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 20:50:16 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:50668 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492324Ab0EMSuM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 May 2010 20:50:12 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHvm60utJV2d/2dsb2JhbACeInGkHpk5hRIEg0A
X-IronPort-AV: E=Sophos;i="4.53,224,1272844800"; 
   d="scan'208";a="110835565"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rtp-iport-1.cisco.com with ESMTP; 13 May 2010 18:50:04 +0000
Received: from xbh-rcd-202.cisco.com (xbh-rcd-202.cisco.com [72.163.62.201])
        by rcdn-core-6.cisco.com (8.14.3/8.14.3) with ESMTP id o4DIo499004490;
        Thu, 13 May 2010 18:50:04 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-202.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 13 May 2010 13:50:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH 1/2] The Device Tree Patch for MIPS
Date:   Thu, 13 May 2010 13:50:04 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400DC64936@XMB-RCD-208.cisco.com>
In-Reply-To: <4BEAE438.7080303@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 1/2] The Device Tree Patch for MIPS
Thread-Index: Acrx9/Tt8ZhsxHU6Rx+ZPdIrEajDfAA05zKg
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     "David Daney" <ddaney@caviumnetworks.com>
Cc:     <linux-mips@linux-mips.org>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        "Grant Likely" <grant.likely@secretlab.ca>
X-OriginalArrivalTime: 13 May 2010 18:50:04.0857 (UTC) FILETIME=[19CD1A90:01CAF2CD]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

>> +/* which is compatible with the flattened device tree (FDT) */ 
>> +#define cmd_line arcs_cmdline

>What is this #define floating in space?

The variable "cmd_line" is being used in generic code of device tree,
most of platforms (ARM, POWERPC
, etc) have its definition, but it isn't present in MIPS. Actually there
is a variable "arcs_cmdline" to be used as the same purpose in MIPS,
that is the reason "arcs_cmdline" is given a new name.


Thanks


Dezhong
