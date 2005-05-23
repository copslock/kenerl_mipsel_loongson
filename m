Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 16:07:33 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([IPv6:::ffff:195.234.214.162]:52416
	"EHLO smtp.wicomtechnologies.com") by linux-mips.org with ESMTP
	id <S8225747AbVEWPHO>; Mon, 23 May 2005 16:07:14 +0100
Received: from jerry (wcm-24.wicom.kiev.ua [192.168.0.24] (may be forged))
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j4NF6v5K002964;
	Mon, 23 May 2005 18:06:58 +0300 (EEST)
	(envelope-from jerry@wicomtechnologies.com)
Date:	Mon, 23 May 2005 18:08:19 +0300
From:	Jerry <jerry@wicomtechnologies.com>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: Jerry <jerry@wicomtechnologies.com>
X-Priority: 3 (Normal)
Message-ID: <1371154543.20050523180819@wicomtechnologies.com>
To:	David Daney <ddaney@avtrex.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re[2]: 64 bit kernel for BCM1250
In-Reply-To: <428B6EDD.4040508@avtrex.com>
References: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com>
 <428B663C.7050308@avtrex.com>
 <Pine.LNX.4.61L.0505181715070.19170@blysk.ds.pg.gda.pl>
 <428B6EDD.4040508@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@wicomtechnologies.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@wicomtechnologies.com
Precedence: bulk
X-list: linux-mips

Hello David,
Wednesday, May 18, 2005, 7:35:41 PM, you wrote:

>>>I saw this with a 32 bit kernel (for a 32 bit target).  As far as I
>>>know, no 2.4.x kernels from linux-mips.org will work with gcc
>>>3.4.x.
>>  That could actually be true -- I've been using GCC 4.0.0 for quite
>> some time now (that includes CVS snapshots from before the
>> release), so I have no slightest idea whether it's OK to use older
>> versions. ;-)
>>>I have previously posted patches to this list that fixed the
>>>problem for me. Specifically I think the messages in this thread
>>>are relevant:
>>>http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=41AFDA18.2010906%40avtrex.com
>>  Hasn't one of the proposed fixes for the bug made its way to Linux
>> in the end?  That would be regrettable...
> WRT the 2.4 kernel the answer seems to be no.  And yes I think it is
> regrettable. If anybody thinks it would be useful, I could post my
> current patch again.

 Hmm right now I see the same result with oops caused
new_inode(pipe_mnt->mnt_sb) where pipe_mnt=0 witn 2.4 kernels and
gcc3.4.3 on dbau1200. If there was any changes in patch since Dec2004,
and if it hepls to solve this problem - can you please repost it
again?



   ()_()
 -( ^,^ )- -[21398845]- -<The Bat! 3.0.1.33>- -<23/05/2005 18:03>-
  (") (")
