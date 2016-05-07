Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2016 12:46:41 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:54094 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026277AbcEGKqiboeL5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2016 12:46:38 +0200
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3r250l4KW1z3hkJ4;
        Sat,  7 May 2016 12:46:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3r250k4Ttdzvh2h;
        Sat,  7 May 2016 12:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id EYV3jDpO_ILq; Sat,  7 May 2016 12:46:11 +0200 (CEST)
X-Auth-Info: sKaBdMi3SXbRupqNFUGK+Q0LeN63VwsoGE8ynF/ju/Lrygsv+uA2plUzOQmPvymv
Received: from igel.home (ppp-88-217-9-210.dynamic.mnet-online.de [88.217.9.210])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Sat,  7 May 2016 12:46:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 457372C59A0; Sat,  7 May 2016 12:46:11 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "George Spelvin" <linux@horizon.com>
Cc:     akpm@linux-foundation.org, dalias@libc.org, davem@davemloft.net,
        geert@linux-m68k.org, James.Bottomley@HansenPartnership.com,
        jjuran@gmail.com, peterz@infradead.org, sam@ravnborg.org,
        zengzhaoxiu@163.com, deller@gmx.de, heiko.carstens@de.ibm.com,
        ink@jurassic.park.msu.ru, james.hogan@imgtec.com,
        jejb@parisc-linux.org, jonas@southpole.se, lennox.wu@gmail.com,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux@arm.linux.org.uk,
        linux@lists.openrisc.net, liqin.linux@gmail.com,
        mattst88@gmail.com, monstr@monstr.eu,
        nios2-dev@lists.rocketboards.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        vgupta@synopsys.com, ysato@users.sourceforge.jp,
        zhaoxiu.zeng@gmail.com
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
References: <20160507084129.7284.qmail@ns.horizon.com>
X-Yow:  PUMP UP th' VOLUME!  My BAGEL TOASTER is in tune with th' UNIVERSAL LIFE
 FORCE!!
Date:   Sat, 07 May 2016 12:46:11 +0200
In-Reply-To: <20160507084129.7284.qmail@ns.horizon.com> (George Spelvin's
        message of "7 May 2016 04:41:29 -0400")
Message-ID: <87d1oyrvrg.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
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

"George Spelvin" <linux@horizon.com> writes:

> Your benchmark code doesn't have to have a separate code path if
> __x86_64__; rdtsc works on 32-bit code just as well.

Take a look at the CC: list.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
