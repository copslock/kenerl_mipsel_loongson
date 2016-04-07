Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 08:47:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43865 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025659AbcDGGrBK5YYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 08:47:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 5288AB243AEF2;
        Thu,  7 Apr 2016 07:46:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 7 Apr 2016 07:46:55 +0100
Received: from localhost (10.100.200.148) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 7 Apr
 2016 07:46:54 +0100
Date:   Thu, 7 Apr 2016 07:46:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
Message-ID: <20160407064654.GB20863@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <20160407000658.GA11065@NP-P-BURTON>
 <CAOLZvyErcw4kyLsLPoqCCBcxoK3L4OPykQLFaWRs6bLrPXK5zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAOLZvyErcw4kyLsLPoqCCBcxoK3L4OPykQLFaWRs6bLrPXK5zg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.148]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52919
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

On Thu, Apr 07, 2016 at 08:40:17AM +0200, Manuel Lauss wrote:
> On Thu, Apr 7, 2016 at 2:06 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> > git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb
> 
> 
> Hi Paul,
> 
> This branch does indeed boot again, and PCI/PCMCIA work as well.
> 
> Thank you for looking at this!
>       Manuel

Thanks for that Manuel :)

Am I OK to add your Tested-by to the current last patch in that branch
("MIPS: Fix MIPS32 36b physical addressing (alchemy, netlogic)")?

Paul
