Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2016 09:56:24 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:55188 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008482AbcCYI4VbXFf4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Mar 2016 09:56:21 +0100
Received: by ozlabs.org (Postfix, from userid 1034)
        id 3qWc3w0GCtz9sdm; Fri, 25 Mar 2016 19:32:11 +1100 (AEDT)
In-Reply-To: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org
From:   Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mips@linux-mips.org, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>,  Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,  David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,  sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jiri Slaby <jslaby@suse.cz>, Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>,  Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>,  Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com,  Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>
 , Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,  Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,  Haavard Skinnemoen <hskinnemoen@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>,  user-mode-linux-devel@lists.sourceforge.net, Steven Miao <realmz6@gmail.com>,  Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,  linux-alpha@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, Mikael Starvik <starvik@axis.com>, linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, user-mode-linux-user@lists.sourceforge.net, nios2-dev@lists.rocketboards.org,  Thomas Gleixner <tglx@linutronix.de>, linux-xtensa@linux-xtensa.org,  linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,  Michal Simek <monstr@mon
 str.eu>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ley Foon Tan <lftan@altera.com>,  Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [3/4] exit_thread: accept a task parameter to be exited
Message-Id: <3qWc3w0GCtz9sdm@ozlabs.org>
Date:   Fri, 25 Mar 2016 19:32:11 +1100 (AEDT)
Return-Path: <michael@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Thu, 2016-24-03 at 12:58:13 UTC, Jiri Slaby wrote:
> We need to call exit_thread from copy_process in a fail path.  So make
> it accept task_struct as a parameter.

If I'm counting right 22 of those are empty functions, so would it be a good
clean up to make it optional first?

cheers
