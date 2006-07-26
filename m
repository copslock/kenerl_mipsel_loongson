Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 04:13:21 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:14442 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8126537AbWGZDNL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 04:13:11 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 26 Jul 2006 12:13:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E38FF20454;
	Wed, 26 Jul 2006 12:13:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D8B2D202E8;
	Wed, 26 Jul 2006 12:13:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k6Q3D2W0087701;
	Wed, 26 Jul 2006 12:13:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 26 Jul 2006 12:13:02 +0900 (JST)
Message-Id: <20060726.121302.75185183.nemoto@toshiba-tops.co.jp>
To:	creese@caviumnetworks.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: 64bit kernel/N32 userspace - shmctl corrupts userspace memory
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44C6D3D5.9080409@caviumnetworks.com>
References: <44C6B829.8050508@caviumnetworks.com>
	<20060726020427.GA21024@linux-mips.org>
	<44C6D3D5.9080409@caviumnetworks.com>
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
X-archive-position: 12077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 25 Jul 2006 19:30:45 -0700, Chad Reese <creese@caviumnetworks.com> wrote:
> compat.c is only included if CONFIG_SYSVIPC_COMPAT is defined. This
> isn't anywhere in 2.6.16.26. Is this what you're refering to?

You can add this to arch/mips/Kconfig:

config SYSVIPC_COMPAT
	bool
	depends on COMPAT && SYSVIPC
	default y

BTW, it seems many SYSVIPC functions in arch/mips/kernel/linux32.c can
be replaced by this common code.

---
Atsushi Nemoto
