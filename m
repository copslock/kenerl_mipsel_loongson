Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 10:32:18 +0100 (BST)
Received: from smtp011.mail.yahoo.com ([IPv6:::ffff:216.136.173.31]:10507 "HELO
	smtp011.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225220AbTFPJcP>; Mon, 16 Jun 2003 10:32:15 +0100
Received: from unknown (HELO Warrior) (thesistarball@61.149.3.88 with login)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 16 Jun 2003 09:32:10 -0000
Date: Mon, 16 Jun 2003 17:32:40 +0800
From: "He Jin" <thesistarball@yahoo.com.cn>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: bootloader problem
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20030616093215Z8225220-1272+2626@linux-mips.org>
Return-Path: <thesistarball@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thesistarball@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi, everybody,

I met a problem when debuging a bootloader in IT8172G+RM5231A platform, it's like this:

the bootloader had 2 parts, the first part executes in ROM (0xbfc00000-0xbfc0xxxx) and
it move another part from ROM into SDRAM, then jump to the SDRAM entry point to continue.

In the ROM resident code, if I initialized&flushed the cache, it can jump to SDRAM entry
continue normally. However,if I comment out those cache related code and make cache disabled, 
it seems can not jump to SDRAM entry. 

Who can tell me why I must initialize&flush when cache disabled ? 

Thanks a lot!

He Jin	
