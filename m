Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 08:20:53 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:53026
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225348AbTISHUv>; Fri, 19 Sep 2003 08:20:51 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 19 Sep 2003 07:20:49 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8J7KZgc079191;
	Fri, 19 Sep 2003 16:20:36 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Fri, 19 Sep 2003 16:23:01 +0900 (JST)
Message-Id: <20030919.162301.48536245.nemoto@toshiba-tops.co.jp>
To: dan@debian.org
Cc: echristo@redhat.com, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030919032801.GA11998@nevyn.them.org>
References: <1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com>
	<20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
	<20030919032801.GA11998@nevyn.them.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 18 Sep 2003 23:28:01 -0400, Daniel Jacobowitz <dan@debian.org> said:
dan> I was able to build using -mabi=64 -Wa,-mabi=o64.  There
dan> are... some issues... but I think that's just this board port.

The "-Wa,-mabi=o64" works good for me.  Without this option, I had to
use ld.script.elf64 and convert vmlinux to elf32-tradlittlemips using
objcopy if I wanted to use newer binutils.  Thanks!!

---
Atsushi Nemoto
