Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 20:22:13 +0100 (BST)
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:29341 "EHLO
	phobos.cabal.ca") by ftp.linux-mips.org with ESMTP
	id S28582063AbYGPTWK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 20:22:10 +0100
Received: by phobos.cabal.ca (Postfix, from userid 500)
	id 8AF16178079; Wed, 16 Jul 2008 15:22:02 -0400 (EDT)
Date:	Wed, 16 Jul 2008 15:22:02 -0400
From:	Kyle McMartin <kyle@mcmartin.ca>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-stable@linux-mips.org,
	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>
Subject: Re: MIPS toolchain
Message-ID: <20080716192202.GA27827@phobos.i.cabal.ca>
References: <487DA40C.6010405@movial.fi> <20080716104533.GA7198@linux-mips.org> <487DD559.3020802@movial.fi> <20080716120224.GA6061@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716120224.GA6061@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <kyle@phobos.cabal.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kyle@mcmartin.ca
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 01:02:24PM +0100, Ralf Baechle wrote:
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -517,8 +519,6 @@ endif
>  # Arch Makefiles may override this setting
>  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls

Cool, this explains something I saw with a crossbuild as well, but never
had time to debug.

r, Kyle
