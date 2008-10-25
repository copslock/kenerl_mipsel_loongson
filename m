Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2008 08:32:28 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:992 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22339221AbYJYHcU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Oct 2008 08:32:20 +0100
Received: (qmail 28545 invoked by uid 508); 25 Oct 2008 07:32:12 -0000
Received: from 203.83.114.121 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.155551 secs); 25 Oct 2008 07:32:12 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 25 Oct 2008 07:32:11 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9P7Vx10023588;
	Sat, 25 Oct 2008 15:32:11 +0800 (HKT)
Date:	Sat, 25 Oct 2008 15:31:54 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
Message-ID: <20081025073153.GB4142@adriano.hkcable.com.hk>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org> <20081022202812.GB10625@linux-mips.org> <20081024072745.GA14652@adriano.hkcable.com.hk> <alpine.LFD.1.10.0810242119430.31223@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810242119430.31223@ftp.linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 21:24 Fri 24 Oct     , Maciej W. Rozycki wrote:
> On Fri, 24 Oct 2008, Zhang Le wrote:
> 
> > Thanks for the comment.
> > I have checked how other platforms handle this problem.
> > Many have used CKSEG1ADDR.
> 
>  Please note long-term we want CKSEG1ADDR() to go away from board/platform 
> code and possibly only keep it for some generic use if at all.  Have you 
> considered using ioremap()?  With a literal physical address it should get 
> optimised to the same code as the use of CKSEG1ADDR() produces, yet keep 
> the source portable and in line with the rest of the kernel.

Thank you!
I will make a new patch.

Zhang, Le
