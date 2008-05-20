Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 21:04:02 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60653 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28575509AbYETUEA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 May 2008 21:04:00 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4KK3Ce6016948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 May 2008 13:03:13 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m4KK3BOs008762;
	Tue, 20 May 2008 13:03:11 -0700
Date:	Tue, 20 May 2008 13:03:11 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	anemo@mba.ocn.ne.jp, a.zummo@towertech.it, hvr@gnu.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: M41T80: Century Bit support
Message-Id: <20080520130311.58a8e5ac.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.55.0805202045320.31790@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805170057370.4049@cliff.in.clinika.pl>
	<20080518.000242.41199304.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.55.0805171959030.10067@cliff.in.clinika.pl>
	<20080519.011034.25909336.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.55.0805202045320.31790@cliff.in.clinika.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 May 2008 20:51:56 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Andrew, could you please hold the patch in -mm till the flags have been 
> added?

It's be saner for me to drop it and have you resend when appropriate. 
The chances of me being able to succesfully correlate this patch and
something called "the flags" at some time in the future are less than
100% ;)
