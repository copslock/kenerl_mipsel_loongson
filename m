Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 03:13:31 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34524 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022028AbXF0CN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Jun 2007 03:13:26 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 27 Jun 2007 11:13:24 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9052835146;
	Wed, 27 Jun 2007 11:13:20 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7D7C82043A;
	Wed, 27 Jun 2007 11:13:20 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5R2DKAF036646;
	Wed, 27 Jun 2007 11:13:20 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 27 Jun 2007 11:13:19 +0900 (JST)
Message-Id: <20070627.111319.126143104.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] rbtx4938: Add generic GPIO support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070626235632.GB24949@linux-mips.org>
References: <20070624205429.GB5814@linux-mips.org>
	<20070625.233637.79301366.anemo@mba.ocn.ne.jp>
	<20070626235632.GB24949@linux-mips.org>
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
X-archive-position: 15548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jun 2007 01:56:32 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Thanks.  And please queue this too.
> 
> I've folded this one into the "rbtx4938: Add generic GPIO support" patch.

Thanks, that's better.

In general, which do you prefer on updating a patch in linux-queue
tree, incremental patch or replacement patch?

---
Atsushi Nemoto
