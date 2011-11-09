Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 06:26:20 +0100 (CET)
Received: from ams-iport-3.cisco.com ([144.254.224.146]:43299 "EHLO
        ams-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903541Ab1KIF0M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 06:26:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=1220; q=dns/txt;
  s=iport; t=1320816371; x=1322025971;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=qWvQXTzVeWK0qkUj6GZJ/b1MTdb1z4a0+UfOIl5u5bs=;
  b=lBSjrSrI8ZEdSbyW2epdsYugQy+1mzlqmMJ/2hluLeDDgc7cdFY9CaQk
   ThG2Dq7Tc7gZ7uG53KScwYE86RmHKVp/NVYz6qGdrPSXksgnWn93laUYO
   6gR/21zSWNIOBEVv/KeOiVPJo9sy3yGqfWlaxkBmvQBcs7svBwTHQ0u/b
   o=;
X-IronPort-AV: E=Sophos;i="4.69,481,1315180800"; 
   d="scan'208";a="2686989"
Received: from ams-core-2.cisco.com ([144.254.72.75])
  by ams-iport-3.cisco.com with ESMTP; 09 Nov 2011 05:26:05 +0000
Received: from manesoni-ws.cisco.com (dhcp-72-163-207-192.cisco.com [72.163.207.192])
        by ams-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id pA95Q5jV027390;
        Wed, 9 Nov 2011 05:26:05 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id 5377981D60; Wed,  9 Nov 2011 10:56:07 +0530 (IST)
Date:   Wed, 9 Nov 2011 10:56:07 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     David Daney <david.daney@cavium.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "ananth@in.ibm.com" <ananth@in.ibm.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/4] MIPS Kprobes: Fix OOPS in arch_prepare_kprobe()
Message-ID: <20111109052607.GA20317@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111108170336.GA16526@cisco.com>
 <20111108170454.GB16526@cisco.com>
 <4EB989B9.2060904@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB989B9.2060904@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7459

On Tue, Nov 08, 2011 at 11:57:45AM -0800, David Daney wrote:
> On 11/08/2011 09:04 AM, Maneesh Soni wrote:
> [...]
> >
> >diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
> >index ee28683..9fb1876 100644
> >--- a/arch/mips/kernel/kprobes.c
> >+++ b/arch/mips/kernel/kprobes.c
> >@@ -25,6 +25,7 @@
> >
> >  #include<linux/kprobes.h>
> >  #include<linux/preempt.h>
> >+#include<linux/uaccess.h>
> >  #include<linux/kdebug.h>
> >  #include<linux/slab.h>
> >
> >@@ -118,11 +119,19 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  	union mips_instruction prev_insn;
> >  	int ret = 0;
> >
> >-	prev_insn = p->addr[-1];
> >  	insn = p->addr[0];
> >
> >-	if (insn_has_delayslot(insn) || insn_has_delayslot(prev_insn)) {
> >-		pr_notice("Kprobes for branch and jump instructions are not supported\n");
> >+	if (insn_has_delayslot(insn)) {
> >+		pr_notice("Kprobes for branch and jump instructions are not"
> >+			  "supported\n");
> 
> Don't wrap these strings.
> 
> It is better to go a little bit over 80 columns, than have this.
> 
> David Daney

Ok.. will keep that in mind for future patches. This line actually
goes away in patch 4/4.

Thanks
Maneesh
