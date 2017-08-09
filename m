Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 13:09:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57911 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995200AbdHILJCIWh-l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 13:09:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 10DC95F69B6FD;
        Wed,  9 Aug 2017 11:53:24 +0100 (IST)
Received: from [10.20.78.47] (10.20.78.47) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 9 Aug 2017
 11:53:25 +0100
Date:   Wed, 9 Aug 2017 11:53:15 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH] MIPS: math-emu: do not use bools for arithmetic
In-Reply-To: <CAOLZvyEH_5kBGq2Yn9YmfbJghnPKtkpbh9Lpo7AbJxrmh=-6Qw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1708091151430.17596@tp.orcam.me.uk>
References: <20170731092151.116438-1-manuel.lauss@gmail.com> <alpine.DEB.2.00.1708090349390.17596@tp.orcam.me.uk> <CAOLZvyEH_5kBGq2Yn9YmfbJghnPKtkpbh9Lpo7AbJxrmh=-6Qw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.47]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59454
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

On Wed, 9 Aug 2017, Manuel Lauss wrote:

> >  What exactly are you unsure about?  Double operations using odd register
> > indices in the 32-bit FPR mode are architecturally unpredictable.  Is this
> > what concerns you?
> 
> I was not able to find a definition for get_fpr by grepping the tree
> for it, so I wasn't
> sure whether only the LSB or all mattered.

 It's in arch/mips/include/asm/processor.h; see BUILD_FPR_ACCESS.

  Maciej
