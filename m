Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 02:23:52 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:41962 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133827AbWDZBXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Apr 2006 02:23:44 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 26 Apr 2006 10:36:57 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CDE8C20490;
	Wed, 26 Apr 2006 10:36:52 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id BB61020256;
	Wed, 26 Apr 2006 10:36:52 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3Q1ap4D030513;
	Wed, 26 Apr 2006 10:36:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 26 Apr 2006 10:36:51 +0900 (JST)
Message-Id: <20060426.103651.108306196.nemoto@toshiba-tops.co.jp>
To:	geoffrey.levand@am.sony.com
Cc:	linux-mips@linux-mips.org
Subject: Re: CROSS_COMPILE in environment variable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <444E6B4E.5000608@am.sony.com>
References: <20060425.133944.88701465.nemoto@toshiba-tops.co.jp>
	<444E6B4E.5000608@am.sony.com>
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
X-archive-position: 11202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 25 Apr 2006 11:32:46 -0700, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> I think the Kconfig could be changed to say that CONFIG_CROSSCOMPILE
> makes the build system use a built-in default tool prefix.

Already done by Ralf a few days ago :-)

---
Atsushi Nemoto
