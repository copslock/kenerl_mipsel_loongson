Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2008 01:56:39 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:21551 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28575826AbYEUA4h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 May 2008 01:56:37 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Wed, 21 May 2008 09:56:33 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 591411CF02;
	Wed, 21 May 2008 09:56:25 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4C9A418778;
	Wed, 21 May 2008 09:56:25 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m4L0uNAF043856;
	Wed, 21 May 2008 09:56:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 21 May 2008 09:56:24 +0900 (JST)
Message-Id: <20080521.095624.25479790.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	a.zummo@towertech.it, hvr@gnu.org, akpm@linux-foundation.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: M41T80: Century Bit support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0805202045320.31790@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805171959030.10067@cliff.in.clinika.pl>
	<20080519.011034.25909336.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.55.0805202045320.31790@cliff.in.clinika.pl>
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
X-archive-position: 19330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 20 May 2008 20:51:56 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Well, Andrew has applied this patch to the -mm tree now and after a bit
> of thinking I have made up my mind and decided we should keep the patch.  
> This is an I2C device which means it will always only be explicitly
> requested by platform code.  This is an opportunity for the platform to
> express the will and the way to use the century bit.
> 
>  I'll cook-up a follow-on patch as soon as the SWARM bits propagate to
> upstream, to add a set of flags that will let platforms specify the
> desired way the century bit is meant to be handled and which this driver
> will honour.  Please feel free to keep the interpretation within your pet
> board intact -- the flags will be capable to express your needs.

OK, it would be the best way to handle the century bit.
I'll test your patch (if my board is still alive at the time ;-))

---
Atsushi Nemoto
