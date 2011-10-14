Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2011 19:31:26 +0200 (CEST)
Received: from ams-iport-2.cisco.com ([144.254.224.141]:32937 "EHLO
        ams-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491102Ab1JNRbS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2011 19:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=1066; q=dns/txt;
  s=iport; t=1318613478; x=1319823078;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=sgyZMNQx0Srr5JqvCixPcO9cNQZYQaevx2IfCu0J5wU=;
  b=J2B9M7Hca+3vX2ADUEQljjwGgEg4p143ZPkKhup37ROUWnzy9FWSVGnt
   fijuVm8kqlPi8Q4bRQkwbUH62KvrauoNig9U37lbtyGkcIcaTfBrD/uWE
   I96+nWMWDI0UTJAM6YQQ30Zol3i1Kz3s1PjPHF4rolFOhtNcM+F4tkvSu
   4=;
X-IronPort-AV: E=Sophos;i="4.69,347,1315180800"; 
   d="scan'208";a="57827076"
Received: from ams-core-4.cisco.com ([144.254.72.77])
  by ams-iport-2.cisco.com with ESMTP; 14 Oct 2011 17:31:12 +0000
Received: from manesoni-ws.cisco.com ([10.65.83.37])
        by ams-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p9EHVBK7002818;
        Fri, 14 Oct 2011 17:31:12 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id 76F8581CA3; Fri, 14 Oct 2011 23:01:11 +0530 (IST)
Date:   Fri, 14 Oct 2011 23:01:11 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, ananth@in.ibm.com, kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111014173111.GB8521@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111013090749.GB16761@cisco.com>
 <4E971FD3.2020308@cavium.com>
 <20111013180714.GA7422@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111013180714.GA7422@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10585

On Thu, Oct 13, 2011 at 07:07:14PM +0100, Ralf Baechle wrote:
> On Thu, Oct 13, 2011 at 10:28:51AM -0700, David Daney wrote:
> 
> > Where is the handling for:
> > 
> > 	case cop1_op:
> > 
> > #ifdef CONFIG_CPU_CAVIUM_OCTEON
> > 	case lwc2_op: /* This is bbit0 on Octeon */
> > 	case ldc2_op: /* This is bbit032 on Octeon */
> > 	case swc2_op: /* This is bbit1 on Octeon */
> > 	case sdc2_op: /* This is bbit132 on Octeon */
> > #endif
> > 
> > These are all defined in insn_has_delayslot() but not here.
> 
> Which is a wonderful demonstration for why duplicating such a large
> function from branch.c was a baaad thing to do.
> 
> Maneesh, can you refactor the code to share everything that was copied
> from __compute_return_epc() can be shared with kprobes?  Idealy make
> everything a two part series, first one patch to refactor branch.c and
> the 2nd patch to deal with kprobes.
> 

Sure.. the branch likely instructions are not make it look good but
still do it in the next version.

Thanks for the comments.

Regards,
Maneesh
