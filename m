Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 18:16:57 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:6574 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038886AbWKNSQw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2006 18:16:52 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 0E66BE4053;
	Tue, 14 Nov 2006 11:44:08 -0800 (PST)
Subject: Re: Portmap on the Encore M3
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061114130503.GB28579@linux-mips.org>
References: <1163443607.6532.9.camel@sandbar.kenati.com>
	 <20061113233802.GA17130@linux-mips.org>
	 <1163469787.6532.26.camel@sandbar.kenati.com>
	 <20061114130503.GB28579@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 14 Nov 2006 10:28:10 -0800
Message-Id: <1163528890.6513.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips





> Use CONFIG_SERIAL_AU1X00.

--But I want to use standard 16550 compatible serial port, controlled by
the Super I/O Controller on the VIA Southbridge.. The
CONFIG_SERIAL_AU1x00 will not be able to drive this port will it?

Thanks
Ashlesha.
