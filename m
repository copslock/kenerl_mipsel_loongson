Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 17:53:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65468 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133903AbWFVQxb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2006 17:53:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5MGrQCp003471;
	Thu, 22 Jun 2006 17:53:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5MGrKdU003470;
	Thu, 22 Jun 2006 17:53:20 +0100
Date:	Thu, 22 Jun 2006 17:53:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Domen Puncer <domen.puncer@ultra.si>, linux-mips@linux-mips.org
Subject: Re: [patch] au1550_ac97: spin_unlock in error path
Message-ID: <20060622165320.GA3415@linux-mips.org>
References: <20060622092913.GA18607@domen.ultra.si> <449AB731.40301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449AB731.40301@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 22, 2006 at 07:28:49PM +0400, Sergei Shtylyov wrote:

>    Dang, we missed it while fixing the spinlocks in that driver. Thank you 
> for noticing. Not sure if Ralf would be eaegr to apply though. :-)

I feed it to upstream, so it will eventually show up in the tree on
the indirect path.

  Ralf
