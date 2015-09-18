Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2015 23:06:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57126 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008679AbbIRVF6ctAtD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2015 23:05:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 48D51CF549894;
        Fri, 18 Sep 2015 22:05:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Sep 2015 22:05:52 +0100
Received: from localhost (192.168.159.178) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 18 Sep
 2015 22:05:51 +0100
Date:   Fri, 18 Sep 2015 14:05:49 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Jacek Anaszewski <j.anaszewski@samsung.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@gmail.com>,
        "Richard Purdie" <rpurdie@rpsys.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-leds@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
Message-ID: <20150918210549.GD16992@NP-P-BURTON>
References: <20150803150401.GD2843@linux-mips.org>
 <55FA7BA0.4080706@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <55FA7BA0.4080706@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.178]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49240
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

On Thu, Sep 17, 2015 at 10:36:48AM +0200, Jacek Anaszewski wrote:
> Hi Ralf,
> 
> This patch got stuck somewhere in my mailbox and just
> recently showed up to my eyes again, so I applied it to v4.3-rc1, but when
> tried to compile-test it, I got following errors:
> 
> arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
> arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member
> named 'uc_extcontext'
>   return &uc->uc_extcontext;
>             ^

<snip...>

> Compilation succeeds with v4.2-rc8.
> Is it a known issue?

Hi Jacek,

The patches adding the MSA extended context added a MIPS-specific
ucontext.h, where we were previously were using the generic one. Kbuild
doesn't automatically remove the old generated header that includes the
generic version, so could you try either cleaning your working tree or
removing arch/mips/include/generated and trying again?

Thanks,
    Paul
