Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 15:43:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54942 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493315AbZI1NnD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Sep 2009 15:43:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8SDiNMj029847;
	Mon, 28 Sep 2009 14:44:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8SDiNb1029845;
	Mon, 28 Sep 2009 14:44:23 +0100
Date:	Mon, 28 Sep 2009 14:44:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
Message-ID: <20090928134423.GA29791@linux-mips.org>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net> <20090923123143.GB3131@pengutronix.de> <1253709915.1627.397.camel@sakura.staff.proxad.net> <1253890476.1627.468.camel@sakura.staff.proxad.net> <4ABCF1E7.4010304@ru.mvista.com> <1254142183.1627.488.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254142183.1627.488.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Maxim,

so with PCMCIA sorted this leaves only the two USB UHCI / EHCI patches.
What is the status of these?

  Ralf
