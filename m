Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:50:33 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1676 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823011Ab3ADTubaT1P0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jan 2013 20:50:31 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 04 Jan 2013 11:47:13 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 4 Jan 2013 11:50:02 -0800
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0FE4B40FF1; Fri, 4
 Jan 2013 11:50:04 -0800 (PST)
Date:   Sat, 5 Jan 2013 01:21:58 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Hill, Steven" <sjhill@mips.com>
cc:     "David Daney" <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores.
Message-ID: <20130104195157.GA2140@jayachandranc.netlogicmicro.com>
References: <1357322355-31622-1-git-send-email-sjhill@mips.com>
 <50E71BF8.3050308@gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146AF100@exchdb03.mips.com>
MIME-Version: 1.0
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146AF100@exchdb03.mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7CF9EE4B3Q4705309-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jan 04, 2013 at 06:24:54PM +0000, Hill, Steven wrote:
> >> +#ifdef CONFIG_64BIT
> >> +                     (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
> >> +#else
> >> +                     (PGDIR_SHIFT - PAGE_SHIFT - 1));
> >> +#endif
> >> +             UASM_i_INS(p, ptr, tmp, (PTE_T_LOG2 + 1),
> >
> > As far as I can tell, (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1) and
> > (PGDIR_SHIFT - PAGE_SHIFT - 1) are the same thing.  So why the two cases?
> >
> >Can you give an example of where they might differ?
> >
> David,
> 
> Actually, no I cannot. The calculation was given to me by 'jchandra' and since I do not have 64-bit R2 hardware let alone the Broadcom platform, he said it worked on his platform and I took it from him as is. So does this patch work on Cavium platforms using both calculation methods? It would be nice if 'jchandra' could chime in, but he may be on holiday or something.

This does not really need hardware. On 64bit, with 16k page, the expansion of
the macro is (from tlbex.i):

uasm_i_dext(p, tmp, tmp, 14 +1, ((14 + (14 + 0 - 3)) + (14 + 0 - 3))-14 -1); 

This evaluates to 21, which is obviously wrong (should be 10).

I had sent the generated tlb handler which showed the incorrect size to sjhill,
but that probably got lost in the new year holiday mails.

JC.
