Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 08:08:07 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50579 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20042258AbXAXIID (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 08:08:03 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 24 Jan 2007 17:08:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 916802095A;
	Wed, 24 Jan 2007 17:07:38 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 85DD8206AB;
	Wed, 24 Jan 2007 17:07:38 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l0O87aW0099337;
	Wed, 24 Jan 2007 17:07:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 24 Jan 2007 17:07:36 +0900 (JST)
Message-Id: <20070124.170736.63741899.nemoto@toshiba-tops.co.jp>
To:	akpm@osdl.org
Cc:	sshtylyov@ru.mvista.com, Eric.Piel@lifl.fr, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070123235029.d49eda3d.akpm@osdl.org>
References: <20070123.103027.126140726.nemoto@toshiba-tops.co.jp>
	<20070123234507.08f63b5e.akpm@osdl.org>
	<20070123235029.d49eda3d.akpm@osdl.org>
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
X-archive-position: 13784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Jan 2007 23:50:29 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > setup-bus.o is linked only on x86
> 
> oops, that's untrue.  But it will break ppc32, I think.

Oh sorry for confusion, I had updated wrong version of the patch when
applying comments from Eric and Sergei.

Final shape in mm tree looks fine.  Thank you.

---
Atsushi Nemoto
