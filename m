Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2004 07:34:11 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:49445
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224914AbULXHeF>; Fri, 24 Dec 2004 07:34:05 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Dec 2004 07:34:04 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7674B239E3C; Fri, 24 Dec 2004 16:33:50 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBO7XoMc029105;
	Fri, 24 Dec 2004 16:33:50 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 24 Dec 2004 16:33:48 +0900 (JST)
Message-Id: <20041224.163348.69212321.nemoto@toshiba-tops.co.jp>
To: nunoe@co-nss.co.jp
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: MIPS32 -> MIPS64
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <000601c4e7b8$0f043830$3ca06096@NUNOE>
References: <20041215141613.GB29222@linux-mips.org>
	<20041221.233324.41626824.anemo@mba.ocn.ne.jp>
	<000601c4e7b8$0f043830$3ca06096@NUNOE>
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
X-archive-position: 6752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 22 Dec 2004 08:51:58 +0900, "Hdei Nunoe" <nunoe@co-nss.co.jp> said:
nunoe> Could anyone tell how significant the migration from MIPS32 to
nunoe> MIPS64 is?  Is it just re-building with the MIPS64 toolchain?
nunoe> Or is it like another architecture porting?

Just rebuilding will not be enough, but the migration will not be so
hard.

Most of you have to do is using correct integer data types ('long' is
64bit and 'int' is 32bit in mips64 kernel).

---
Atsushi Nemoto
