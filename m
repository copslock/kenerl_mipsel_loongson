Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 14:07:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:18807 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821742AbaDYMG7N2fZS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 14:06:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 43004A9CAE919;
        Fri, 25 Apr 2014 13:06:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 25 Apr 2014 13:06:52 +0100
Received: from localhost (192.168.154.57) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 25 Apr
 2014 13:06:51 +0100
Date:   Fri, 25 Apr 2014 13:06:54 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] MIPS: net: Add BPF JIT
Message-ID: <20140425120654.GA30753@mchandras-linux.le.imgtec.org>
References: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com>
 <1398351013-29490-1-git-send-email-markos.chandras@imgtec.com>
 <20140424163114.GD36716@pburton-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140424163114.GD36716@pburton-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.57]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Thu, Apr 24, 2014 at 05:31:14PM +0100, Paul Burton wrote:
> On Thu, Apr 24, 2014 at 03:50:13PM +0100, Markos Chandras wrote:
> > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > new file mode 100644
> > index 0000000..864e5b7
> > --- /dev/null
> > +++ b/arch/mips/net/bpf_jit.c
> 
> ... cut ...
> 
> > +			off = offsetof(struct sk_buff, protocol);
> > +			emit_half_load(r_A, r_skb, off, ctx);
> > +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> > +			/* This needs little endian fixup */
> > +			if (cpu_has_mips_r1) {
> 
> Doesn't cpu_has_mips_r1 cover everything >= r1? ie. everything will now
> take this path, including systems >= r2. Don't you want the inverse
> (!cpu_has_mips_r2) instead?
> 
> Paul

Hi Paul,

Yes you are right. I will fix it and submit a new version.

-- 
markos
