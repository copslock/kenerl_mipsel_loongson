Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2003 16:54:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:45769 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225492AbTKFQxo>; Thu, 6 Nov 2003 16:53:44 +0000
Received: from localhost (p7175-ipad30funabasi.chiba.ocn.ne.jp [221.184.82.175])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D87D450D9; Fri,  7 Nov 2003 01:53:31 +0900 (JST)
Date: Fri, 07 Nov 2003 01:54:21 +0900 (JST)
Message-Id: <20031107.015421.55515336.anemo@mba.ocn.ne.jp>
To: echristo@redhat.com
Cc: ica2_ts@csv.ica.uni-stuttgart.de, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
References: <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
	<20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
	<1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 04 Nov 2003 09:53:06 -0800, Eric Christopher <echristo@redhat.com> said:

echristo> I'm using mainline gcc, but I meant the python-qt sources
echristo> you were compiling.

The link error of phyton-qt was reported by Thiemo Seufer.  I have not
tried it.

My problem is runtime failure, not link error.  So it may be a
different problem.

---
Atsushi Nemoto
