Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 00:29:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012176AbaJVW3nm43qd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 00:29:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EE8A1DD56FD93;
        Wed, 22 Oct 2014 23:29:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Oct 2014 23:29:36 +0100
Received: from localhost (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 23:29:36 +0100
Date:   Wed, 22 Oct 2014 23:29:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <blogic@openwrt.org>
CC:     <eunb.song@samsung.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
Message-ID: <20141022222936.GE12296@jhogan-linux.le.imgtec.org>
References: <1061520101.169091413960858532.JavaMail.weblogic@epmlwas02b>
 <544758AB.3060100@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <544758AB.3060100@openwrt.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi John,

On Wed, Oct 22, 2014 at 09:11:39AM +0200, John Crispin wrote:
> On 22/10/2014 08:54, Eunbong Song wrote:
> >>> +void arch_trigger_all_cpu_backtrace(bool); +#define
> >>> arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
> > 
> >> What is the purpose of this define ? is this maybe a leftover from
> >> some regex/cleanups ?
> > 
> > Hi John.
> > Actually, I just follow the same function of sparc architecture.
> > You can find this in arch/sparc/include/asm/irq_64.h as below
> > 
> > void arch_trigger_all_cpu_backtrace(bool);
> > #define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
> > 
> > I guess this is used for conditional compile. 
> > See below.
> > include/linux/nmi.h
> > #ifdef arch_trigger_all_cpu_backtrace
> > static inline bool trigger_all_cpu_backtrace(void)
> > {
> >         arch_trigger_all_cpu_backtrace(true);
> > 
> >         return true;
> > }
> > static inline bool trigger_allbutself_cpu_backtrace(void)
> > {
> >         arch_trigger_all_cpu_backtrace(false);
> >         return true;
> > }
> > #else
> > static inline bool trigger_all_cpu_backtrace(void)
> > {
> >         return false;
> > }
> > static inline bool trigger_allbutself_cpu_backtrace(void)
> > {
> >         return false;
> > }
> > #endif
> > 
> > Thanks. 
> >> John
> > 
> 
> i don't see how this is required for conditional compiles. the code
> define a->a which is bogus i think.

It's a pretty common pattern in the asm headers, in order to allow
generic code to use the preprocessor to see whether it was defined or
not.

Cheers
James
