Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 23:19:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45983 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026713AbcDOVTtkASMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 23:19:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 2CA62F509E4F2;
        Fri, 15 Apr 2016 22:19:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 22:19:43 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 22:19:42 +0100
Date:   Fri, 15 Apr 2016 22:19:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Jonas Gorski <jogo@openwrt.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 03/12] MIPS: Remove redundant asm/pgtable-bits.h
 inclusions
Message-ID: <20160415211942.GA21163@NP-P-BURTON>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <1460716620-13382-4-git-send-email-paul.burton@imgtec.com>
 <20160415191640.GE7859@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160415191640.GE7859@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Apr 15, 2016 at 08:16:40PM +0100, James Hogan wrote:
> On Fri, Apr 15, 2016 at 11:36:51AM +0100, Paul Burton wrote:
> > asm/pgtable-bits.h is included in 2 assembly files and thus has to
> > in either of the assembly files that include it.
> 
> That could do with rewording :-)

Oops, it appears that I accidentally some words.

Originally there was an extra line in the middle so that it read
something like:

  asm/pgtable-bits.h is included in 2 assembly files and thus has to
  #ifdef around C code, however nothing defined by the header is used
  in either of the assembly files that include it.

Ralf: Would you be ok with adding back that line to the commit message
      if this gets merged without needing a v2?

> Otherwise
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks James :)

Paul
