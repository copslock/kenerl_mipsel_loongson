Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2011 21:16:42 +0200 (CEST)
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:28120 "EHLO
        mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab1JMTQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2011 21:16:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=kamensky@cisco.com; l=1300; q=dns/txt;
  s=iport; t=1318533395; x=1319742995;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kCOm0p0jHIuwKTTRh9wRM7Z9XdZNQGDZhM07BaFeitU=;
  b=SyWH2BkMfgquu7qOsvBqHOjr3y69BqFyLG9pVg6UU+Tu8vwuD8phbGoO
   TVH8wyYsf1WIxk6JEe1mdogbFN5Ed370K5vSSl4pX/CSpf8yI7Rl37ho7
   MSLtnv/4mxZpSyEa80gT8eZAwr2pa5BAgx/MpbCdWcVTb46jZzVrOe57l
   4=;
X-IronPort-AV: E=Sophos;i="4.69,342,1315180800"; 
   d="scan'208";a="7734723"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by mtv-iport-3.cisco.com with ESMTP; 13 Oct 2011 19:16:28 +0000
Received: from infra-view9 (infra-view9.cisco.com [171.70.70.104])
        by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p9DJGRFZ023626;
        Thu, 13 Oct 2011 19:16:27 GMT
Date:   Thu, 13 Oct 2011 12:16:27 -0700 (PDT)
From:   Victor Kamensky <kamensky@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     David Daney <david.daney@cavium.com>, manesoni@cisco.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ananth@in.ibm.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
In-Reply-To: <20111013180714.GA7422@linux-mips.org>
Message-ID: <Pine.GSO.4.58.1110131205410.7452@infra-view9.cisco.com>
References: <20111013090749.GB16761@cisco.com> <4E971FD3.2020308@cavium.com>
 <20111013180714.GA7422@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamensky@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9512



On Thu, 13 Oct 2011, Ralf Baechle wrote:

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

David, nice catch!

> Which is a wonderful demonstration for why duplicating such a large
> function from branch.c was a baaad thing to do.
>
> Maneesh, can you refactor the code to share everything that was copied
> from __compute_return_epc() can be shared with kprobes?  Idealy make
> everything a two part series, first one patch to refactor branch.c

Yes, it does make a lot of sense. Don't you think we need to do
EXPORT_SYMBOL for __compute_return_epc as well? So it could be used by
klms.

Actually we have yet another copy of it in mips uprobes code, which
normally is built as klm, if we refactor and export __compute_return_epc
all three places could use the same function.

Thanks,
Victor

> and
> the 2nd patch to deal with kprobes.
>
> Thanks,
>
>   Ralf
>
