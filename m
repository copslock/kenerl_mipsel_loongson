Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2014 02:13:46 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:32585 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817420AbaHMANoBr09q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2014 02:13:44 +0200
X-IronPort-AV: E=Sophos;i="5.01,852,1400050800"; 
   d="scan'208";a="42128767"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 12 Aug 2014 17:26:44 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 12 Aug 2014 17:13:34 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Tue, 12 Aug 2014 17:13:34 -0700
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 E3D849F9F7;    Tue, 12 Aug 2014 17:13:31 -0700 (PDT)
Date:   Wed, 13 Aug 2014 05:48:50 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Move CPU topology macros to topology.h
Message-ID: <20140813001849.GA27602@jayachandranc.netlogicmicro.com>
References: <1407467768-24097-1-git-send-email-chenhc@lemote.com>
 <20140808134738.GG29898@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20140808134738.GG29898@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42066
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

On Fri, Aug 08, 2014 at 03:47:38PM +0200, Ralf Baechle wrote:
> Jayachandran,
> 
> could you convert the netlogic platforms to use this scheme, too?
> We then could drop the #ifdefs introduced by this patch.

The same sequence is used by ip27 platform as well, so I think the
ifndef may still be needed. This is the same ifndef pattern we use
for all our mach-generic/*.h vs. mach-<platform>/*.h

On second thought, I am not sure if the changes in Huacai's patch
has to be in asm/topology.h, probably this has to be in
mach-generic/topology.h

JC.
