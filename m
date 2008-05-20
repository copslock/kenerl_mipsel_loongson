Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 02:26:12 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:57586 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20026888AbYETB0K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 May 2008 02:26:10 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Tue, 20 May 2008 10:26:07 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BDA9341E1D;
	Tue, 20 May 2008 10:26:01 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B06E81EF4E;
	Tue, 20 May 2008 10:26:01 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m4K1PxAF038628;
	Tue, 20 May 2008 10:26:00 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 20 May 2008 10:25:59 +0900 (JST)
Message-Id: <20080520.102559.25909127.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	a.zummo@towertech.it, khali@linux-fr.org,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/6 #3] RTC: SMBus support for the M41T80, etc. driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0805180447210.10067@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805180447210.10067@cliff.in.clinika.pl>
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
X-archive-position: 19314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 18 May 2008 04:53:54 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  The BCM1250A SOC which is used on the SWARM board utilising an M41T81
> chip only supports pure I2C in the raw bit-banged mode.  Nobody sane
> really wants to use it unless absolutely necessary and the M41T80, etc.  
> chips work just fine with an SMBus adapter which is what the standard mode
> of operation of the BCM1250A.  The only drawback of byte accesses with the
> M41T80 is the chip only latches clock data registers for the duration of
> an I2C transaction which works fine with a block transfers, but not
> byte-wise accesses.
> 
>  The driver currently requires an I2C adapter providing both SMBus and raw
> I2C access.  This is a set of changes to make it work with any SMBus
> adapter providing at least read byte and write byte protocols.  
> Additionally, if a given SMBus adapter supports I2C block read and/or
> write protocols (a common extension beyond the SMBus spec), they are used
> as well.  The problem of unlatched clock data if SMBus byte transactions
> are used is resolved in the standard way.  For raw I2C controllers this
> functionality is provided by the I2C core as SMBus emulation in a
> transparent way.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Tested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
