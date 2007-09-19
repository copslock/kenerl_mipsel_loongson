Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 01:13:07 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:18106 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023291AbXISAM5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 01:12:57 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id ACADD30A817;
	Wed, 19 Sep 2007 00:13:07 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 19 Sep 2007 00:13:07 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Sep 2007 17:12:48 -0700
Message-ID: <46F06980.4080500@avtrex.com>
Date:	Tue, 18 Sep 2007 17:12:48 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>
Cc:	linux-mips@linux-mips.org
Subject: MIPS atomic memory operations (A.K.A PR 33479).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2007 00:12:48.0986 (UTC) FILETIME=[CFDAB3A0:01C7FA51]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Richard,

There seems to be a small problem with the MIPS atomic memory operations 
patch I recently committed 
(http://gcc.gnu.org/ml/gcc-patches/2007-08/msg01290.html), in that on a 
dual CPU machine it does not quite work.

You can look at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33479#c3 for 
more information.

Here is the code in question (from mips.h):

#define MIPS_COMPARE_AND_SWAP(SUFFIX, OP)	\
   "%(%<%[sync\n"				\
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\tbne\t%0,%2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
   "\tbeq\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "2:%]%>%)"



I guess my basic question is:  Should MIPS_COMPARE_AND_SWAP have a 
'sync' after the 'sc'?  I would have thought that 'sc' made the write 
visible to all CPUs, but on the SB1 it appears not to be the case.

If we do need to add another 'sync' should it go in the delay slot of 
the branch?  I would say yes because we would expect the branch to 
rarely taken.

Any feedback from linux-mips people is also solicited.

Thanks,
David Daney
