Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 08:32:31 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:10270
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225397AbVFVHcN>; Wed, 22 Jun 2005 08:32:13 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Jun 2005 07:31:06 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 794291F655;
	Wed, 22 Jun 2005 16:31:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 65FCF1F5F1;
	Wed, 22 Jun 2005 16:31:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j5M7V1oj073300;
	Wed, 22 Jun 2005 16:31:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 22 Jun 2005 16:31:01 +0900 (JST)
Message-Id: <20050622.163101.103777455.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: .set mips2 breaks 64bit kernel (Re: CVS Update@linux-mips.org:
 linux)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050614173512Z8225617-1340+8840@linux-mips.org>
References: <20050614173512Z8225617-1340+8840@linux-mips.org>
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
X-archive-position: 8130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 14 Jun 2005 18:35:06 +0100, macro@linux-mips.org said:
macro> Modified files:
macro> 	arch/mips/kernel: semaphore.c 
macro> 	include/asm-mips: atomic.h bitops.h system.h 

macro> Log message:
macro> 	Enable a suitable ISA for the assembler around ll/sc so that code
macro> 	builds even for processors that don't support the instructions.
macro> 	Plus minor formatting fixes.

Please do not set mips2 unconditionaly.  It breaks 64bit kernel.

---
Atsushi Nemoto
