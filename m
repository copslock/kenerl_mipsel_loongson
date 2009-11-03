Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:47:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47858 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493490AbZKCPr1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:47:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3FmtmR009265;
	Tue, 3 Nov 2009 16:48:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3FmsgX009263;
	Tue, 3 Nov 2009 16:48:54 +0100
Date:	Tue, 3 Nov 2009 16:48:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@netlogicmicro.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: addinitrd deletion
Message-ID: <20091103154854.GA9161@linux-mips.org>
References: <20091103121838.GA27403@linux-mips.org> <1257262912.29642.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257262912.29642.9.camel@localhost>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 03, 2009 at 09:41:52AM -0600, Kevin Hickey wrote:

> On Tue, 2009-11-03 at 13:18 +0100, Ralf Baechle wrote:
> > Does anybody still see any use for addinitrd?  If not I'm going to delete
> > it.
> > 
> FWIW I do not...

Well, I've already queued a patch to delete addinitrd and everything else
that belongs to it.  So this question was one of these "speak up or forever
hold your peace" kind of questions :-)

I see you have a fancy new email address.

Cheers,

  Ralf
