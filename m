Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 05:18:58 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:23327
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225316AbTKDFS0>; Tue, 4 Nov 2003 05:18:26 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Nov 2003 05:18:47 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hA45IS9X058079;
	Tue, 4 Nov 2003 14:18:28 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 04 Nov 2003 14:21:11 +0900 (JST)
Message-Id: <20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
To: echristo@redhat.com
Cc: ica2_ts@csv.ica.uni-stuttgart.de, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
References: <20031029181516.GA14443@nevyn.them.org>
	<20031030015353.GE1486@rembrandt.csv.ica.uni-stuttgart.de>
	<1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
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
X-archive-position: 3575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 29 Oct 2003 18:25:04 -0800, Eric Christopher <echristo@redhat.com> said:
>> When building python-qt3 on debian unstable I get an oversize GOT
>> and:
>> 
>> /usr/bin/ld: BFD 2.14.90.0.6 20030820 Debian GNU/Linux assertion
>> fail ../../bfd/elfxx-mips.c:2287
>> 
>> Seems like multi-GOT is broken for this case.

eric> Judging from the line offset from today's sources to that error
eric> message it might have been fixed with rsandifo's last patch that
eric> fixed an uninitialized variable problem. (global_gotno)

I tried binutils-2.14.90.0.7 (based on binutils 2003 1029 in CVS) but
my problem did no solved.  It seems something is still wrong.

---
Atsushi Nemoto
