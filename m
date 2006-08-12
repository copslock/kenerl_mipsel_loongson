Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 21:41:00 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30383 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037857AbWHLUk7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 21:40:59 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7CL13hr011996;
	Sat, 12 Aug 2006 22:01:04 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7CL13wi011995;
	Sat, 12 Aug 2006 22:01:03 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: IDE routines for the ENCM3 in 2.6
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1155342822.7759.2.camel@sandbar.kenati.com>
References: <1155252440.7684.20.camel@sandbar.kenati.com>
	 <1155292164.24077.35.camel@localhost.localdomain>
	 <1155342822.7759.2.camel@sandbar.kenati.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 12 Aug 2006 22:01:02 +0100
Message-Id: <1155416462.24077.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Gwe, 2006-08-11 am 17:33 -0700, ysgrifennodd Ashlesha Shintre:
> Thanks for your inputs Alan.  I m still a bit confused though as to why
> its only the IDE routines which need to be written in a separate ide.c
> file.  My point is that there are other devices such as serial ports and
> floppy disk drives on the Southbridge too, for which there dont seem to
> be separate routines in the arch/mips/encm3 directory.

The IDE should not need seperate routines either, just any boot time set
up of resources that the core IDE expects the BIOS or firmware to have
done (if your boot firmware does not).
