Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2004 16:21:14 +0000 (GMT)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:56202 "EHLO
	localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224950AbUKYQVK>; Thu, 25 Nov 2004 16:21:10 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id iAPFHqbA018262;
	Thu, 25 Nov 2004 15:17:52 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id iAPFHprV018261;
	Thu, 25 Nov 2004 15:17:51 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.6.10-rc2-mm3] mips: fixed memory mapped I/O of IDE on
	MIPS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
In-Reply-To: <20041124175155.GE21039@linux-mips.org>
References: <20041124101809.77a1d877.yuasa@hh.iij4u.or.jp>
	 <20041124175155.GE21039@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101395868.18214.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 15:17:49 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

You also need to implement the OUTBNOSYNC operator correctly if you are
using mmio and your bridge does PCI posting. Without that you'll get the
odd problem if the IDE IRQ line is shared.
