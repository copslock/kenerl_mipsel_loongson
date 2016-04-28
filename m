Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 19:23:01 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40610 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027724AbcD1RXANyQP8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 19:23:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8CAA38EE189;
        Thu, 28 Apr 2016 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1461864172;
        bh=7tg3hUplyW2aFDHd42FHTlOSvw7WXL2VR2x463jD/m4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lQj4fQ5ANbJ9/m1b6+w4kgXPry4Kx8ERRFKUmdjkNE2nH+J+pIHr1XMkTSNt0mAmB
         cc1QUxdtimYx0VTnoq0Mtk5nwwYsIp2Rju3Q0a9X53rH2bZMxPPoyTnJtXWLreFJJD
         ROLjcjT3Ubiq2nn4E8lo9DmkU2ult304f3RxlPZo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hSg5QpX0_wLj; Thu, 28 Apr 2016 10:22:52 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.46.144.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 130088EE0A3;
        Thu, 28 Apr 2016 10:22:51 -0700 (PDT)
Message-ID: <1461864170.2307.19.camel@HansenPartnership.com>
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     zengzhaoxiu@163.com, akpm@linux-foundation.org, linux@horizon.com,
        peterz@infradead.org
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
        linux@lists.openrisc.net, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date:   Thu, 28 Apr 2016 10:22:50 -0700
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
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

On Thu, 2016-04-28 at 19:43 +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Because some architectures (alpha, armv6, etc.) don't provide 
> hardware division, the mod operation is slow! Binary GCD algorithm 
> uses simple arithmetic operations, it replaces division with 
> arithmetic shifts, comparisons, and subtractions.
> 
> I have compiled successfully with x86_64_defconfig and 
> i386_defconfig.

What's the reason for wanting to optimize this and thus have to
maintain (and test) two separate code paths, which is a significant
expense? As far as I can see, gcd() is mosly used in finding optimal
clocks for operations, which is usually done at start of day and not
time critical.

James
