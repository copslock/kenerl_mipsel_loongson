Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2006 04:19:41 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47692 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027649AbWJTDTj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Oct 2006 04:19:39 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 20 Oct 2006 12:19:38 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 08959206F2;
	Fri, 20 Oct 2006 12:19:36 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E80D8204B6;
	Fri, 20 Oct 2006 12:19:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9K3JYW0073496;
	Fri, 20 Oct 2006 12:19:34 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 20 Oct 2006 12:19:34 +0900 (JST)
Message-Id: <20061020.121934.126141543.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] Get ride of CPHYSADDR() in setup.c [take #4]
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 13041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 13:19:58 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Changes since take #3
> --------------------
>   * Sign extension hack still needed by rd_start_early() (Atsushi)
>   * Replace panic() by printk() in init_initrd() (Atsushi)
>   * Fix CONFIG_64BITS typo (Atsushi)
>   * Add a new sanity check in init_initrd():
> 		initrd_start < PAGE_OFFSET

Works fine for me.  Thanks.

---
Atsushi Nemoto
