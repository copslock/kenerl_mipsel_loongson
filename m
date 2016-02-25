Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 13:27:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33711 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008752AbcBYM0xYtJZ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 13:26:53 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9F84437C18B51;
        Thu, 25 Feb 2016 12:26:45 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 25 Feb 2016
 12:26:47 +0000
Date:   Thu, 25 Feb 2016 12:25:23 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V3 5/5] MIPS: Loongson-3: Introduce
 CONFIG_LOONGSON3_ENHANCEMENT
In-Reply-To: <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1602251221250.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-8-git-send-email-chenhc@lemote.com> <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk> <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52257
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

> Please read my explaination: New Loongson 3 has a bug that di
> instruction can not save the irqflag, so arch_local_irq_save() is
> modified. Since CPU_MIPSR2 is selected by
> CONFIG_LOONGSON3_ENHANCEMENT, generic kernel doesn't use ei/di at all
> (because old Loongson 3 doesn't support ei/di at all).

 Thanks.  This opens an interesting question though.  You've written that 
the enhancements controlled by CONFIG_LOONGSON3_ENHANCEMENT cannot be 
determined at the run time, but it looks to me like they can, either by 
checking for MIPSr2 in the CP0.Config.AR or, if you did something wrong 
about that, by trying to execute EI or DI early on and seeing if it's 
triggered an RI exception or not.

 Have I missed anything?

  Maciej
