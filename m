Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 19:12:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2038 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008158AbbIURMWF9mRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 19:12:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BF8EC3F455B2B;
        Mon, 21 Sep 2015 18:12:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Sep 2015 18:12:16 +0100
Received: from localhost (192.168.159.181) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 21 Sep
 2015 18:12:15 +0100
Date:   Mon, 21 Sep 2015 10:12:13 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: [BISECTED] Linux 4.3-rc1 boot regression on OCTEON
Message-ID: <20150921171213.GA25587@NP-P-BURTON>
References: <20150915143850.GO1199@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150915143850.GO1199@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.181]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49254
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

On Tue, Sep 15, 2015 at 05:38:50PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> OCTEON+/OCTEON II fails to boot with 4.3-rc1. Bisected to:
> 
> 1a3d59579b9f436da038f377309cf2270c76318e is the first bad commit
> commit 1a3d59579b9f436da038f377309cf2270c76318e
> Author: Paul Burton <paul.burton@imgtec.com>
> Date:   Mon Aug 3 08:49:30 2015 -0700
> 
>     MIPS: Tidy up FPU context switching

Hi Aaro,

Sorry about that! This patch I've just submitted should fix it up:

    http://marc.info/?l=linux-mips&m=144285532009315&w=2

Let me know if not.

Ralf: can we get those 2 FP fixes (11166 & 11167 in patchwork) into v4.3
      please?

Thanks,
    Paul
