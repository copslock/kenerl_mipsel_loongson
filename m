Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 09:46:16 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45447 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492330AbZH1HqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 09:46:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7S7lALU011660
	for <linux-mips@linux-mips.org>; Fri, 28 Aug 2009 08:47:10 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7S7l9lw011658
	for linux-mips@linux-mips.org; Fri, 28 Aug 2009 08:47:09 +0100
Date:	Fri, 28 Aug 2009 08:47:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: MTX build failure
Message-ID: <20090828074709.GA11637@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

  CC      drivers/input/keyboard/gpio_keys.o
/home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In function ‘gpio_keys_probe’:
/home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123: error: implicit declaration of function ‘gpio_request’
/home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135: error: implicit declaration of function ‘gpio_free’
make[5]: *** [drivers/input/keyboard/gpio_keys.o] Error 1
make[4]: *** [drivers/input/keyboard] Error 2
make[3]: *** [drivers/input] Error 2
make[2]: *** [drivers] Error 2
make[1]: *** [sub-make] Error 2

  Ralf
