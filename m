Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 02:35:32 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:27410
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225461AbTJ2CfA>; Wed, 29 Oct 2003 02:35:00 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 29 Oct 2003 02:35:19 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h9T2Z99X042280;
	Wed, 29 Oct 2003 11:35:09 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 29 Oct 2003 11:37:46 +0900 (JST)
Message-Id: <20031029.113746.108765170.nemoto@toshiba-tops.co.jp>
To: ddaney@avtrex.com
Cc: linux-mips@linux-mips.org
Subject: Re: Help needed WRT GDB and multithreaded programs.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <3F9EFFDF.7070205@avtrex.com>
References: <3F9EFFDF.7070205@avtrex.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 28 Oct 2003 15:46:39 -0800, David Daney <ddaney@avtrex.com> said:
ddaney> When using GDB 5.3 I get strange errors and am basically not
ddaney> able to debug multi-threaded programs.  For example any java
ddaney> program compiled with GCC/GCJ runs in multiple threads and
ddaney> does something like this:

Maybe these will help you:

http://www.linux-mips.org/archives/linux-mips/2002-09/msg00127.html
http://lists.debian.org/debian-mips/2003/debian-mips-200303/msg00116.html

---
Atsushi Nemoto
