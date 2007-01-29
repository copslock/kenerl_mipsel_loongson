Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 16:16:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:55014 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038625AbXA2QQL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 16:16:11 +0000
Received: from localhost (p7074-ipad29funabasi.chiba.ocn.ne.jp [221.184.74.74])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C5876BEB5; Tue, 30 Jan 2007 01:14:46 +0900 (JST)
Date:	Tue, 30 Jan 2007 01:14:42 +0900 (JST)
Message-Id: <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	vagabon.xyz@gmail.com, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
References: <20070128180807.GA18890@nevyn.them.org>
	<cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
	<Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jan 2007 15:46:20 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Well, the option used to select between 64-bit and 32-bit ELF for 
> building 64-bit configurations.  I can see it has been changed from its 
> original meaning and it now only controls whether "-mno-explicit-relocs" 
> is passed to the compiler or not, which is sort of useless and certainly 
> does not match the intent nor what the description says.  The 64-bit 
> format is now used unconditionally and you can always pass such obscure 
> options to the compiler on the make's command line, so instead of this fix 
> I vote for complete removal of the BUILD_ELF64 option.

Though I do not know much about -mno-explicit-relocs,
CONFIG_BUILD_ELF64 controls -msym32 option and this is the reason of
the tweak in __pa_page_offset().

I thought -msym32 can not be used for 64-bit kernels which do not have
CKSEG load address, but apparently IP27 is using -msym32 with XKPHYS
load address.  Hmm...

---
Atsushi Nemoto
