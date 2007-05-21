Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 16:47:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56973 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024325AbXEUPrl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 16:47:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4LFlR9T007993;
	Mon, 21 May 2007 17:47:27 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4LFlQhT007992;
	Mon, 21 May 2007 16:47:26 +0100
Date:	Mon, 21 May 2007 16:47:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org,
	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070521154726.GE5943@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070517151636.GJ3586@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 17, 2007 at 05:16:37PM +0200, Martin Michlmayr wrote:

> Apparently udev fails to rename the SGI O2 interface because it
> doesn't have a sysfs device symlink.  Does someone here know how to
> fix this?

The driver needs to be rewritten to support the device driver model which
in this case means as a platform device.

The driver is ok; it's just ancient style, not long ago was using constructs
there were already deprecated for 2.4 ...

  Ralf
