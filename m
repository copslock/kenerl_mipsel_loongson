Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2005 10:04:36 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:18 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133533AbVJYJEB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Oct 2005 10:04:01 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9P93oBP004430;
	Tue, 25 Oct 2005 10:03:50 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9P93nfm004429;
	Tue, 25 Oct 2005 10:03:49 +0100
Date:	Tue, 25 Oct 2005 10:03:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem in "copy_to_user"
Message-ID: <20051025090349.GA4330@linux-mips.org>
References: <f69849430510242312j5e943bbcj4d1b50e0b236662a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430510242312j5e943bbcj4d1b50e0b236662a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 24, 2005 at 11:12:45PM -0700, kernel coder wrote:

>    i'm trying to run oprofile on 2.6 kernel running on mips board.But
> when oprofile makes a system call to "sys_lookup_dcookie" function to
> find the file path of a particular sample,the function "copy_to_user"
> fails and no byte of path is copied to user sapce.
> 
> I checked all combinations for source buffer like using array instead
> of pointer but no success.
> Please suggest me what might be the cause of failure.

This bug in the oprofile userspace tools was fixed about a week ago.

  Ralf
