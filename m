Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2003 10:57:41 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:27623 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225380AbTLQK5j>;
	Wed, 17 Dec 2003 10:57:39 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA24015;
	Wed, 17 Dec 2003 19:57:31 +0900 (JST)
Received: 4UMDO00 id hBHAvUg09415; Wed, 17 Dec 2003 19:57:31 +0900 (JST)
Received: 4UMRO00 id hBHAvTN08025; Wed, 17 Dec 2003 19:57:29 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Wed, 17 Dec 2003 19:57:29 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
Message-Id: <20031217195729.54fbf4e6.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello,

On Tue, 16 Dec 2003 22:33:41 +0100 (CET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> Hello,
> 
>  Since command line options for both gcc and gas has been changed in an 
> incompatible way recently and also there are stricter requirements on 
> certain options when used simultaneously, I propose the following patch to 
> our top-level Makefiles to let the optimal set of options be selected at 
> the build time.  The intent is to try modern options first, then obsolete 
> ones and to set gas options independently to gcc ones as one may be more 
> inclined to upgrade binutils that his old trusty gcc.
> 
>  The patch implements a make macro called set_gccflags which accepts two
> sets of options consisting of a CPU name and an ISA name each.  Within 
> both sets "-march=" and failing that "-mcpu=" is checked with the CPU name 
> and the ISA name is checked simultaneously.  For gcc if the first set of 
> options fails, the second one is selected even if it would lead to a 
> failure.  For gas both sets are checked and if none succeeds, an empty set 
> is selected.
> 
>  The 32-bit variation accepts a fifth option as well to permit ABI
> selection with an ISA when the "-mabi=" option is unavailable, which is 
> also tested.
> 
>  Beside letting one use modern tools at all the patch also enables CPU
> selection using newly added (and closer matching) settings like
> "-march=mips64" without forcing users to upgrade tools provided a
> conservative fallback is provided.
> 
>  Comments, thoughts, opinions, etc. will be appreciated.

This patch is wonderful for vr4100 series!

I'm using "GNU assembler version 2.14.90.0.6".
The gcc option is set up appropriately.

Thanks,

Yoichi
