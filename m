Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 01:52:40 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:48132
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225286AbVANBwe>; Fri, 14 Jan 2005 01:52:34 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Jan 2005 01:52:32 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 0434E239E1D; Fri, 14 Jan 2005 10:52:29 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0E1qSRm040715;
	Fri, 14 Jan 2005 10:52:28 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 14 Jan 2005 10:52:27 +0900 (JST)
Message-Id: <20050114.105227.25909305.nemoto@toshiba-tops.co.jp>
To: rsandifo@redhat.com
Cc: macro@mips.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <87k6qh2e6j.fsf@redhat.com>
References: <874qhltcyv.fsf@redhat.com>
	<Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
	<87k6qh2e6j.fsf@redhat.com>
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
X-archive-position: 6908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 13 Jan 2005 21:48:36 +0000, Richard Sandiford <rsandifo@redhat.com> said:
rsandifo> You can't dereference it, obviously, just like you can't
rsandifo> deference a normal "void *".  But you can assign it to any
rsandifo> "volatile T *" without an explicit cast.  I assumed that's
rsandifo> what was happening in this case?

Assigning "void *" to "volatile T *" is not a problem.  Compiler warns
if you assigned "volatile T *" to "void *".

The warnings I mentioned before are:

/usr/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.h: In function `ahc_inb':
/usr/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.h:589: warning: passing arg 1 of `readb' discards qualifiers from pointer target type

---
Atsushi Nemoto
