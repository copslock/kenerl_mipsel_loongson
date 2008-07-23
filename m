Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 17:27:40 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:28065 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20030024AbYGWQ1i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 17:27:38 +0100
Received: from lagash (p549ACCC1.dip.t-dialin.net [84.154.204.193])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id A903A48917;
	Wed, 23 Jul 2008 18:27:37 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KLhBl-0005Ne-E8; Wed, 23 Jul 2008 17:27:41 +0100
Date:	Wed, 23 Jul 2008 17:27:41 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Naresh Bhat <nareshgbhat@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel is Hanging for page size 16KB.
Message-ID: <20080723162741.GA17043@networkno.de>
References: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Naresh Bhat wrote:
> Hi Guys,
> 
> I have a board MIPS Malta and Linux 2.6.10 is running on that. By default
> 4KB page size will be allocated in the kernel (I mean to say I saw it when I
> do the "make menuconfig".
> 
> Problem is:
> 
> When I changed the page size to 16KB it will hang after mounting the file
> system. I am using the NFS for booting the board.

IIRC the old TLB handlers were buggy for anything else than 4k pages.
For the Malta, upgrading to a recent kernel version should be the
simplest way to solve the problem.


Thiemo
