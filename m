Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 21:26:17 +0100 (BST)
Received: from anchor-post-33.mail.demon.net ([IPv6:::ffff:194.217.242.91]:54535
	"EHLO anchor-post-33.mail.demon.net") by linux-mips.org with ESMTP
	id <S8225206AbTENU0N>; Wed, 14 May 2003 21:26:13 +0100
Received: from abyss2.demon.co.uk ([62.49.62.197] helo=rogue.abyss2.demon.co.uk)
	by anchor-post-33.mail.demon.net with esmtp (Exim 3.35 #1)
	id 19G2pB-000LX2-0X; Wed, 14 May 2003 21:26:05 +0100
Subject: Re: mips toolchain for solaris
From: "Luke A. Guest" <laguest@abyss2.demon.co.uk>
To: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@linux-mips.org>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F2590172ECC6@SJC1EXM02>
References: <9DFF23E1E33391449FDC324526D1F2590172ECC6@SJC1EXM02>
Content-Type: text/plain
Organization: 
Message-Id: <1052943962.23940.2.camel@rogue.abyss2.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 14 May 2003 21:26:02 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <laguest@abyss2.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laguest@abyss2.demon.co.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2003-05-14 at 20:55, Manoj Ekbote wrote:
> I don't know if this is the right place for this question but...
> Is there a place where I could find the latest mips cross-toolchain for the Solaris platform?

You could just build a cross compiler (gcc) for mips-elf. Depends on
whether you require a libc. I just built this particular version of the
compiler as I don't require anything else.

Luke.
