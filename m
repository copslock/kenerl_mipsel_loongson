Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 13:04:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4098 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011293AbbHFLEs4-lqf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 13:04:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 659DE8BBF698F;
        Thu,  6 Aug 2015 12:04:40 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 12:04:43 +0100
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0235.001; Thu, 6 Aug 2015 12:04:42 +0100
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle (ralf@linux-mips.org)" <ralf@linux-mips.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH 0/6] MIPS CPS SMP fixes, debug & cleanups
Thread-Topic: [PATCH 0/6] MIPS CPS SMP fixes, debug & cleanups
Thread-Index: AQHQz9AoStHQX3wXz0WEZqZBh8PF053+zoNQ
Date:   Thu, 6 Aug 2015 11:04:41 +0000
Message-ID: <4BF5E8683E87FC4DA89822A5A3EB60CB6F2122@hhmail02.hh.imgtec.org>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
Accept-Language: en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.167.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Govindraj.Raja@imgtec.com
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

Hi Paul / Rafl,

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Paul Burton
> Sent: 05 August 2015 11:43 PM
> To: linux-mips@linux-mips.org
> Cc: Paul Burton; linux-kernel@vger.kernel.org; James Hogan; Markos Chandras;
> Ralf Baechle
> Subject: [PATCH 0/6] MIPS CPS SMP fixes, debug & cleanups
> 
> This series fixes a few issues with the MIPS Coherent Processing System SMP
> implementation, provides some extra capabilities with regards to debug and does
> a little spring cleaning. A couple of the issues fixed were introduced in v4.1-rc1
> and (spuriously) marked for stable backports as far as v3.16, so the fixes in this
> series are marked likewise.
> 
> Applies atop v4.2-rc5.
> 
> Paul Burton (6):
>   MIPS: CPS: use 32b accesses to GCRs
>   MIPS: CPS: stop dangling delay slot from has_mt
>   MIPS: CPS: don't include MT code in non-MT kernels
>   MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
>   MIPS: CONFIG_MIPS_MT_SMP should depend upon CPU_MIPSR2
>   MIPS: CPS: drop .set mips64r2 directives
> 
>  arch/mips/Kconfig          |  2 +-
>  arch/mips/kernel/cps-vec.S | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)

I just boot tested on Pistachio Platform (MIPS interAptiv (multi) (32)).
Without this patch series boot is broken for pistachio platform for 4.2-rc5.

--
Thanks,
Govindraj.R
