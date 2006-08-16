Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 15:55:39 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:32437 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20037566AbWHPOzh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Aug 2006 15:55:37 +0100
Received: (qmail 8320 invoked from network); 16 Aug 2006 14:55:39 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO dev.rtsoft.ru.) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 16 Aug 2006 14:55:39 -0000
Date:	Wed, 16 Aug 2006 18:55:42 +0400
From:	Vitaly Wool <vitalywool@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix compilation breakage for PNX8550
Message-Id: <20060816185542.3f93487c.vitalywool@gmail.com>
In-Reply-To: <44E32CFB.6030601@ru.mvista.com>
References: <20060816172906.5a2cafb1.vitalywool@gmail.com>
	<44E32CFB.6030601@ru.mvista.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 16 Aug 2006 18:34:35 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >  arch/mips/philips/pnx8550/common/Makefile   |    1
> >  arch/mips/philips/pnx8550/common/gdb_hook.c |  109 ----------------------------
> 
>     NAK these two files -- you're effectively deleting KGDB support for PNX8550.

Well, it just doesn't work any more -- what can I do?
I think that removing that here and adding some time later makes more sense than keeping bogus code.

Vitaly
