Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 07:44:31 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:30430 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575714AbYECGo2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 May 2008 07:44:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m436iO8I004096;
	Sat, 3 May 2008 07:44:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m436iOZs004088;
	Sat, 3 May 2008 07:44:24 +0100
Date:	Sat, 3 May 2008 07:44:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Bring the SWARM defconfig up to date
Message-ID: <20080503064424.GA15574@linux-mips.org>
References: <Pine.LNX.4.55.0805030008280.12296@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0805030008280.12296@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 03, 2008 at 12:48:45AM +0100, Maciej W. Rozycki wrote:

>  The SWARM defconfig file has not been regenerated for over a year now.
> Here is a patch to bring the file up to date.  Additionally some important
> and sometimes confusing changes happened meanwhile.  Here is the list of 
> notable corresponding updates to the configuration:
> 
> 1. CPU_SB1_PASS_2_2 is now selected rather than CPU_SB1_PASS_1.  The
>    latter requires a non-standard -msb1-pass1-workarounds option to be
>    supported by GCC and I am told is quite rare anyway.

Farely rare is a nice way to express it.  The option exists in MV's
gcc 3.0 and as you know gcc 3.0 is no longer suitable to build a kernel ...

  Ralf
