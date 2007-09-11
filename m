Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 19:56:08 +0100 (BST)
Received: from host100-213-dynamic.0-87-r.retail.telecomitalia.it ([87.0.213.100]:11793
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20021878AbXIKS4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 19:56:00 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IVAtq-0000AD-Rc
	for linux-mips@linux-mips.org; Tue, 11 Sep 2007 20:55:53 +0200
Subject: pci-to-pci bridges on ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 11 Sep 2007 20:55:46 +0200
Message-Id: <1189536946.7988.62.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
I have a PCI board that is not recognised by Linux on MIPS. Its ID is
9710:9250, using an MCS9250 PCI-to-PCI chip manufactured by MosCHIP
(a.k.a. Netmos). 

I checked the board on i386 and it works correctly. All devices on that
board are recognised and every driver is loaded by udev upon startup.

Is there any problem with pci-to-pci bridges on mips ip32?

Thanks,
Giuseppe
