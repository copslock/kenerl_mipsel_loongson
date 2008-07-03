Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 06:06:24 +0100 (BST)
Received: from ms5.Sony.CO.JP ([211.125.136.201]:59346 "EHLO ms5.sony.co.jp")
	by ftp.linux-mips.org with ESMTP id S20096375AbYGCFGQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2008 06:06:16 +0100
Received: from mta5.sony.co.jp (mta5.Sony.CO.JP [137.153.71.6])
 by ms5.sony.co.jp (R8/Sony) with ESMTP id m6355s59016330;
 Thu, 3 Jul 2008 14:05:54 +0900 (JST)
Received: from mta5.sony.co.jp (localhost [127.0.0.1])
 by mta5.sony.co.jp (R8/Sony) with ESMTP id m6355slJ029703;
 Thu, 3 Jul 2008 14:05:54 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
 by mta5.sony.co.jp (R8/Sony) with ESMTP id m6355sVc029691;
 Thu, 3 Jul 2008 14:05:54 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.141.32]) by smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id m6355sP11050; Thu, 3 Jul 2008 14:05:54 +0900 (JST)
Received: from [43.4.145.254] (gco-w12f-vlan145-254.sm.sony.co.jp [43.4.145.254])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id m6355oL8012013;
	Thu, 3 Jul 2008 14:05:50 +0900 (JST)
Date:	Thu, 03 Jul 2008 14:05:54 +0900
From:	Yoriko Komatsuzaki <yoriko@sm.sony.co.jp>
To:	Daniel Jacobowitz <dan@debian.org>
Subject: Re: do-lookup.h regarding to mips/dlsym and libstdc++
Cc:	Chris Friesen <cfriesen@nortel.com>,
	libc-ports <libc-ports@sourceware.org>, linux-mips@linux-mips.org
In-Reply-To: <20080702124722.GA15301@caradoc.them.org>
References: <20080129132739.5D6B.YORIKO@sm.sony.co.jp> <20080702124722.GA15301@caradoc.them.org>
Message-Id: <20080703140301.D2B2.C06B4389@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.47 [ja]
Return-Path: <yoriko@sm.sony.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoriko@sm.sony.co.jp
Precedence: bulk
X-list: linux-mips


Thank you for your reply.
I will do the checking.

---
Yoriko Komatsuzaki (yoriko@sm.sony.co.jp)
System Software Development Department
Common Technology Division
Technology Development Group
Sony Corporation

> On Tue, Jan 29, 2008 at 01:32:20PM +0900, Yoriko Komatsuzaki wrote:
> > Because even though UNDEF symbol is found, 
> > it can process as global symbol for the rare occasion.
> > 
> > This phenomena is showed only in mips. When libstdc++ is linked in
> > proior libc, the malloc's entry in libstdc++ MIPS.stubs table seemed to
> > be recognized as the malloc global symbol ...
> > 
> > How do you feel about it?
> 
> On Mon, May 26, 2008 at 11:51:56AM -0600, Chris Friesen wrote:
> > On MIPS, the DEFAULT returns the address of this libraries undefined  
> > symbol for the extern and NEXT returns our external procedure.  Putting  
> > in a second RTLD_NEXT call returned the real sigaction address.
> >
> > This worked for most procedures we are looking for. However, during  
> > booting, we have an app that uses a specific library which has an extern  
> > for sigaction as well and now in the preloaded code we need a fourth call 
> > to dlsym to skip that one.
> 
> Hi folks,
> 
> This bug is fixed as a by-product of support for non-PIC MIPS
> executables.  Either Richard's patch or CodeSourcery's, applied to
> glibc, should suffice.  It'll be another week or two at least before
> they're applied to CVS, but in the mean time you can find them here:
> 
> http://sourceware.org/ml/binutils/2008-06/msg00280.html
> http://sourceware.org/ml/binutils/2008-07/msg00008.html
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery
> 
