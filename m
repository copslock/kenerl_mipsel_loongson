Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:15:36 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:61768 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492939AbZKFQP3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 17:15:29 +0100
Received: from localhost (p7248-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.248])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 77BC86ED1
	for <linux-mips@linux-mips.org>; Sat,  7 Nov 2009 01:15:26 +0900 (JST)
Date:	Sat, 07 Nov 2009 01:10:26 +0900 (JST)
Message-Id: <20091107.011026.152514775.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
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
X-archive-position: 24733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 07 Nov 2009 01:08:39 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")

Excuse me, old COMMAND_LINE_SIZE value was 256, not 512.

---
Atsushi Nemoto
