Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 15:47:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:44299 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022549AbXGLOrg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 15:47:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1892DE1C9F
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 16:47:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muZhsWxqHLUN for <linux-mips@linux-mips.org>;
	Thu, 12 Jul 2007 16:47:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C0F77E1C8D
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 16:47:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6CEl8FN003914
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 16:47:08 +0200
Date:	Thu, 12 Jul 2007 15:47:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Workaround for a sparse warning in include/asm-mips/io.h
In-Reply-To: <S20022480AbXGLO2a/20070712142830Z+14663@ftp.linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707121541190.3029@blysk.ds.pg.gda.pl>
References: <S20022480AbXGLO2a/20070712142830Z+14663@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3643/Thu Jul 12 15:25:30 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 Jul 2007, linux-mips@linux-mips.org wrote:

> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Wed Jul 11 23:12:00 2007 +0900
> Comitter: Ralf Baechle <ralf@linux-mips.org> Thu Jul 12 14:39:44 2007 +0100
> Commit: 57be612bf3815728ad29f39a09a1c70d71bd279c
> Gitweb: http://www.linux-mips.org/g/linux/57be612b
> Branch: master
> 
> CKSEG1ADDR() returns unsigned int value on 32bit kernel.  Cast it to

 This is not true.  With a 32-bit kernel CKSEG1ADDR(), quite 
intentionally, returns a *signed* int.

 Since you have decided to fix the symptom rather than the bug I would at 
least suggest to cast the result to "long" first and only then drop the 
signedness.  Otherwise it looks misleading to a casual reader.

  Maciej
