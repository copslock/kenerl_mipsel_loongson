Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 17:48:36 +0000 (GMT)
Received: from gw02.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.116]:39874
	"EHLO gw02.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8225196AbULCRsb>; Fri, 3 Dec 2004 17:48:31 +0000
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id A1A8F856BC
	for <linux-mips@linux-mips.org>; Fri,  3 Dec 2004 19:48:26 +0200 (EET)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id 57CA88DC3
	for <linux-mips@linux-mips.org>; Fri,  3 Dec 2004 19:48:38 +0200 (EET)
Message-ID: <001301c4d960$382122c0$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: arcboot initrd+iso9660+shell patch
Date: Fri, 3 Dec 2004 19:47:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

Hi

The patch is kinda large so I won't send it to the list, unless
it's ok? It is about 73k.

The patch does:
- Add initrd support (arcboot.conf: initrd=/ramdisk.gz)
- Add interactive/shell mode
  - Load kernel
  - Load ramdisk
  - Edit kernel cmdline arguments
  - ls
  - help for list of commands
- Add working iso9660 support
- Unfinished romfs support
- It's probably a mess
- Probably has many bugs here and there
- To start interactive mode boot with -i as parameter:
  "arcboot -i"
- Tested on IP32 only (and patch changes default to IP32 :)

http://home.tal.org/~milang/o2/patches/arcboot_onion_iso_shell_initrd-1.patch

A binary for IP32 is also available:
http://home.tal.org/~milang/o2/patches/arcboot-patched-1.ip32

Enjoy!

-- 
Kaj-Michael Lang , milang@tal.org
