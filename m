Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 17:32:24 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1229 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20024735AbXHXQcO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 17:32:14 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id l7OGcJKc013976;
	Fri, 24 Aug 2007 17:38:19 +0100
Date:	Fri, 24 Aug 2007 17:38:19 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kobject_add failed for vcs1 with -EEXIST
Message-ID: <20070824173819.15032660@the-village.bc.nu>
In-Reply-To: <20070824162044.GB7029@deprecation.cyrius.com>
References: <20070824162044.GB7029@deprecation.cyrius.com>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.10.14; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 24 Aug 2007 18:20:44 +0200
Martin Michlmayr <tbm@cyrius.com> wrote:

> I just booted a current git kernel on a Fulong mini-PC and saw the
> following in dmesg:
> 
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 128k freed
> kobject_add failed for vcs1 with -EEXIST, don't try to register things with the
> same name in the same directory.
> Call Trace:

I see this on x86 with all kernels newer than about 2.6.20, but at random
and only rarely. I'd love to know what is going on and if the mips is a
reproducable case thata good news.

Alan
