Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 23:43:15 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:3751 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225526AbVFXWnA>;
	Fri, 24 Jun 2005 23:43:00 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Fri, 24 Jun 2005 15:42:09 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <NRBDG2B4>; Fri, 24 Jun 2005 15:42:07 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4351@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	'Andy Isaacson' <adi@hexapodia.org>,
	Prashant Viswanathan <vprashant@echelon.com>
Cc:	linux-mips@linux-mips.org
Subject: RE: glibc based toolchain for mips
Date:	Fri, 24 Jun 2005 15:42:06 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

> On Fri, Jun 24, 2005 at 03:14:49PM -0700, Prashant Viswanathan wrote:
> > Is it possible to get a free/open glibc based toolchain for MIPS?
> Buildroot
> > and ucLibc based toolchain seems to work well, but I really need a glibc
> > based toolchain. Though I can use the SDE from MIPS technologies to
> build
> > the kernel, I can't seem to use it as a toolchain to compile my own
> > applications.
> 
> Debian provides a complete native toolchain with glibc, which I've used
> with great success.  (You will need to do a nfsroot or nbd-root if you
> don't have local storage.)
> 

Thanks. But what I am really looking for is to cross-compile on a Linux i386
host. I think the SDE from MIPS can be customized to do this. But I am not
sure on how to proceed. Perhaps somebody can point me in the right
direction...
