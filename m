Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2016 17:47:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28762 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006833AbcF2PrLRqUwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jun 2016 17:47:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4FB205F82FB88;
        Wed, 29 Jun 2016 16:47:01 +0100 (IST)
Received: from [10.20.78.239] (10.20.78.239) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 29 Jun 2016
 16:47:04 +0100
Date:   Wed, 29 Jun 2016 16:46:57 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [committed] MIPS/GAS: Fix an ISA override not lifting ABI
 restrictions
In-Reply-To: <alpine.DEB.2.00.1604220223310.21846@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1606291638060.4103@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1604212314170.21846@tp.orcam.me.uk> <20160422011230.GL24051@linux-mips.org> <alpine.DEB.2.00.1604220223310.21846@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.239]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54177
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

On Fri, 22 Apr 2016, Maciej W. Rozycki wrote:

> On Fri, 22 Apr 2016, Ralf Baechle wrote:
> 
> > Will the patch also work for 2.25 and 2.26?
> 
>  I expect it to -- it applies to both versions with a small fuzz in 
> gas/testsuite/gas/mips/mips.exp only.

 FYI, I have now backported the fix to both 2.26 and 2.25, and it'll be 
included in 2.26.1 currently being released.  No further maintenance 
release is planned for 2.25, however you can still build binutils from the 
Git tree or pick the patch and apply it on top of 2.25.1 if needed.

  Maciej
