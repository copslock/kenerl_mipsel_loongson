Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 10:32:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12114 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008889AbbGNIczioOux (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 10:32:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0DF34D395D58A;
        Tue, 14 Jul 2015 09:32:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 09:32:49 +0100
Received: from localhost (10.100.200.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 09:32:49 +0100
Date:   Tue, 14 Jul 2015 09:32:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: PCI: ops-emma2rh: drop nonsensical db_assert
Message-ID: <20150714083248.GE2519@NP-P-BURTON>
References: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
 <20150714083029.GA25179@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150714083029.GA25179@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.168]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48259
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

On Tue, Jul 14, 2015 at 10:30:30AM +0200, Ralf Baechle wrote:
> On Mon, Jul 13, 2015 at 05:14:21PM +0100, Paul Burton wrote:
> 
> > The db_assert call checks whether the bus_num pointer is non-NULL, but
> > does so after said pointer has been dereferenced by the assignment on
> > the previous line. Thus the check is pointless & likely to have been
> > optimised out by the compiler anyway. The check_args function is static
> > & only ever called from the local file with bus_num being a pointer to
> > an on-stack variable, so the check seems somewhat overzealous anyway.
> > Simply remove it.
> 
> Thanks, applied.
> 
> Your patch btw. leaves the db_verify() macro as the sole caller of
> db_assert() and db_verify() itself is unused and in fact, nothing
> includes <asm/debug.h> anymore.  Removing <asm/debug.h> leaves
> CONFIG_RUNTIME_DEBUG unused, so I'm removing that one, too.
> 
>   Ralf

Hi Ralf,

That's precisely what led me to write this patch, and precisely what the
following patch I submitted (MIPS: drop CONFIG_RUNTIME_DEBUG & debug.h)
does:

    http://patchwork.linux-mips.org/patch/10693/

Thanks,
    Paul
