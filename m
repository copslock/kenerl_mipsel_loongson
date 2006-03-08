Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2006 04:50:27 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:32060 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8127208AbWCHEuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Mar 2006 04:50:17 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 8 Mar 2006 13:58:44 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 34F5520141;
	Wed,  8 Mar 2006 13:58:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1FB8D20057;
	Wed,  8 Mar 2006 13:58:42 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k284we4D086741;
	Wed, 8 Mar 2006 13:58:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 08 Mar 2006 13:58:40 +0900 (JST)
Message-Id: <20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	akpm@osdl.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060307180907.GA13577@linux-mips.org>
References: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20060307180907.GA13577@linux-mips.org>
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
X-archive-position: 10749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 7 Mar 2006 18:09:07 +0000, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Below's fix results in exactly the same code size on all
ralf> compilers and configurations I've tested it.

ralf> I also have another more elegant fix which as a side effect
ralf> makes get_unaligned work for arbitrary data types but it that
ralf> one results in a slight code bloat:

I tested the patch attached on several MIPS kernel (big/little,
32bit/64bit) with gcc 3.4.5.  In most (but not all) case, Ralf's fix
resulted better than the previous fix.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
