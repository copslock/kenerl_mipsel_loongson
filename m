Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 12:43:03 +0000 (GMT)
Received: from mf2.realtek.com.tw ([60.248.182.46]:15625 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133371AbWCFMmx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Mar 2006 12:42:53 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T76ddbf0e6edc803816172c@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Mon, 6 Mar 2006 20:53:46 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006030620510325-303468 ;
          Mon, 6 Mar 2006 20:51:03 +0800 
Message-ID: <002201c6411c$a06dadb0$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: To stick the kernel start address to 0x80100000
Date:	Mon, 6 Mar 2006 20:51:02 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/06 =?Bog5?B?pFWkyCAwODo1MTowMw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/06 =?Bog5?B?pFWkyCAwODo1MTowNQ==?=,
	Serialize complete at 2006/03/06 =?Bog5?B?pFWkyCAwODo1MTowNQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
I tried to stick the kernel start address to 0x80100000 and modified
vmlinux.ld.S like this:
  .text : {
    arch/mips/kernel/head.o(.init.text)
    *(.text)
    SCHED_TEXT
    LOCK_TEXT
    *(.fixup)
    *(.gnu.warning)
  } =0

After some tests, it seems to work well. Is this a good way to stick the
kernel start address to 0x80100000?

Regards,
Colin
