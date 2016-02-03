Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:55:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60689 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012139AbcBCQzvxtUct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:55:51 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 323D64B4B7AF1;
        Wed,  3 Feb 2016 16:55:43 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 3 Feb 2016
 16:55:45 +0000
Date:   Wed, 3 Feb 2016 16:55:44 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 1/5] MIPS: Bail on unsupported module relocs
In-Reply-To: <20160203161517.GE30470@NP-P-BURTON>
Message-ID: <alpine.DEB.2.00.1602031636220.15885@tp.orcam.me.uk>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com> <1454471085-20963-2-git-send-email-paul.burton@imgtec.com> <alpine.DEB.2.00.1602031139250.15885@tp.orcam.me.uk> <20160203161517.GE30470@NP-P-BURTON>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 3 Feb 2016, Paul Burton wrote:

> >  Hmm, this looks like a fatal error condition to me, the module won't 
> > load.  Why `pr_warn' rather than `pr_err' then?  Likewise in the other 
> > file.
> 
> To me fatality implies death, and nothing dies here. The module isn't
> loaded but that's done gracefully & is not likely due to an error in the
> kernel - it's far more likely that the module isn't valid. So to me,
> warning seems appropriate rather than implying an error in the kernel.

 It may be bikeshedding, however these levels affect what goes to syslog 
and the console.  There are `crit', `alert' and `emerg' levels above, to 
raise more severe conditions.  As to `warn' I'd expect one on a succesful 
action made with some limitations, e.g. a compatibility mode of some kind, 
running with a performance limitation, some functionality disabled, etc.  
There's also `notice', which is lower, I'd use for normal actions that 
might require operator's attention, e.g. I'd put switching a network 
interface into the promiscuous mode there, due to its side effect on 
overall system performance.

 And I don't think it has to be a bug in the kernel to raise an `err' 
condition.  However I do agree the boundary here may be a bit fuzzy and 
code you've been changing doesn't seem consistent either.

 FWIW,

  Maciej
