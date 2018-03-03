Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 11:20:18 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:36450 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeCCKUKw6DRm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 11:20:10 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 03 Mar 2018 10:19:55 +0000
Received: from [10.20.78.175] (10.20.78.175) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 3 Mar 2018
 01:38:31 -0800
Date:   Sat, 3 Mar 2018 09:38:18 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: Loongson64: Select
 ARCH_MIGHT_HAVE_PC_PARPORT
In-Reply-To: <1520060919.13983.3.camel@flygoat.com>
Message-ID: <alpine.DEB.2.00.1803030935510.10166@tp.orcam.me.uk>
References: <1519871862-14624-1-git-send-email-chenhc@lemote.com>  <alpine.DEB.2.00.1803021204250.10166@tp.orcam.me.uk> <1520060919.13983.3.camel@flygoat.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1520072394-452060-9092-75032-12
X-BESS-VER: 2018.2.1-r1802232342
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190629
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
X-archive-position: 62789
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

On Fri, 2 Mar 2018, Jiaxun Yang wrote:

> >  Hmm, I don't think the Fuloong(2e) machine has a parallel port
> > connector.  
> > The chipset may support the port, but with no external connection I
> > think 
> > there's no point in enabling it.  Or am I missing something?
> Thanks for your advice.
> Some other Loongson-2E devices share the same kernel entry with
> Fuloong-2E.
> And the 2E desktop PC has a parallel port. So we enable it for these
> devices.

 Ah, OK then, thanks for the clarification.  Would you mind updating the 
Kconfig description for LEMOTE_FULOONG2E to actually list the systems it 
covers then?

  Maciej
