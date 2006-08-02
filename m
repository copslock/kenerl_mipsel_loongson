Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 02:54:19 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:19618 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3465625AbWHBByK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 02:54:10 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 2 Aug 2006 10:54:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6F39520473;
	Wed,  2 Aug 2006 10:54:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5A8DB20468;
	Wed,  2 Aug 2006 10:54:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k721s6W0018775;
	Wed, 2 Aug 2006 10:54:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 02 Aug 2006 10:54:06 +0900 (JST)
Message-Id: <20060802.105406.15248417.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] Fix dump_stack()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80608011043u19621bdev1a2d3e2745adac50@mail.gmail.com>
References: <44CF7506.70106@innova-card.com>
	<20060802.010522.11596989.anemo@mba.ocn.ne.jp>
	<cda58cb80608011043u19621bdev1a2d3e2745adac50@mail.gmail.com>
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
X-archive-position: 12156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 1 Aug 2006 19:43:39 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> BTW what about rename show_trace() into show_raw_backtrace() ?

Looks good for me.
---
Atsushi Nemoto
