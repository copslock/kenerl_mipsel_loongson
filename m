Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 23:32:46 +0200 (CEST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:49427 "EHLO
        rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492457Ab0EJVcm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 May 2010 23:32:42 +0200
Authentication-Results: rtp-iport-2.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqwFAPIX6EutJV2a/2dsb2JhbACRX4xEcaMHmVGFFASDQQ
X-IronPort-AV: E=Sophos;i="4.53,202,1272844800"; 
   d="scan'208";a="109946947"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rtp-iport-2.cisco.com with ESMTP; 10 May 2010 21:32:35 +0000
Received: from xbh-rcd-202.cisco.com (xbh-rcd-202.cisco.com [72.163.62.201])
        by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id o4ALWZQ1012695;
        Mon, 10 May 2010 21:32:35 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-202.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 10 May 2010 16:32:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC PATCH 0/2] The Device Tree Patch for MIPS
Date:   Mon, 10 May 2010 16:32:34 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400DC64133@XMB-RCD-208.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 0/2] The Device Tree Patch for MIPS
Thread-Index: AcrwiE2Kxdp67lxkSEmhUR3BghfpGA==
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     <linux-mips@linux-mips.org>
Cc:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        "Grant Likely" <grant.likely@secretlab.ca>
X-OriginalArrivalTime: 10 May 2010 21:32:35.0309 (UTC) FILETIME=[4E48C1D0:01CAF088]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

The device tree applies an ascii format to describe a hardware layout,
which is then converted into a flattened binary representation by dtc
(the "device tree compiler"). A bootloader supporting device trees loads
the flattened device tree into memory as a binary blob, and passes the
linux kernel a pointer to this blob. The kernel then uses a built-in
device tree parser to interpret the hardware layout.

The device tree code had been in some of platforms (powerpc, sparc, and
microblaze) for a long period, it has been ported to ARM platform
recently. Grant Likely (the device tree maintainer,
glikely@secretlab.ca) has put a lot of effort to eliminate the
duplication in arch-specific code (like prior 2.6.33.1 kernel) so that
it becomes easy to get the device tree working with a new platform.

The patches are intended to support the device tree in MIPS. It is
ported against the new test branch (git://git.secretlab.ca/git/linux-2.6
test-devicetree).


Dezhong
