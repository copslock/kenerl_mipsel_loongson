Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M7AxW22822
	for linux-mips-outgoing; Wed, 22 Aug 2001 00:10:59 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M7Av922819
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 00:10:57 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 22 Aug 2001 07:10:57 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 81AB754C14; Wed, 22 Aug 2001 16:10:55 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id QAA86595; Wed, 22 Aug 2001 16:10:54 +0900 (JST)
Date: Wed, 22 Aug 2001 16:15:29 +0900 (JST)
Message-Id: <20010822.161529.115901259.nemoto@toshiba-tops.co.jp>
To: hartvige@mips.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Magic numbers about stack layout
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <200108220646.IAA13918@copsun17.mips.com>
References: <20010822.144547.30190293.nemoto@toshiba-tops.co.jp>
	<200108220646.IAA13918@copsun17.mips.com>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 22 Aug 2001 08:46:01 +0200 (MET DST), Hartvig Ekner <hartvige@mips.com> said:
hartvige> what is the purpose of replacing the magic numbers with code
hartvige> analysis?

The magic numbers are affected by frame size of some kernel functions
such as schedule(), sleep_on(), etc.  These values may change for
various reason (code modification, new compiler, more optimize, ...).

hartvige> And what will happen when you run userland with MIPS16 or
hartvige> MIPS16e code?

Nothing.  The targets of this analysis are only kernel functions.

---
Atsushi Nemoto
