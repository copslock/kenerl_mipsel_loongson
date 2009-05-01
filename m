Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 10:16:52 +0100 (BST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:55489 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20027071AbZEAJQp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 10:16:45 +0100
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 3888FA50039;
	Fri,  1 May 2009 11:16:37 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 91906580D0; Fri,  1 May 2009 11:18:48 +0200 (CEST)
Date:	Fri, 1 May 2009 11:18:48 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Tim Abbott <tabbott@MIT.EDU>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bryan Wu <cooloney@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@uclinux.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Hirokazu Takata <takata@linux-m32r.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jeff Dike <jdike@addtoit.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	Mikael Starvik <starvik@axis.com>,
	Paul Mackerras <paulus@samba.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	user-mode-linux-devel@lists.sourceforge.net,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss sections.
Message-ID: <20090501091848.GB18326@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu> <1241121253-32341-2-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241121253-32341-2-git-send-email-tabbott@mit.edu>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 03:54:08PM -0400, Tim Abbott wrote:
> This patch is preparation for replacing most uses of
> ".bss.page_aligned" and ".data.page_aligned" in the kernel with
> macros, so that the section name can later be changed without having
> to touch a lot of the kernel.
> 
> The long-term goal here is to be able to change the kernel's magic
> section names to those that are compatible with -ffunction-sections
> -fdata-sections.  This requires renaming all magic sections with names
> of the form ".data.foo".
> 
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: David Howells <dhowells@redhat.com>
> ---
>  include/asm-generic/vmlinux.lds.h |    8 ++++++++
>  include/linux/linkage.h           |    9 +++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 89853bc..3d88c87 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -116,6 +116,14 @@
>  	FTRACE_EVENTS()							\
>  	TRACE_SYSCALLS()
>  
> +#define PAGE_ALIGNED_DATA						\
> +	. = ALIGN(PAGE_SIZE);						\
> +	*(.data.page_aligned)
> +
> +#define PAGE_ALIGNED_BSS						\
> +	. = ALIGN(PAGE_SIZE);						\
> +	*(.bss.page_aligned)
> +
>  #define RO_DATA(align)							\
>  	. = ALIGN((align));						\
>  	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index fee9e59..af051fc 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -22,6 +22,15 @@
>  #define __page_aligned_bss	__section(.bss.page_aligned) __aligned(PAGE_SIZE)
>  
>  /*
> + * For assembly routines.
> + *
> + * Note when using these that you must specify the appropriate
> + * alignment directives yourself
> + */
> +#define __PAGE_ALIGNED_DATA	.section ".data.page_aligned", "aw", @progbits
> +#define __PAGE_ALIGNED_BSS	.section ".bss.page_aligned", "aw", @nobits

The above will work on most architectures but fails (silently?) on arm.
arm uses %{progbits,nobits} where all other uses @{nobits,progbits}.

I know we do not use page_aligned in arm assembler code for now,
but if we do then it should work.
It is my understanding that the linker will automatically
assume nobits for section names starting with .bss and likewise
progbits for section names starting with .data - so we can leave them out?


	Sam
