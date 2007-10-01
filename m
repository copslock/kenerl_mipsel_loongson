Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 11:50:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51114 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022277AbXJAKuF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 11:50:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l91Ao45W031932;
	Mon, 1 Oct 2007 11:50:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l91Ao3MJ031931;
	Mon, 1 Oct 2007 11:50:03 +0100
Date:	Mon, 1 Oct 2007 11:50:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	KokHow.Teh@infineon.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux-2.6.20 malta board build with GCC-4.0.0 build error
Message-ID: <20071001105003.GA23647@linux-mips.org>
References: <31E09F73562D7A4D82119D7F6C17298602667FE0@sinse303.ap.infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31E09F73562D7A4D82119D7F6C17298602667FE0@sinse303.ap.infineon.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 30, 2007 at 05:18:39PM +0800, KokHow.Teh@infineon.com wrote:

> 	I am using eldk-4.1 with gcc-4.0.0 to build linux-2.6.20 for
> Malta board little-endian. I bump into following build error with
> mipsel-linux-ld:

Odd.  All I can tell you is the linuxel-mips target of SDE and the vanilla
GNU toolchain builds are working right out of the box.  But keepfiners
away from binutils 2.18 which will produce a bad executable, something I
still haven't managed to enquire.

  Ralf
