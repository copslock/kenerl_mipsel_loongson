Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 02:07:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13412 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007995AbcCABG5ioVb8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 02:06:57 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AA426D688189E;
        Tue,  1 Mar 2016 01:06:47 +0000 (GMT)
Received: from [10.100.200.79] (10.100.200.79) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 1 Mar 2016
 01:06:51 +0000
Date:   Tue, 1 Mar 2016 01:06:49 +0000
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
In-Reply-To: <CAAhV-H4hZM_xoe85WkB1cLwNv6XS5egpEjmV=t8RA=YANTs7rQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1603010025240.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-8-git-send-email-chenhc@lemote.com> <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk> <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
 <alpine.DEB.2.00.1602251221250.15885@tp.orcam.me.uk> <CAAhV-H4hZM_xoe85WkB1cLwNv6XS5egpEjmV=t8RA=YANTs7rQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.79]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52372
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

> Yes, we can probe whether the platform support ei/di or not. But
> whether use ei/di is not depend on runtime flag, but depend on
> CONFIG_* in current kernel. So I have no idea how to use ei/di by
> probing.

 OK, I think I have a full picture now.

 There's no need to probe, but I think the commit description and config 
text option are a bit misleading.  This looks like the next architecture 
revision to me, much like MIPS32r1 vs MIPS32r2 for example, and it is 
quite normal that you don't probe for the new features it provides (even 
though -- sticking to the example -- we could probe for MIPS32r2 
additions), but you just require whoever configures the kernel to choose 
the intended setup.  IOW it's a design decision rather than a technical 
limitation.

 So may I suggest that you rewrite the relevant part of the help text to 
read:

"This option enables those enhancements which are not probed at run time."

or suchlike?  And then similarly in the commit description.

 Thanks,

  Maciej
