Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2002 09:02:14 +0100 (CET)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:64004 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S1123999AbSKFICN>; Wed, 6 Nov 2002 09:02:13 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; 6 Nov 2002 08:02:11 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A84EFB46B; Wed,  6 Nov 2002 17:02:00 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA82673; Wed, 6 Nov 2002 17:02:00 +0900 (JST)
Date: Wed, 06 Nov 2002 17:05:02 +0900 (JST)
Message-Id: <20021106.170502.28781127.nemoto@toshiba-tops.co.jp>
To: roger_twede@hp.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: NFS Root failure in 2.4.18 - Traced to 256k COLOUR_ALIGN
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <CBD6266EA291D5118144009027AA63350A68F189@xboi05.boi.hp.com>
References: <CBD6266EA291D5118144009027AA63350A68F189@xboi05.boi.hp.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 1 Nov 2002 13:28:32 -0800 , "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com> said:
roger> I traced the NFS root boot failure to a change made in the the
roger> function arch_get_unmapped_area(...).  The system goes from
roger> functional to non-functional with a single function change made
roger> in 2.4.18.  linux/arch/mips/kernel/syscall.c ::
roger> arch_get_unmapped_area(...), COLOUR_ALIGN

Just for your information, I also met this problem when I switched
back to old redhat-6.0 userland.  More recent userlands (RedHat 7.0,
7.1, Debian) seems free from this trouble.

---
Atsushi Nemoto
