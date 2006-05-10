Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 09:56:29 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28404 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133407AbWEJH4V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 May 2006 09:56:21 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 10 May 2006 16:56:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 873932035A;
	Wed, 10 May 2006 16:56:17 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7C84F2034F;
	Wed, 10 May 2006 16:56:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4A7uH4D099994;
	Wed, 10 May 2006 16:56:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 10 May 2006 16:56:16 +0900 (JST)
Message-Id: <20060510.165616.108981664.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060510071937.GA7813@networkno.de>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
	<20060510071937.GA7813@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 10 May 2006 08:19:37 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> There was something MIPS specific for n64 (DWARF64) uuntil very
> recently. GCC HEAD switched n64 Linux to DWARF32 some days ago.

The MIPS specifis issue for n64 is covered by current vmlinux.lds.S ?
If no, the patch would have no bad side-effects.

Also, I suppose we can use STABS_DEBUG too, but not sure.  Current
MIPS vmlinux.lds.S have this line:

  .comment : { *(.comment) }

and it seems conflicts with a .comment line in STABS_DEBUG.  Can we
use generic STABS_DEBUG and drop the .comment line in mips
vmlinux.lds.S ?

---
Atsushi Nemoto
