Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2003 20:00:29 +0000 (GMT)
Received: from dsmtp4.dion.ne.jp ([IPv6:::ffff:210.172.64.83]:59315 "EHLO
	dsmtp4.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8225199AbTBPUA3>; Sun, 16 Feb 2003 20:00:29 +0000
Received: from jr0bak.homelinux.net (M028044.ppp.dion.ne.jp [61.117.28.44])
	by dsmtp4.dion.ne.jp (3.7W-03013013) id FAA18843
	for <linux-mips@linux-mips.org>; Mon, 17 Feb 2003 05:00:24 +0900 (JST)
Date: Mon, 17 Feb 2003 05:00:33 +0900
From: Kunihiko IMAI <kimai@laser5.co.jp>
To: linux-mips@linux-mips.org
Subject: Re: [patch] VR4181A and SMVR4181A
Message-Id: <20030217050033.2922575e.kimai@laser5.co.jp>
In-Reply-To: <200302161820.47585.jscheel@activevb.de>
References: <200302161820.47585.jscheel@activevb.de>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <kimai@laser5.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kimai@laser5.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Sun, 16 Feb 2003 18:20:47 +0100
Julian Scheel <jscheel@activevb.de> wrote:

> This don't helps for me. I get the same error, but with "cop00x21" instead of
> standby.

I'm sorry for shorten explanation.  Now I'm at home and have enough
document here...


o Rewrite 'standby' only in inline-assembler code, not any C symbol.

o Rewrite 'standby' with 'c0 0x21'.
  Space or tab is required between 'c0' and '0x21'.

  I thought 'cop0' op-code is also acceptable, but it may be my
  misunderstanding.


How I did to examine the mnemonic 'c0':

1. The users manual of VR-series says that machine code of 'standby'
   instruction is 0x42000021.

2. Make a file which contains only this code;
	perl -e 'printf "\x21\x00\x00\x42";' > standby.bin
	(Byte sequence is reversed because of little-endian)

3. Disassemble the file
	mipsel-linux-objdump -b binary -mmips:4600 -D standby.bin

Thanks.
_._. __._  _ . ... _  .___ ._. _____ _... ._ _._ _.._. .____  _ . ... _

                                                          Kunihiko IMAI
