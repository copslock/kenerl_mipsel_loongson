Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 21:54:18 +0200 (CEST)
Received: from asavdk4.altibox.net ([109.247.116.15]:38007 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027713AbcD1TyQnESmL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 21:54:16 +0200
Received: from ravnborg.org (unknown [188.228.89.252])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 80A2A801AB;
        Thu, 28 Apr 2016 21:54:07 +0200 (CEST)
Date:   Thu, 28 Apr 2016 21:54:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     George Spelvin <linux@horizon.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        zengzhaoxiu@163.com, dalias@libc.org, davem@davemloft.net,
        deller@gmx.de, geert@linux-m68k.org, ink@jurassic.park.msu.ru,
        james.hogan@imgtec.com, jejb@parisc-linux.org, jonas@southpole.se,
        lennox.wu@gmail.com, lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@arm.linux.org.uk,
        liqin.linux@gmail.com, mattst88@gmail.com, monstr@monstr.eu,
        nios2-dev@lists.rocketboards.org, ralf@linux-mips.org,
        rth@twiddle.net, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp,
        zhaoxiu.zeng@gmail.com
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-ID: <20160428195326.GB29802@ravnborg.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
 <20160428164856.10120.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160428164856.10120.qmail@ns.horizon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=Fo6lhzfq c=1 sm=1 tr=0
        a=Ij76tQDYWdb01v2+RnYW5w==:117 a=Ij76tQDYWdb01v2+RnYW5w==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=qc9dTJifL27puRRyOeAA:9 a=CjuIK1q_8ugA:10
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

> __ffs on the available architectures:
> 	Alpha: sometimes (CONFIG_ALPHA_EV6, CONFIG_ALPHA_EV67)
> 	ARC: sometimes (!CONFIG_ISA_ARCOMPACT)
> 	ARM: sometimes (V5+)
> 	ARM64: NO, could be written using RBIT and CLZ
> 	AVR: yes
> 	Blackfin: NO, could be written using hweight()
> 	C6x: yes
> 	CRIS: NO
> 	FR-V: yes
> 	H8300: NO
> 	Hexagon: yes
> 	IA64: yes
> 	M32R: NO
> 	M68k: sometimes
> 	MetaG: NO
> 	Microblaze: NO
> 	MIPS: sometimes
> 	MN10300: yes
> 	OpenRISC: NO
> 	PA-RISC: NO?  Interesting code, but I think it's a net loss.
> 	PowerPC: yes
> 	S390: sometimes (CONFIG_HAVE_MARCH_Z9_109_FEATURES)
> 	Score: NO
> 	SH: NO
> 	SPARC: NO
SPARC: sparc64: YES, sparc32: NO
Patch needs to be updated to refelct this.

	Sam
