Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 12:02:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14582 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007194AbcBYLCKhiDb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 12:02:10 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 20395F3C46679;
        Thu, 25 Feb 2016 11:02:03 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 25 Feb 2016
 11:02:03 +0000
Date:   Thu, 25 Feb 2016 11:02:00 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
In-Reply-To: <CAAhV-H7MDTRWoDx-j-DHH1UnUmhb1CFK1go-W+Qxz+8W21qrhg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1602251050290.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-2-git-send-email-chenhc@lemote.com> <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk> <56CE5382.4090800@gmail.com>
 <CAAhV-H7MDTRWoDx-j-DHH1UnUmhb1CFK1go-W+Qxz+8W21qrhg@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52255
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

On Thu, 25 Feb 2016, Huacai Chen wrote:

> I *do* have answered your quesition, which you can see here:
> https://patchwork.linux-mips.org/patch/12240/
> 
> When unaligned access triggered, do_ade() will access user address
> with EXL=1, and that may trigger tlb refill.

 Thank you and I can see your original answer as well, which would need to 
go into the patch description itself, however it is too vague for me I'm 
afraid.

 Unaligned accesses have been likewise handled since forever and no one 
else has hit an issue with `do_ade' making user accesses with EXL=1, as 
this handler is only called once KMODE has cleared EXL.  So please explain 
us the scenario in which it doesn't happen and you still have EXL=1 in 
`do_ade'.  What the conditions for this to be the case?

 Without a further explanation it looks like a bug elsewhere to me, which 
needs to be treated accordingly there, rather than by complicating TLB 
handlers.

  Maciej
