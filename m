Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 15:40:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59062 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021864AbXHAOkC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 15:40:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l71Ee1Xt012923;
	Wed, 1 Aug 2007 15:40:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l71Ee1WE012918;
	Wed, 1 Aug 2007 15:40:01 +0100
Date:	Wed, 1 Aug 2007 15:40:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: cacheops.h & r4kcache.h
Message-ID: <20070801144001.GA12840@linux-mips.org>
References: <40378e40708010618r7a93e58br206e7c47e685a05e@mail.gmail.com> <20070801140114.GA23858@linux-mips.org> <40378e40708010713p3d866a9dva7d69132e61497d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708010713p3d866a9dva7d69132e61497d6@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 01, 2007 at 04:13:05PM +0200, Mohamed Bamakhrama wrote:

> I agree with you that it fits more to real-time systems. My point was
> that such a functionality can be added to the list of available macros
> (i.e. Fetch, invalidate) so that when the developer (of an embedded
> system for example) needs it, he/she can use it directly.
> 
> Is it possible to submit a patch which adds this functionality?

It takes more than a small patch to add a few cacheop definitions.  Linux
generiously uses Index cacheops and so would also blow away wired cache
lines and that would need to be prevented.  But to answer your question,
with these notes, yes.

  Ralf
