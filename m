Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2003 01:32:01 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:53528
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225384AbTILAcA>; Fri, 12 Sep 2003 01:32:00 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Sep 2003 00:31:58 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8C0Vogc060491;
	Fri, 12 Sep 2003 09:31:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 12 Sep 2003 09:34:06 +0900 (JST)
Message-Id: <20030912.093406.78702272.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: mips64 _access_ok fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030911141629.GB15365@linux-mips.org>
References: <20030911.124350.41627177.nemoto@toshiba-tops.co.jp>
	<20030911.134323.03974731.nemoto@toshiba-tops.co.jp>
	<20030911141629.GB15365@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 11 Sep 2003 16:16:29 +0200, Ralf Baechle <ralf@linux-mips.org> said:
>> I know this fix is not complete.  __access_ok(0, 0, __access_mask)
>> will return 0.

ralf> That behaviour of __access_ok() is actually ok;

Then could you apply the patch?  I think the fix is needed for 64bit
native mount syscall (which try to read variable length string
parameters from user stack).
---
Atsushi Nemoto
