Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 18:11:53 +0100 (CET)
Received: from ams-iport-4.cisco.com ([144.254.224.147]:42711 "EHLO
        ams-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab1KHRLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 18:11:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=489; q=dns/txt;
  s=iport; t=1320772305; x=1321981905;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=jzx2jXq2u+ulyJqyT1qRXactLSFYgcW3/0H6AuYMfKo=;
  b=X80iW3UD/SJy88e1MkcAJmbdH5oO3J4oP/k4V6x9yqe5hGn1F0/eCg7M
   nLq4p2HCh8E7h2kzADhfLYUySI9YNfUGYvjPucQzFJcH5BHdcx1zxFRJe
   oEZP1ww9hOF+y5CfY02W8k3ekEnGHMWT+FWNxMz4WIUUPPRwigtHjQUJI
   U=;
X-IronPort-AV: E=Sophos;i="4.69,477,1315180800"; 
   d="scan'208";a="2658710"
Received: from ams-core-3.cisco.com ([144.254.72.76])
  by ams-iport-4.cisco.com with ESMTP; 08 Nov 2011 17:11:40 +0000
Received: from manesoni-ws.cisco.com ([10.65.74.254])
        by ams-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id pA8HBdTc017957;
        Tue, 8 Nov 2011 17:11:39 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id 0443181D98; Tue,  8 Nov 2011 22:33:36 +0530 (IST)
Date:   Tue, 8 Nov 2011 22:33:36 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, ananth@in.ibm.com,
        kamensky@cisco.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 0/4] MIPS Kprobes
Message-ID: <20111108170336.GA16526@cisco.com>
Reply-To: manesoni@cisco.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6930


Hi Ralf,

Here is a set of 4 patches for MIPS kprobes. The first two are addressing 
a couple of baseline issues and the remaining two are the 2nd attempt for
allowing kprobes on jump and branch instructions based on the comments I got
earlier
	https://lkml.org/lkml/2011/10/13/106

1) Fix OOPS in arch_prepare_kprobe for MIPS 
2) Deny probes on ll sc instructions for MIPS
3) Refactoring Branch emulation
4) Support for branch instructions probing (v2)


Thanks
Maneesh
