Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2003 13:03:29 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:62907 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225201AbTGQMD1>; Thu, 17 Jul 2003 13:03:27 +0100
Received: from [10.1.1.146] (helo=heck)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 19d7Tq-0001Vu-8p
	for linux-mips@linux-mips.org; Thu, 17 Jul 2003 14:03:26 +0200
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 19d7Tn-0001qV-00
	for <linux-mips@linux-mips.org>; Thu, 17 Jul 2003 14:03:23 +0200
Date: Thu, 17 Jul 2003 14:03:22 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: 2.4: typo in system.h / __save_and_sti
Message-ID: <20030717120322.GA6113@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Hi,

I noticed a typo in the (apparently unused) __save_and_sti() macro:

include/asm/system.h (both mips and mips64, linux_2_4 branch):

#define __save_and_sti(x)                                               \
__asm__ __volatile__(                                                   \
        "__save_and_cli\t%0"                                            \
                    ^^^
        : "=r" (x)                                                      \
        : /* no inputs */                                               \
        : "memory")

Johannes
