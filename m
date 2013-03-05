Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 14:06:42 +0100 (CET)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:63619 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827532Ab3CENGmL5zUR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Mar 2013 14:06:42 +0100
Received: from cpsps-ews24.kpnxchange.com ([10.94.84.190]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 5 Mar 2013 14:05:11 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews24.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 5 Mar 2013 14:05:10 +0100
Received: from [192.168.1.103] ([212.123.139.93]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 5 Mar 2013 14:06:35 +0100
Message-ID: <1362488795.16460.82.camel@x61.thuisdomein>
Subject: Re: [PATCH v2] MIPS: Get rid of CONFIG_CPU_HAS_LLSC again
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Mar 2013 14:06:35 +0100
In-Reply-To: <CAOiHx=nvH-Q+3HCkukM9ZDZXLm=w0bO9LPyosQS7UHOmOvQYOQ@mail.gmail.com>
References: <1362477800.16460.69.camel@x61.thuisdomein>
         <CAOiHx=nzNVatEp0nyfZKU2p35+1kjrw6VsvZTP+QPJykWF3JAg@mail.gmail.com>
         <1362486020.16460.73.camel@x61.thuisdomein>
         <CAOiHx=nvH-Q+3HCkukM9ZDZXLm=w0bO9LPyosQS7UHOmOvQYOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2013 13:06:35.0217 (UTC) FILETIME=[43BCDC10:01CE19A2]
X-RcptDomain: linux-mips.org
X-archive-position: 35854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Tue, 2013-03-05 at 13:55 +0100, Jonas Gorski wrote:
> On 5 March 2013 13:20, Paul Bolle <pebolle@tiscali.nl> wrote:
> > diff --git a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> > index d9c8284..b40f37f 100644
> > --- a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> > +++ b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> > @@ -28,11 +28,7 @@
> >  /* #define cpu_has_prefetch    ? */
> >  #define cpu_has_mcheck         1
> >  /* #define cpu_has_ejtag       ? */
> > -#ifdef CONFIG_CPU_HAS_LLSC
> > -#define cpu_has_llsc           1
> > -#else
> >  #define cpu_has_llsc           0
> > -#endif
> 
> Hm, shouldn't you leave cpu_has_llsc set to 1? At least the "old" path
> SEAD3 => CPU_MIPS32_R1/R2/64_R1 => select CPU_HAS_LLSC for all three
> would have always caused this to be 1.

That would mean an actual change to the code. See, there's no Kconfig
symbol CPU_HAS_LLSC since v2.6.32. This means that CONFIG_CPU_HAS_LLSC
has not been defined ever since and that SEAD3 has been having
cpu_has_llsc set to 0 for some time now. My patch just removes dead
code.

Perhaps SEAD3 need cpu_has_llsc set to 1. I wouldn't know. Anyhow, that
should be done in another patch, with (runtime) testing, etc.


Paul Bolle
