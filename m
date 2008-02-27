Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Feb 2008 14:53:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64998 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28588093AbYB0OxP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Feb 2008 14:53:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1RErBNA020972;
	Wed, 27 Feb 2008 14:53:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1REr8HY020971;
	Wed, 27 Feb 2008 14:53:08 GMT
Date:	Wed, 27 Feb 2008 14:53:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-kernel@vger.kernel.org,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org
Subject: Re: 2.6.25-rc3: "__divdi3" [drivers/crypto/hifn_795x.ko] undefined!
Message-ID: <20080227145308.GC20629@linux-mips.org>
References: <20080226122100.GB22699@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080226122100.GB22699@deprecation.cyrius.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 26, 2008 at 01:21:00PM +0100, Martin Michlmayr wrote:

References to __divdi3 / __udivdi3 are becoming a somewhat regular bug.
I've created a patch to add these to the kernel but I'd rather not push
it unless I have to.  64-bit operations but especially divisions are slow
on 32-bit hardware so undefined references serve as an important detector.

  Ralf
