Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 13:24:19 +0100 (BST)
Received: from fw01.bwg.de ([213.144.14.242]:12364 "EHLO fw01.bwg.de")
	by ftp.linux-mips.org with ESMTP id S8133627AbWC1MYL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 13:24:11 +0100
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.13.3/8.13.3) with ESMTP id k2SCYbg2014676
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 14:34:38 +0200 (CEST)
Received: from kundenmail (193.47.152.5) by fw01-4.bwg.de (smtprelay) with ESMTP Tue Mar 28 14:34:34 2006.
Received: from ximap.arbeitsgruppe (217.81.172.162)
          by kundenmail with MERCUR Mailserver (v4.03.15 MTI1LTI0MzctNDg3Nw==)
          for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 14:36:03 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with ESMTP id A8C35174B2E
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 14:35:03 +0200 (CEST)
Message-ID: <44292D57.3060400@rw-gmbh.de>
Date:	Tue, 28 Mar 2006 14:34:31 +0200
From:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Assember error in arch/mips/kernel/r4k_switch.S / latest git 2.6.16
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

 
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Since a few days I have following compiler / assembler problem:
...
  CC      arch/mips/kernel/module.o
  AS      arch/mips/kernel/r4k_fpu.o
  AS      arch/mips/kernel/r4k_switch.o
/pub/build/linux-mips/work-temp/arch/mips/kernel/r4k_switch.S: Assembler 
messages:
/pub/build/linux-mips/work-temp/arch/mips/kernel/r4k_switch.S:73: Error: 
missing ')'
/pub/build/linux-mips/work-temp/arch/mips/kernel/r4k_switch.S:76: Error: 
missing ')'
make[2]: *** [arch/mips/kernel/r4k_switch.o] Fehler 1
make[1]: *** [arch/mips/kernel] Fehler 2
make: *** [vmlinux] Fehler 2

ralf@knoppix:/pub/build/linux-mips/work-temp$ mipsel-linux-as --version
GNU assembler 2.16.1 Debian GNU/Linux
Copyright 2005 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `mipsel-linux'.

What goes wrong?

Thanks and regards
Ralf
