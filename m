Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2007 15:03:24 +0000 (GMT)
Received: from host93-214-dynamic.20-79-r.retail.telecomitalia.it ([79.20.214.93]:59534
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20032419AbXLGPDP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Dec 2007 15:03:15 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J0ejO-00040T-4o
	for linux-mips@linux-mips.org; Fri, 07 Dec 2007 16:03:11 +0100
Subject: Unhandled kernel unaligned access in do_ade+0x2b8/0x430
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 07 Dec 2007 16:03:37 +0100
Message-Id: <1197039817.5979.5.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Does anyone already happenend to see this problem?

Unhandled kernel unaligned access[#1]
Cpu 0
[...]
Status: 9401fce3     KX SX UK KERNEL EXL IE
Cause : 00000010
BadVA : bfffff000fe8fa2a
PrId  : 00002321
[...]
Process swapper (pid: 0, threadinfo=ffffffff8037c000,
task=ffffffff803802f0)
[...]
Call Trace:
[<ffffffff8000e1f8>] do_ade+0x2b8/0x430
[<ffffffff8000746c>] handle_adel_int+0x34/0x48

Code: 00431024 5440ffae de0201000 <89230000> 99230003 24020000 1440ffe7
00051402 08003854
