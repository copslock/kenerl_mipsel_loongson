Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 16:29:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:19692 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576013AbXJaQ33 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2007 16:29:29 +0000
Received: from localhost (p7013-ipad26funabasi.chiba.ocn.ne.jp [220.104.93.13])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D49FE8D5D; Thu,  1 Nov 2007 01:29:24 +0900 (JST)
Date:	Thu, 01 Nov 2007 01:31:24 +0900 (JST)
Message-Id: <20071101.013124.108121433.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071031161333.GA22871@linux-mips.org>
References: <20071101.004906.106263529.anemo@mba.ocn.ne.jp>
	<20071031161333.GA22871@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 31 Oct 2007 16:13:33 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> This one is definately playing with the fire.  Or alternatively requires
> detailed knowledge of the pipeline and pipelines tend to change.  MIPS
> Technologies does regular maintenance releases of its cores which also
> add features and may change the pipelines in subtle way that may break
> something like this.

Yes, I never think this is robust or guaranteed...

> The only safe but ugly workaround is to change the return from exception
> code to detect if the EPC is in the range startin from the condition
> check in the idle loop to including the WAIT instruction and if so to
> patch the EPC to resume execution at the condition check or the
> instruction following the WAIT.

I'm also thinking of this approach.  Still wondering if it is worth to
implement.

---
Atsushi Nemoto
