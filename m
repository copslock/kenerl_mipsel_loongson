Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 08:28:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43852 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023147AbZEPH23 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 08:28:29 +0100
Date:	Sat, 16 May 2009 08:28:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Peter 'p2' De Schrijver <p2@debian.org>
cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: sb1250 ethernet driver problem
In-Reply-To: <20090513202259.GO1835@apfelkorn>
Message-ID: <alpine.LFD.1.10.0905160752140.12158@ftp.linux-mips.org>
References: <20090513191557.GN1835@apfelkorn> <20090513192549.GS2999@deprecation.cyrius.com> <20090513202259.GO1835@apfelkorn>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 13 May 2009, Peter 'p2' De Schrijver wrote:

> > > There seems to be a bug in the mdio part of the sb1250 ethernet
> > > driver in 2.6.30-rc5. See attached log file.
> > 
> > I believe this is a generic problem with CONFIG_FIXED_PHY,
> > see http://markmail.org/message/yhaorue23uuiqgal
> 
> Ok. Thanks. That seems to solve the problem. I still get other errors though.

 Note that you really want to include CONFIG_BROADCOM_PHY for the BCM1250 
network interface -- that driver is there for a reason. ;)

  Maciej
