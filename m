Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 15:44:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53367 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029648AbcEQNocw6PVc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 15:44:32 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id A8F6C43D24CBD;
        Tue, 17 May 2016 14:44:23 +0100 (IST)
Received: from [10.20.78.220] (10.20.78.220) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 17 May 2016
 14:44:26 +0100
Date:   Tue, 17 May 2016 14:44:19 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: MSA: Fix a link error on `_init_msa_upper' with
 older GCC
In-Reply-To: <20160517131654.GI14481@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1605171440100.6794@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605162325170.6794@tp.orcam.me.uk> <20160517131654.GI14481@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.220]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53485
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

On Tue, 17 May 2016, Ralf Baechle wrote:

> > --- a/vmlinux.dump	2016-05-17 01:01:03.655891000 +0100
> > +++ b/vmlinux.dump	2016-05-17 02:11:49.264564000 +0100
> 
> Applied with this junk segment dropped.

 Ah, I didn't realise it would confuse `git am' -- otherwise I would have 
escaped it or mangled somehow.  Thanks for taking care of it then.

  Maciej
