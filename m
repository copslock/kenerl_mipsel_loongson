Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 15:13:24 +0100 (BST)
Received: from imap.gmx.net ([IPv6:::ffff:213.165.64.20]:29920 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225233AbTFPONW>;
	Mon, 16 Jun 2003 15:13:22 +0100
Received: (qmail 8479 invoked by uid 65534); 16 Jun 2003 14:13:15 -0000
Received: from pD9EE7482.dip.t-dialin.net (EHLO gmx.de) (217.238.116.130)
  by mail.gmx.net (mp021) with SMTP; 16 Jun 2003 16:13:15 +0200
Message-ID: <3EEDCFC1.8030305@gmx.de>
Date: Mon, 16 Jun 2003 16:10:09 +0200
From: Michael Gruetzner <Michael_Gruetzner@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Unable to compile kernel
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Michael_Gruetzner@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael_Gruetzner@gmx.de
Precedence: bulk
X-list: linux-mips

Hello,

I just downloaded kernel 2.3 from ftp-linux-mips.org. When I try to 
compile it with my cross-compiler I get the following error:

{standard input} error: symbol 'open' is already defined as "*COM*"/4

How can I fix this.

Thanks in advance.

Michael
-- 
#ifdef STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT
         2.4.0-test2 /usr/src/linux/drivers/ide/cmd640.c
