Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 01:35:03 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:8108 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225270AbTBZBfD>;
	Wed, 26 Feb 2003 01:35:03 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1Q1YxKp016709
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Tue, 25 Feb 2003 17:35:00 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA23273 for <linux-mips@linux-mips.org>; Wed, 26 Feb 2003 12:34:58 +1100
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 30C123000B8; Wed, 26 Feb 2003 12:34:56 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP id D68968F
	for <linux-mips@linux-mips.org>; Wed, 26 Feb 2003 12:34:56 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: modules_install 
In-reply-to: Your message of "Tue, 25 Feb 2003 14:51:40 BST."
             <Pine.GSO.4.21.0302251451040.15407-100000@vervain.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Feb 2003 12:34:51 +1100
Message-ID: <362.1046223291@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, 25 Feb 2003 14:51:40 +0100 (MET), 
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>On Tue, 25 Feb 2003, Gilad Benjamini wrote:
>> How does one tweak the kernel's "modules_install" target in the 
>> makefile to properly be used for cross compiling ?
>> I can change the kernel Makefile, but I'd rather not.
>
>make INSTALL_MOD_PATH=...
>
>Note that depmod will fail anyway.

Cross compile for ia64.

make ARCH=ia64 \
	CROSS_COMPILE=/usr/bin/ia64-linux- \
	INSTALL_MOD_PATH=/build/kaos \
	DEPMOD=/bin/true

DEPMOD=/bin/true makes depmod a noop, the first boot on the target will
build modules.dep.
