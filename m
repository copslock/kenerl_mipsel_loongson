Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2004 15:09:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:4809 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224937AbUITOJV>; Mon, 20 Sep 2004 15:09:21 +0100
Received: from localhost (p7184-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 49B1D8672; Mon, 20 Sep 2004 23:09:18 +0900 (JST)
Date: Mon, 20 Sep 2004 23:18:56 +0900 (JST)
Message-Id: <20040920.231856.41626966.anemo@mba.ocn.ne.jp>
To: rsandifo@redhat.com
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <87y8j5fh8v.fsf@redhat.com>
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
	<87656yqsmz.fsf@redhat.com>
	<87y8j5fh8v.fsf@redhat.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 20 Sep 2004 09:59:28 +0100, Richard Sandiford <rsandifo@redhat.com> said:

rsandifo> FYI, this is now being tracked as gcc bugzilla PR 17565:
rsandifo> http://gcc.gnu.org/PR17565

rsandifo> The fix has so far been applied to 4.0.

Thank you.  I tried the fix on gcc 3.3.4 and it works fine.

---
Atsushi Nemoto
