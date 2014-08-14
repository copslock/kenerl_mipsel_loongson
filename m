Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 01:14:18 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.44.111]:48418 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855144AbaHNXOKFyo8O convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Aug 2014 01:14:10 +0200
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C061424E101B;
        Thu, 14 Aug 2014 16:13:57 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id 9174155F13;
        Thu, 14 Aug 2014 16:13:57 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id A857C55F02;
        Thu, 14 Aug 2014 16:13:56 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 59C5BCB2;
        Thu, 14 Aug 2014 16:13:56 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BE98AAD7;
        Thu, 14 Aug 2014 16:13:13 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 14 Aug 2014 16:12:57 -0700
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0158.001; Fri,
 15 Aug 2014 04:42:54 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Chen Gang <gang.chen.5i5j@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "starvik@axis.com" <starvik@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "takata@linux-m32r.org" <takata@linux-m32r.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        Liqin Chen <liqin.linux@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "cmetcalf@tilera.com" <cmetcalf@tilera.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
        "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "user-mode-linux-user@lists.sourceforge.net" 
        <user-mode-linux-user@lists.sourceforge.net>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Thread-Topic: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Thread-Index: AQHPt+CPQyNRLz1f9kGDGhxSg+sSdQ==
Date:   Thu, 14 Aug 2014 23:12:53 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
 <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
 <53ED36AB.8020703@gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.21.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Thursday 14 August 2014 03:22 PM, Chen Gang wrote:
> For many individual modules may need check CPU_LITTLE_ENDIAN or
> CPU_BIG_ENDIAN, which is an architecture's attribute.
>
> Or they have to list many architectures which they support, which they
> don't support. And still, it is not precise.
>
> For architecture API, endian is a main architecture's attribute which
> may be used by outside, so every architecture need let outside know
> about it, explicitly.

I don't think that is correct. The modules need to use standard API e.g. swab
which will take care of proper endian handling anyways. Why would a module do
anything endian specific outside of those APIs.

And again is this churn just theoretical or do you really have a issue at hand ! I
would not accept a change for ARC unless you prove that something is broken (or
atleast potentially broken) !

-Vineet
