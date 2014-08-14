Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 20:05:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53043 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6901562AbaHNSFehjNQJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Aug 2014 20:05:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7EI4qpx021152;
        Thu, 14 Aug 2014 20:04:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7EI4I1H021151;
        Thu, 14 Aug 2014 20:04:18 +0200
Date:   Thu, 14 Aug 2014 20:04:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Chen Gang <gang.chen.5i5j@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com,
        jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org,
        tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org,
        james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>,
        yasutake.koichi@jp.panasonic.com, jonas@southpole.se,
        jejb@parisc-linux.org, deller@gmx.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, mpe@ellerman.id.au,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, cmetcalf@tilera.com,
        jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux@openrisc.net, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Message-ID: <20140814180418.GA20777@linux-mips.org>
References: <53ECE9DD.80004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ECE9DD.80004@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Aug 15, 2014 at 12:54:53AM +0800, Chen Gang wrote:

> Normal architectures:
> 
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
> 
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>                   score, unicore32, x86
> 
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh

Nak for MIPS.  On MIPS Kconfig already always sets one of CPU_BIG_ENDIAN
and CPU_LITTLE_ENDIAN depending on platforms and where both endianess are
supported by a platform, user choice:

config FOO
	bool "foo"
	select SYS_SUPPORTS_LITTLE_ENDIAN

config FOO
	bool "foo"
	select SYS_SUPPORTS_BIG_ENDIAN
	select SYS_SUPPORTS_LITTLE_ENDIAN
[...]
choice
        prompt "Endianess selection"
        help
          Some MIPS machines can be configured for either little or big endian
          byte order. These modes require different kernels and a different
          Linux distribution.  In general there is one preferred byteorder for a
          particular system but some systems are just as commonly used in the
          one or the other endianness.

config CPU_BIG_ENDIAN
        bool "Big endian"
        depends on SYS_SUPPORTS_BIG_ENDIAN

config CPU_LITTLE_ENDIAN
        bool "Little endian"
        depends on SYS_SUPPORTS_LITTLE_ENDIAN
        help

endchoice

So I think you can just drop the MIPS segment from your patch.

  Ralf
