Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 10:58:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27232 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007677AbaIRI6KRh9zW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 10:58:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 31BC1E2393711;
        Thu, 18 Sep 2014 09:58:01 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 18 Sep
 2014 09:58:03 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Sep 2014 09:58:03 +0100
Received: from localhost (192.168.159.106) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 18 Sep
 2014 09:58:00 +0100
Date:   Thu, 18 Sep 2014 09:57:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ed Swierk <eswierk@skyportsystems.com>,
        <linux-mips@linux-mips.org>, <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140918085756.GU17248@pburton-laptop>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
 <20140704085246.GH13532@linux-mips.org>
 <20140704090601.GZ804@pburton-laptop>
 <20140704093809.GI13532@linux-mips.org>
 <20140704113007.GA804@pburton-laptop>
 <alpine.LFD.2.11.1409132359450.11957@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1409132359450.11957@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.106]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42672
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

On Sun, Sep 14, 2014 at 12:06:03AM +0100, Maciej W. Rozycki wrote:
> On Fri, 4 Jul 2014, Paul Burton wrote:
> 
> > > > I'm in 2 minds about this - it sounds crazy but perhaps it's the most
> > > > sane option available :)
> > > 
> > > Sanity is overrated anyway ;-)
> > 
> > I had originally left this patch at the point I started considering
> > implementing emulation for the whole ISA in the kernel, figuring I was
> > going insane & should probably do something else for a while. Perhaps I
> > shouldn't worry so much ;)
> 
>  One question: does this emulation handle PC-relative instructions placed 
> in a branch delay slot correctly?  This only applies to microMIPS ADDIUPC 
> at the moment I believe, but still that has to work correctly whether on 
> FP hardware or emulated.
> 
>   Maciej

Hi Maciej,

That's a good question, and no I don't believe the current dsemul code
will handle that correctly. Perhaps that's another argument in favor of
the full on emulator...

Paul
