Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 07:59:49 +0200 (CEST)
Received: from [213.163.26.102] ([213.163.26.102]:2317 "EHLO
	tarzan.ugyvitelszolgaltato.hu") by linux-mips.org with ESMTP
	id <S1123915AbSJBF7t>; Wed, 2 Oct 2002 07:59:49 +0200
Received: from atti.ugyvitelszolgaltato.hu (atti.ugyvitelszolgaltato.hu [193.80.82.9])
	by tarzan.ugyvitelszolgaltato.hu (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id IAA10428
	for <linux-mips@linux-mips.org>; Wed, 2 Oct 2002 08:40:54 +0200
Received: from root by atti.ugyvitelszolgaltato.hu with local (Exim 3.35 #1 (Debian))
	id 17wcXn-0003E7-00
	for <linux-mips@linux-mips.org>; Wed, 02 Oct 2002 07:59:35 +0200
Date: Wed, 2 Oct 2002 07:59:35 +0200
From: Attila Szabo <trial@ugyvitelszolgaltato.hu>
To: linux-mips@linux-mips.org
Subject: some indy question
Message-ID: <20021002055935.GA12393@csola.ugyvitelszolgaltato.hu>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Ugyvitelszolgaltato Kft.
X-OS: Linux 2.4.18, Debian Woody
X-Sys: MSI K7T Turbo, AMD Tbird 850MHz, 1GB RAM, Matrox g200, 20GB Hdd
X-WM: Blackbox 0.62
Return-Path: <root@ugyvitelszolgaltato.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trial@ugyvitelszolgaltato.hu
Precedence: bulk
X-list: linux-mips

Hi,

When I try to use the external cdrom on my Indy,
the machine produces scsi errors, like command timeout and
I have to reboot with sysrq.
I tried two harddisks but the same.Under Irix it is
working with the same scsi id-s.
Is there a bug around cdrom,sr_mod or something to know
about the external cdroms under 2.4.17 ?
It is working with external harddisk.
I use 2.4.17, woody.
I tried to compile 2.4.18 but the newport console gets
blue and the output stops, otherwise ok.
I tried to compile linux-2.4.19 from cvs, but
it does'nt boot.
Please tell me what's this cdrom error and
which kernel is known to be completely working ?

thank you

-- 
-
-
A t t i l a :: trial@ugyvitelszolgaltato.hu :: S z a b o
-
-
