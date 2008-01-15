Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 06:31:49 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:48928 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023185AbYAOGbk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 06:31:40 +0000
Received: by mo.po.2iij.net (mo31) id m0F6VZaU013443; Tue, 15 Jan 2008 15:31:35 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id m0F6VXh4000642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2008 15:31:34 +0900
Date:	Tue, 15 Jan 2008 15:32:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Noah Meyerhans <frodo@morgul.net>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: memory related kernel bug on cobalt raq2
Message-Id: <20080115153225.1ee724c8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080114153114.GN3899@morgul.net>
References: <20080114153114.GN3899@morgul.net>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 14 Jan 2008 10:31:14 -0500
Noah Meyerhans <frodo@morgul.net> wrote:

> Hi all.  I know this has come up in the past, but in case it's helpful, I
> figured I'd report that the kernel bug previously reported at (at least)
> http://www.linux-mips.org/archives/linux-mips/2007-10/msg00093.html is still
> present in current git kernels (more recently observed in
> 2.6.24-rc7-raq2-gaeb7040e-dirty).  Here's the kernel output:

Do you use swap on your raq2?

Yoichi
