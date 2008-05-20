Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2008 00:07:48 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:42747 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28575681AbYETXHq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2008 00:07:46 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4KN7Qut002102;
	Wed, 21 May 2008 01:07:26 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4KN79Qe002098;
	Wed, 21 May 2008 00:07:18 +0100
Date:	Wed, 21 May 2008 00:07:09 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [2.6 patch] mips/kernel/Makefile: remove CONFIG_CPU_R4000 line
In-Reply-To: <20080520225502.GC16264@cs181133002.pp.htv.fi>
Message-ID: <Pine.LNX.4.55.0805210002360.31790@cliff.in.clinika.pl>
References: <20080520225502.GC16264@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 21 May 2008, Adrian Bunk wrote:

> The existing options are named CONFIG_CPU_R4300 and CONFIG_CPU_R4X00, 
> and they are directly below.
> 
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

 That's a left-over from an early attempt to work around R4000 errata.  It 
has been since dealt with a bit differently without the need for a 
separate CPU type.  I must have missed this rule by accident.  Thanks for 
the fix.

  Maciej
