Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2008 13:41:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:12506 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S29048031AbYINMlv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2008 13:41:51 +0100
Received: from localhost (p6219-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.219])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 06F48BF40; Sun, 14 Sep 2008 21:41:46 +0900 (JST)
Date:	Sun, 14 Sep 2008 21:41:59 +0900 (JST)
Message-Id: <20080914.214159.128616923.anemo@mba.ocn.ne.jp>
To:	sparse@chrisli.org
Cc:	linux-sparse@vger.kernel.org, linux-mips@linux-mips.org,
	sam@ravnborg.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] sparse: Make pre_buffer dynamically increasable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <70318cbf0809131059w70c47e4dkb324e0f198b22ba@mail.gmail.com>
References: <20080720.002224.108306935.anemo@mba.ocn.ne.jp>
	<20080914.004951.41872502.anemo@mba.ocn.ne.jp>
	<70318cbf0809131059w70c47e4dkb324e0f198b22ba@mail.gmail.com>
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
X-archive-position: 20488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 13 Sep 2008 10:59:45 -0700, "Christopher Li" <sparse@chrisli.org> wrote:
> The better way is just remove the pre_buffer completely. Just tokenize
> the buffer
> and append the result token on the fly.
> 
> Can you try out the patch I attached? It does just that.

Thanks, it works for me.

---
Atsushi Nemoto
