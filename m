Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 15:37:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:45527 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21720110AbYJQOhG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2008 15:37:06 +0100
Received: from localhost (p4148-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.148])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D19B9AC0A; Fri, 17 Oct 2008 23:37:01 +0900 (JST)
Date:	Fri, 17 Oct 2008 23:37:11 +0900 (JST)
Message-Id: <20081017.233711.08319236.anemo@mba.ocn.ne.jp>
To:	zhaolei@cn.fujitsu.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix debugfs_create_*'s error checking method for
 mips/kernel/
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48F87323.6020303@cn.fujitsu.com>
References: <48F87323.6020303@cn.fujitsu.com>
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
X-archive-position: 20784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 17 Oct 2008 19:12:35 +0800, Zhaolei <zhaolei@cn.fujitsu.com> wrote:
> debugfs_create_*() returns NULL if an error occurs, returns -ENODEV
> when debugfs is not enabled in the kernel.
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>

Oh that was my fault.  Thank you for fixing it.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
