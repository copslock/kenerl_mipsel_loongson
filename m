Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56Gkfv05607
	for linux-mips-outgoing; Wed, 6 Jun 2001 09:46:41 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56Gkbh05594
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:46:37 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id UAA28195
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 20:46:46 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id UAA01119 for linux-mips@oss.sgi.com; Wed, 6 Jun 2001 20:37:30 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id QAA05829 for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 16:54:26 +0400 (MSD)
Message-ID: <3B1E2BF7.5C0CADB8@niisi.msk.ru>
Date: Wed, 06 Jun 2001 17:11:19 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Bug in memmove
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

It seems there is a bug in our memmove routine. The condition is rare
though, for example, memmove copies incorrectly, if src=5, dst=4, len=9.
I guess, exact condition is:

len > 8, 0 < src - dst < 8, src isn't aligned on qw (8 bytes), src - dst
!= 4

I may be wrong on exact condition, but at least the example works.

Briefly, memmove calls memcpy if src > dst. Then, when memcpy aligns src
on qw, it copies qw to dst. So, after src is aligned, it is overwritten
as well. In the example, memcpy copies qw at 4 (so, new data ends on
4+8=12), but aligned src is at address 8, so a word at address 8 is
overwritten.

Two questions here. First, do we have a pattern that satisfies the
condition, i.e. is the bug showstopper? My guess, it's not. Second, does
somebody have ideas how to fix the bug? Well, I have, but want to hear
somebody else.

Regards,
Gleb.
