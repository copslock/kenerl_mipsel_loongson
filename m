Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 02:35:40 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:40884 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133760AbWGNBfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 02:35:32 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 14 Jul 2006 10:35:28 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CEA3C20301;
	Fri, 14 Jul 2006 10:35:22 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C26851FF81;
	Fri, 14 Jul 2006 10:35:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k6E1ZLW0035361;
	Fri, 14 Jul 2006 10:35:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 14 Jul 2006 10:35:21 +0900 (JST)
Message-Id: <20060714.103521.25910483.nemoto@toshiba-tops.co.jp>
To:	giometti@linux.it
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems after merge to 2.6.18-rc1
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060713163200.GA7186@gundam.enneenne.com>
References: <20060713163200.GA7186@gundam.enneenne.com>
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
X-archive-position: 11997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Jul 2006 18:32:00 +0200, Rodolfo Giometti <giometti@linux.it> wrote:
> I just finished a (big) merge with linux-mips 2.6.18-rc1 and
> my tree and at boot I get:
> 
>    Linux version 2.6.18-rc1-g2636fd13-dirty (giometti@gundam) (gcc version 3.4.3) #165 Thu Jul 13 18:13:26 CEST 2006
>    CPU revision is: 02030204
>    Board WWPC1000 version 1.0
>    WWPC-setup: uC=off 
>    (PRId 02030204) @ 396MHZ
>    BCLK switching enabled!
>    Determined physical RAM map:
>     memory: 04000000 @ 00000000 (usable)
>    Early serial console at AU 0x11100000 (options '115200')
>    Determined physical RAM map:
>     memory: 04000000 @ 00000000 (usable)
>    Built 1 zonelists.  Total pages: 16384

Two "Determined physycal RAM map:" line here.  If both were printed in
parse_cmdline_early() (i.e. parse_cmdline_early was called twice),
something is seriously broken.

---
Atsushi Nemoto
