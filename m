Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 19:10:51 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:58710 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1493286AbZIXRKo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Sep 2009 19:10:44 +0200
Received: from localhost (p5080-ipad304funabasi.chiba.ocn.ne.jp [123.217.159.80])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 457F96D6A; Fri, 25 Sep 2009 02:10:36 +0900 (JST)
Date:	Fri, 25 Sep 2009 02:10:39 +0900 (JST)
Message-Id: <20090925.021039.179960776.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	linux-mips@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	ralf@linux-mips.org
Subject: Re: [PATCH 2/2] spi_txx9: Fix bit rate calculation
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090904163227.GB6699@linux-mips.org>
References: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp>
	<20090904163227.GB6699@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 4 Sep 2009 17:32:27 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> Atsushi's patches should probably be merged together.  I can take care of
> that if the SPI bit is acked by a maintainer.

David, could you give us Ack ?

[PATCH 1/2] txx9: Fix spi-baseclk value
[PATCH 2/2] spi_txx9: Fix bit rate calculation

---
Atsushi Nemoto
