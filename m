Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 09:48:27 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:17158
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225275AbVAXJsV>; Mon, 24 Jan 2005 09:48:21 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Jan 2005 09:48:20 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 1EE30239E47; Mon, 24 Jan 2005 18:48:16 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0O9mFRm087068;
	Mon, 24 Jan 2005 18:48:15 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 24 Jan 2005 18:48:15 +0900 (JST)
Message-Id: <20050124.184815.79301222.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: MIPS32/MIPS64 profiling (Re: CVS Update@linux-mips.org: linux)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050117175805Z8225250-1340+1463@linux-mips.org>
References: <20050117175805Z8225250-1340+1463@linux-mips.org>
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
X-archive-position: 7020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 17 Jan 2005 17:58:00 +0000, ralf@linux-mips.org said:
ralf> Modified files:
ralf> 	arch/mips/oprofile: common.c 

ralf> Log message:
ralf> 	Hooks to support profiling for MIPS32 / MIPS64 processors, for the
ralf> 	moment only for the 24K.

Please add op_model_mipsxx.c to CVS since arch/mips/orofile/Makefile
already use it.

---
Atsushi Nemoto
