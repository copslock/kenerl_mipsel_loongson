Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2004 22:52:29 +0100 (BST)
Received: from gw-nam4.philips.com ([IPv6:::ffff:161.88.253.58]:25050 "EHLO
	gw-nam4.philips.com") by linux-mips.org with ESMTP
	id <S8225215AbUG2VwZ>; Thu, 29 Jul 2004 22:52:25 +0100
Received: from smtpscan-nam3.philips.com (smtpscan-nam3.mail.philips.com [167.81.103.6])
	by gw-nam4.philips.com (Postfix) with ESMTP
	id CCD419612A; Thu, 29 Jul 2004 21:52:18 +0000 (UTC)
Received: from smtpscan-nam3.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP
	id 9D68A62; Thu, 29 Jul 2004 21:52:18 +0000 (GMT)
Received: from smtprelay-nam2.philips.com (smtprelay-nam2.philips.com [167.81.103.9])
	by smtpscan-nam3.philips.com (Postfix) with ESMTP
	id 6508284; Thu, 29 Jul 2004 21:52:18 +0000 (GMT)
Received: from anrrmh02.diamond.philips.com (anrrmh02-srv.diamond.philips.com [167.81.112.96]) 
	by smtprelay-nam2.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id VAA21415; Thu, 29 Jul 2004 21:52:18 GMT
From: greg.roelofs@philips.com
To: <rsandifo@redhat.com>
Subject: Re: apparent math-emu hang on movf instruction
Cc: <linux-mips@linux-mips.org>
Date: Thu, 29 Jul 2004 14:53:46 -0700
Message-ID: <OF8AA8C2FE.CCAA8F91-ON88256EE0.0078027A@philips.com>
X-MIMETrack: Serialize by Router on anrrmh02/H/SERVER/PHILIPS(Release 6.0.2CF1HF681 | June
 22, 2004) at 29/07/2004 17:50:52,
	Serialize complete at 29/07/2004 17:50:52
MIME-Version: 1.0
Return-Path: <greg.roelofs@philips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.roelofs@philips.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rsandifo@redhat.com> wrote...

>> Does the patch below (against 2.6) fix things?  Only the first hunk
>> is needed to fix the bug, the rest is just there for consistency.

> Oops!  Serves me right for dabbling in new code.  Only the first
> hunk is correct.

Yup, that does it!  Many thanks.  The only thing I had to change for
2.4.x was the name of the "fcr31" soft-struct member; it's "sr" in
older kernels:

> +		if (((ctx->fcr31 & cond) != 0) == ((MIPSInst_RT(ir) & 1) != 0))
		           ^^^^^ sr
> +			xcp->regs[MIPSInst_RD(ir)] = xcp->regs[MIPSInst_RS(ir)];

(Ralf renamed things on 20030720, according to the cvsweb.)

Thanks again,
-- 
Greg Roelofs            `Name an animal that's small and fuzzy.' `Mold.'
Philips Semiconductors   greg.roelofs@philips.com
