Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 02:30:31 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:29333 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3686520AbWGEBaW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Jul 2006 02:30:22 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 5 Jul 2006 10:30:21 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A9673203FB;
	Wed,  5 Jul 2006 10:30:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9C68220310;
	Wed,  5 Jul 2006 10:30:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k651UDW0094787;
	Wed, 5 Jul 2006 10:30:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 05 Jul 2006 10:30:13 +0900 (JST)
Message-Id: <20060705.103013.41196866.nemoto@toshiba-tops.co.jp>
To:	kreese@caviumnetworks.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44AA9F67.3090309@caviumnetworks.com>
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
	<44AA9F67.3090309@caviumnetworks.com>
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
X-archive-position: 11908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 04 Jul 2006 10:03:35 -0700, Chad Reese <kreese@caviumnetworks.com> wrote:
> I believe Ralf committed a cleaned up version of the patch I created 
> 5/23/2006. It called memory_present() after the first bootmap memory was 
> created. I've been using this and dynamic sparsemem on Mips64 for a 
> while now.

It is not enough.  If you want to use SPARSEMEM_EXTREME, do not call
memory_present() _before_ reserve_bootmem().

For SPARSEMEM_EXTREME, memory_present() try to allocate bootmem, but
first area of bootmem must be reserved for bootmap before any
allocation.

The alloc_bootmem_node try to allocate upper (>16MB) page first, then
try lower page.  So if the first memory area was smaller then 16MB
SPARSEMEM_EXTREME would not work.

Also, SPARSEMEM_STATIC will be a bit faster then SPARSEMEM_EXTREME.
The mm/Kconfig warns about mem_section[] size, but static
mem_section[] size is just 1KB for MIPS.  No problem.  :-)

---
Atsushi Nemoto
