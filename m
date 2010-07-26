Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 22:44:31 +0200 (CEST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:10340 "EHLO
        rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490951Ab0GZUoY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jul 2010 22:44:24 +0200
Authentication-Results: rtp-iport-2.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEADOQTUytJV2Y/2dsb2JhbACfY3GoUJschTYEhAiEAIMWDAE
X-IronPort-AV: E=Sophos;i="4.55,263,1278288000"; 
   d="scan'208";a="139439817"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rtp-iport-2.cisco.com with ESMTP; 26 Jul 2010 20:44:13 +0000
Received: from xbh-rcd-301.cisco.com (xbh-rcd-301.cisco.com [72.163.63.8])
        by rcdn-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id o6QKiCgC025443;
        Mon, 26 Jul 2010 20:44:12 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-301.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Jul 2010 15:44:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] MIPS: Apply kmap_high_get on DMA functions.
Date:   Mon, 26 Jul 2010 15:44:13 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D013F9D97@XMB-RCD-208.cisco.com>
In-Reply-To: <AANLkTinBb3SN1DRL9Zt8Mu1fAYgsx9VRm4FwBz4oNfdq@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MIPS: Apply kmap_high_get on DMA functions.
Thread-Index: Acsq3NA/mwAsAq+OTvaeXVMvXPhA6wCJYu+Q
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     "Kevin Cernekee" <cernekee@gmail.com>
Cc:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
X-OriginalArrivalTime: 26 Jul 2010 20:44:12.0943 (UTC) FILETIME=[4E2599F0:01CB2D03]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

It is not a problem our hardware supports DMA directly to high memory.

It reminds me we submitted a patch which fixed problem when the high
memory is used for DMA, but it wasn't accepted.


Dezhong


-----Original Message-----
From: Kevin Cernekee [mailto:cernekee@gmail.com] 
Sent: Friday, July 23, 2010 8:04 PM
To: Dezhong Diao (dediao)
Cc: linux-mips@linux-mips.org; ralf@linux-mips.org; David VomLehn
(dvomlehn)
Subject: Re: [PATCH] MIPS: Apply kmap_high_get on DMA functions.

On Fri, Jul 23, 2010 at 6:43 PM, Dezhong Diao <dediao@cisco.com> wrote:
> I don't recommend to do that in such a way (such as ARM does). In 
> MIPS, we normally setup the mapping before the dma function is
invoked. That means there is something wrong if addr is 0.

I don't understand the HIGHMEM / VM code well enough yet to
intelligently comment on this assumption.  And it looks like the ARM
developers are still trying to sort out whether their code is doing the
right thing in all circumstances:

http://www.spinics.net/lists/arm-kernel/msg89465.html

But if the (addr == 0) condition should never occur on a properly
functioning system, I would rather see an error message than be forced
to debug a mysterious coherency problem caused by missing flushes.

Any chance you could add a BUG() in the else clause?

BTW: are you supporting DMA directly to high memory?

Thanks.
