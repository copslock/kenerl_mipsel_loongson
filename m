Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 16:01:21 +0100 (BST)
Received: from mail.ttnet.net.tr ([212.175.13.129]:7466 "EHLO
	fep07.ttnet.net.tr") by ftp.linux-mips.org with ESMTP
	id S8133454AbWFZPBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Jun 2006 16:01:10 +0100
Received: from dsl.dynamic81214209203.ttnet.net.tr ([81.214.209.203])
          by fep07.ttnet.net.tr with ESMTP
          id <20060626150101.SPPU6194.fep07.ttnet.net.tr@dsl.dynamic81214209203.ttnet.net.tr>
          for <linux-mips@linux-mips.org>; Mon, 26 Jun 2006 18:01:01 +0300
From:	bora.sahin@ttnet.net.tr
To:	linux-mips@linux-mips.org
Subject: Single stepping, BDI2000 and Yamon
Date:	Mon, 26 Jun 2006 18:04:29 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261804.29411.bora.sahin@ttnet.net.tr>
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips


We will get a custom Au1200 based board soon thus I want to speed up on using 
BDI2000, gdb and Yamon. I halt the Db1200 at somewhere in the reset code 
using BDI telnet interface. Then connect to the target. But I cant single 
step reset code because gdb complains
	warning: GDB can't find the start of the function at 0xbfc005a0
	GDB is unable to find the start of the function at 0xbfc005a0
and thus can't determine the size of that function's stack frame.
	...
This continues until a C-like environment is setup, c_entry(). What I want to 
learn is is there a way to single step the reset code? Or I am on my own and 
be careful when writing/chaning code during this phase? What's your usage 
patterns here guys?

Thanks...

--
Bora SAHIN
