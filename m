Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 10:44:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40140 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025933AbcDAIoIUJMr5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 10:44:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u318i6CO021824;
        Fri, 1 Apr 2016 10:44:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u318i4TN021823;
        Fri, 1 Apr 2016 10:44:04 +0200
Date:   Fri, 1 Apr 2016 10:44:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, kernel-hardening@lists.openwall.com,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 11/11] MIPS: KASLR: Print relocation Information on
 boot
Message-ID: <20160401084403.GA28123@linux-mips.org>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
 <1459415142-3412-12-git-send-email-matt.redfearn@imgtec.com>
 <56FD1A32.10204@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56FD1A32.10204@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52823
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

On Thu, Mar 31, 2016 at 03:38:10PM +0300, Sergei Shtylyov wrote:

> >When debugging a relocated kernel, the addresses of the relocated
> >symbols and the offset applied is essential information. If the kernel
> >is compiled with debugging information, then print this information
> >during bootup using the same function as the panic notifer.
> 
>    Notifier.

Fixed when merging.

> >Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> >---
> >
> >Changes in v2: None
> >
> >  arch/mips/kernel/setup.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> >diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >index d8376d7b3345..ae71f8d9b555 100644
> >--- a/arch/mips/kernel/setup.c
> >+++ b/arch/mips/kernel/setup.c
> >@@ -477,9 +477,18 @@ static void __init bootmem_init(void)
> >  	 */
> >  	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
> >  		unsigned long offset;
> >+		extern void show_kernel_relocation(const char *level);
> >
> >  		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
> >  		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> >+
> >+#if (defined CONFIG_DEBUG_KERNEL) && (defined CONFIG_DEBUG_INFO)
> 
>    Not #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)?
> 
> [...]

CPP syntax is not what most people seem to believe that is the parenthesis
around the argument of defined are not required so above line is unusual
but perfectly ok.  However following boring standards is good so I changed
this, too.

  Ralf
