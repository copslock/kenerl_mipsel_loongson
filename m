Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 12:06:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32976 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029485AbYAEMGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jan 2008 12:06:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m05C6g6C010527;
	Sat, 5 Jan 2008 13:06:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m05C6goN010526;
	Sat, 5 Jan 2008 13:06:42 +0100
Date:	Sat, 5 Jan 2008 13:06:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Assume newer R4000/R4400 don't have the mfc0 count bug
Message-ID: <20080105120642.GB9805@linux-mips.org>
References: <20080104223831.15FF4C2EF3@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080104223831.15FF4C2EF3@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 04, 2008 at 11:38:31PM +0100, Thomas Bogendoerfer wrote:

> Assume newer R4000/R4400 don't have the mfc0 count bug

Applied,

  Ralf
