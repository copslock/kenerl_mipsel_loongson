Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 14:30:17 +0100 (BST)
Received: from mail.sysgo.com ([62.8.134.5]:60684 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20037555AbWIKNaP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 14:30:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id C047FCC1BA
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 15:30:09 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by localhost (AvMailGate-2.0.2-8) id 25047-0B643A2C;
	Mon, 11 Sep 2006 15:30:09 +0200
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 6CEC2CC1B1
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 15:30:09 +0200 (CEST)
Received: by donald.sysgo.com (Postfix, from userid 65534)
	id B7BCC26A412; Mon, 11 Sep 2006 15:30:09 +0200 (CEST)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id B76F126A406
	for <linux-mips@linux-mips.org>; Mon, 11 Sep 2006 15:30:08 +0200 (CEST)
From:	Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To:	linux-mips@linux-mips.org
Date:	Mon, 11 Sep 2006 15:30:13 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
Subject: "Uncompressing Linux at load address"
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609111530.14447.carlos.mitidieri@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 7.1.1.16; VDF: 6.35.1.212; host: mailgate.sysgo.com)
Return-Path: <carlos.mitidieri@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos.mitidieri@sysgo.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to boot a zImage from micromonitor on a csb655 board 
(Au1550 processor).

For that matter, I patched my kernel 2.6.15 with the zImage_2_6_10.patch from 
Popov. 

In the arch/mips/boot/compressed/au1xxx/Makefile, I have set:
	1) RAM_RUN_ADDR=0xa0300000, which is the value got  from the umon's 
APPRAMBASE environment variable.
	2) AVAIL_RAM_START=0x80500000
            AVAIL_RAM_END=0x80900000
     	3) LOADADDR =0x80100000, which is the same value I have set in an 
entry for this board in arch/mips/Makefile.

I can compile and link the zImage with home build gcc cross tools, based on 
gcc-3.4.4 and glibc-2.3.4 . When the (binary) zImage is decompressed on the 
target, I get these messages: 

zImage: size=680372 base=0xa0300000
loaded at:     A0300000 A03A4000
zimage at:     A0306180 A03A3EE1
Uncompressing Linux at load address 80100000

and then the target resets.  
This zImage is very small, so the decompressed image is not going beyond the 
AVAIL_RAM limits. Would you have any guess on what is going on?

I have looked for this information the list through, but anyone seems to have 
had this problem before. Thanks for any comment.

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
Lise-Meitner-Str. 15
D-89081 Ulm
