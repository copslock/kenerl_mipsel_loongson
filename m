Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 00:54:07 +0100 (BST)
Received: from web81007.mail.yahoo.com ([IPv6:::ffff:206.190.37.152]:7805 "HELO
	web81007.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225207AbUJUXyD>; Fri, 22 Oct 2004 00:54:03 +0100
Message-ID: <20041021235356.47848.qmail@web81007.mail.yahoo.com>
Received: from [63.194.140.131] by web81007.mail.yahoo.com via HTTP; Thu, 21 Oct 2004 16:53:56 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Thu, 21 Oct 2004 16:53:56 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: mips startup
To: thomas_blattmann@canada.com, linux-mips@linux-mips.org
In-Reply-To: <20041021165125.4960.h021.c009.wm@mail.canada.com.criticalpath.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> I'm searching for some startup code for a MIPS4kc (
> MIPS Malta Board ) processor. I'd like to print
> something on the malta display. It's a bare machine
> so
> far. Are there any tutorials or startup examples ??
> How can I start learning ??

Try the bootloaders that are available: uboot and
yamon. You can see the bare bones machine init there.

Pete
