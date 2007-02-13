Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 16:13:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36315 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039266AbXBMQNW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2007 16:13:22 +0000
Received: from localhost (p7211-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.211])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AA60AA3A8; Wed, 14 Feb 2007 01:12:02 +0900 (JST)
Date:	Wed, 14 Feb 2007 01:12:02 +0900 (JST)
Message-Id: <20070214.011202.27778033.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11713582901742-git-send-email-fbuihuu@gmail.com>
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
	<11713582901742-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Feb 2007 10:18:08 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> +  ifeq ("$(BUILD_ELF32)", "y")
> +    cflags-y += -msym32

ifeq ($(BUILD_ELF32),y)

is enough, isn't it?
---
Atsushi Nemoto
