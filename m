Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:24:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:37812 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22314590AbYJXUYF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 21:24:05 +0100
Date:	Fri, 24 Oct 2008 21:24:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Zhang Le <r0bertz@gentoo.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
In-Reply-To: <20081024072745.GA14652@adriano.hkcable.com.hk>
Message-ID: <alpine.LFD.1.10.0810242119430.31223@ftp.linux-mips.org>
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org> <20081022202812.GB10625@linux-mips.org> <20081024072745.GA14652@adriano.hkcable.com.hk>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 24 Oct 2008, Zhang Le wrote:

> Thanks for the comment.
> I have checked how other platforms handle this problem.
> Many have used CKSEG1ADDR.

 Please note long-term we want CKSEG1ADDR() to go away from board/platform 
code and possibly only keep it for some generic use if at all.  Have you 
considered using ioremap()?  With a literal physical address it should get 
optimised to the same code as the use of CKSEG1ADDR() produces, yet keep 
the source portable and in line with the rest of the kernel.  I try to 
remove references to CKSEG1ADDR() as I come across them myself too.

  Maciej
