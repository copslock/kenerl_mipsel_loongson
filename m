Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 14:43:22 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:26629 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133722AbVJaOnE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 14:43:04 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9VEhS7r029646;
	Mon, 31 Oct 2005 14:43:28 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9VEhS9m029645;
	Mon, 31 Oct 2005 14:43:28 GMT
Date:	Mon, 31 Oct 2005 14:43:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
Cc:	"'Linux MIPS List'" <linux-mips@linux-mips.org>
Subject: Re: Git Repo
Message-ID: <20051031144327.GA29199@linux-mips.org>
References: <43652B23.30409@gentoo.org> <200510310618.j9V6Icrn002006@lilac.hdcindia.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310618.j9V6Icrn002006@lilac.hdcindia.analog.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 31, 2005 at 11:54:24AM +0530, Sathesh Babu Edara wrote:

>    I too get same error message.I am new to GIT.I want to checkout
> linux-2.6.12 tag from the git archive.Can some one help me what commands I
> should use to checkout.I am trying to connect GIT  repo via gitweb from my
> Windows-XP system.

Gitweb is for browsing repositories only, not for checking out.

If you actually want to checkout from git I suggest you start by installing
Linux; there apparently is a Cygwin port but I expect it to be rather slow
and you may hit more interesting problems with Cygwin.

  Ralf
