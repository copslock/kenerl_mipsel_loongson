Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 15:25:36 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:8959 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225229AbUCQPZf>;
	Wed, 17 Mar 2004 15:25:35 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA25546;
	Thu, 18 Mar 2004 00:25:31 +0900 (JST)
Received: 4UMDO00 id i2HFPUW18595; Thu, 18 Mar 2004 00:25:30 +0900 (JST)
Received: 4UMRO01 id i2HFPSd28871; Thu, 18 Mar 2004 00:25:30 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 18 Mar 2004 00:25:27 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed PCI fixup for vr41xx
Message-Id: <20040318002527.413195ce.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These patches fix PCI fixup function about vr41xx.
Please apply these patches to v2.6.

NEC Eagle:
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/03-eagle-fixup-pci.diff

TANBAC TB0219:
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/05-tb0219-fixup-pci.diff

ZAO Networks Capcella:
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/07-capcella-fixup-pci.diff

TNABAC TB0226:
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/09-tb0226-fixup-pci.diff

Victor MP-C30x:
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/11-mpc30x-fixup-pci.diff

and, I already sent to you the following patches.
Please apply these patches to v2.6.

[PATCH][2.6] Change Kconfig about companion chip for vr41xx
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/01-Kconfig-VRC417x.diff

[PATCH][2.6] Fixed PCMCIA configuration about vr41xx
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/02-Kconfig-VRC417x-PCMCIA.diff

[PATCH][2.6] Update TB0229+TB0219 support
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/03-eagle-fixup-pci.diff


Thanks,

Yoichi
