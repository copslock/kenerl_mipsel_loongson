Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:30:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53136 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037615AbXCEQaV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:30:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l25GSRoP007325;
	Mon, 5 Mar 2007 16:28:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l25GSQpU007324;
	Mon, 5 Mar 2007 16:28:26 GMT
Date:	Mon, 5 Mar 2007 16:28:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <Mile.Davidovic@micronasnit.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Encrypt user file system
Message-ID: <20070305162826.GC786@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 02:51:10PM +0100, Mile Davidovic wrote:

> What is mips way for encrypting user file system? 
> On intel we can use combination dm-crypt and we could crypt complete user FS I
> suppose that should work on MIPS too?

Yes, of course.

  Ralf
