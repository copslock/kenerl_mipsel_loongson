Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 14:09:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13769 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038840AbWKWOJY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Nov 2006 14:09:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kANE9FbX028874;
	Thu, 23 Nov 2006 14:09:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kANE9EIu028873;
	Thu, 23 Nov 2006 14:09:14 GMT
Date:	Thu, 23 Nov 2006 14:09:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andre.Messerschmidt@infineon.com
Cc:	ashlesha@kenati.com, linux-mips@linux-mips.org
Subject: Re: init cannot spawn shell
Message-ID: <20061123140914.GA24273@linux-mips.org>
References: <1164246953.6511.25.camel@sandbar.kenati.com> <B0956DED3DE3CD47BF0398D4E0ECE59F011B70C9@mucse307.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0956DED3DE3CD47BF0398D4E0ECE59F011B70C9@mucse307.eu.infineon.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 23, 2006 at 07:45:25AM +0100, Andre.Messerschmidt@infineon.com wrote:

> > I m sure that the endianness is not an issue - everything is big 
> > endian.
> 
> We had some problem in the past, where the reverse endianess bit was
> set, that would result in a crash when the system starts init. Not sure
> what bootloader you are using, but maybe it is worth checking the RE bit
> in CP0.STATUS, since otherwise your userspace applications will run in
> little endian.

This was fixed in February for 2.6.16 already.  Also Ashleha is using
a different CPU ...

  Ralf
