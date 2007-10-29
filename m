Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 20:53:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32173 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574403AbXJ2Uxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 20:53:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TKrcl0002148;
	Mon, 29 Oct 2007 20:53:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TKrbEh002147;
	Mon, 29 Oct 2007 20:53:37 GMT
Date:	Mon, 29 Oct 2007 20:53:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Binod Roay <binodroay@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Question related to Linux Kernel and MIPS
Message-ID: <20071029205337.GB2075@linux-mips.org>
References: <423926.37963.qm@web37907.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423926.37963.qm@web37907.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 08:24:15AM -0700, Binod Roay wrote:

> Could I please know is it possible run the Linux
> Kernel on MIPS from KUSEG ?

You'd have to port UML to MIPS for something like this.

  Ralf
