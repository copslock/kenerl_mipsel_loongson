Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 18:42:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:58482 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeBBRmDf7DK7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 18:42:03 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 02 Feb 2018 17:40:42 +0000
Received: from [10.20.78.136] (10.20.78.136) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Fri, 2 Feb 2018
 09:38:13 -0800
Date:   Fri, 2 Feb 2018 17:38:00 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Vladimir Murzin" <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/6] MIPS: BMIPS: Avoid referencing CKSEG1
In-Reply-To: <1516758426-8127-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.00.1802012034400.4191@tp.orcam.me.uk>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com> <1516758426-8127-4-git-send-email-f.fainelli@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1517593241-321458-20196-2127-13
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189619
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Tue, 23 Jan 2018, Florian Fainelli wrote:

> bmips_smp_movevec() references the CKSEG1 constant, which is about to be
> updated in order to support processors that might enable eXtended
> KSEG0/1. In doing so, we will generate a reference to a function, which
> is obviously not permissible within assembly. Fortunately,
> bmips_smp_movevec() is only used on BMIPS4350 which does not support
> eXtended KSEG0/1.

 Can you please avoid replacing the macro with a hardcoded magic number 
though, so that it retains the high-level meaning?

 Define another macro, say MIPS_ARCH_CKSEG1, and use it here instead, and 
possibly elsewhere too.  You could complement it with BMIPS_XKS01_CKSEG1 
if necessary too (I haven't thoroughly looked through your patches).

  Maciej
