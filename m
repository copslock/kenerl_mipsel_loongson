Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 16:44:09 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:27085 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225624AbUDEPoI>;
	Mon, 5 Apr 2004 16:44:08 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA04748;
	Tue, 6 Apr 2004 00:44:04 +0900 (JST)
Received: 4UMDO01 id i35Fi3r16050; Tue, 6 Apr 2004 00:44:03 +0900 (JST)
Received: 4UMRO00 id i35Fi2j03214; Tue, 6 Apr 2004 00:44:03 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 6 Apr 2004 00:44:01 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Updated patches of PCI fixup  function for vr41xx
 platform
Message-Id: <20040406004401.3d654716.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I updated these patches.

These patches fixed PCI fixup function for vr41xx platform.
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

Yoichi
