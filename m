Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 11:00:05 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:23332
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225385AbTKDK7c>; Tue, 4 Nov 2003 10:59:32 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Nov 2003 10:59:52 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hA4Axc9X058857;
	Tue, 4 Nov 2003 19:59:39 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 04 Nov 2003 20:02:22 +0900 (JST)
Message-Id: <20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
To: echristo@redhat.com
Cc: ica2_ts@csv.ica.uni-stuttgart.de, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
References: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
	<20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
	<1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
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
X-archive-position: 3581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 04 Nov 2003 00:05:56 -0800, Eric Christopher <echristo@redhat.com> said:
>> I tried binutils-2.14.90.0.7 (based on binutils 2003 1029 in CVS)
>> but my problem did no solved.  It seems something is still wrong.

eric> This was plain mips-linux? Not mips64-linux?

Yes.  mips-linux and mipsel-linux target (host is i386).  Both target
generate broken binary for my test program.

eric> And where would I find the sources?

I'm using plain binutils 2.14 and gcc 3.3.2 from gnu.org FTP site,
binutils 2.14.90.0.7 from
http://www.kernel.org/pub/linux/devel/binutils/.

---
Atsushi Nemoto
