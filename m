Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 14:04:50 +0000 (GMT)
Received: from sj-msg-core-1.cisco.com ([IPv6:::ffff:171.71.163.11]:26519 "EHLO
	sj-msg-core-1.cisco.com") by linux-mips.org with ESMTP
	id <S8225192AbTBFOEt>; Thu, 6 Feb 2003 14:04:49 +0000
Received: from cisco.com (megha.cisco.com [192.122.173.140])
	by sj-msg-core-1.cisco.com (8.12.2/8.12.6) with ESMTP id h16E4fSQ021769
	for <linux-mips@linux-mips.org>; Thu, 6 Feb 2003 06:04:42 -0800 (PST)
Received: from IILANGOVW2K ([10.77.139.167])
	by cisco.com (8.8.8/2.6/Cisco List Logging/8.8.8) with SMTP id TAA19712
	for <linux-mips@linux-mips.org>; Thu, 6 Feb 2003 19:33:35 +0530 (IST)
Message-ID: <005201c2cde8$b145e5d0$a78b4d0a@apac.cisco.com>
From: "Indukumar Ilangovan" <iilangov@cisco.com>
To: <linux-mips@linux-mips.org>
Subject: manipulating e_machine value in the elf Header
Date: Thu, 6 Feb 2003 19:34:40 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <iilangov@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: iilangov@cisco.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to port linux kernel to a mips board with a R4700 processor. It
has a rom monitor program which can be used to load the image. (has support
for tftp boot, xmodem....) . This bootloader has a hardcoded cpu_type which
is cross checked with the e_machine value in the elf header. When I try to
load the linux kernel this check (cpu_type == e_machine) fails & hence the
boot loader aborts the loading of image.

I tried to change the e_machine type value by changing the EM_MIPS value in
include/linux/elf.h, still e_machine type is "8" in the image even after
completely rebuilding the image. I even changed the EM_MIPS value in
/usr/include/elf.h & couple of other locations (sde headers.....) still no
luck....though hand editing the elf header is an option.. I don't want to do
that !

If any of you have any idea/suggestions I would be a happy man !

Thanks in advance,
Indu
