Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2008 09:37:21 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:49359 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023910AbYH3IhT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 30 Aug 2008 09:37:19 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 1872E32083F;
	Sat, 30 Aug 2008 08:37:12 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Sat, 30 Aug 2008 08:37:11 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 30 Aug 2008 01:37:06 -0700
Message-ID: <48B906B1.3030708@avtrex.com>
Date:	Sat, 30 Aug 2008 01:37:05 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/6] MIPS: Hardware watch register support for gdb (version
 3).
References: <48B71ADD.601@avtrex.com>
In-Reply-To: <48B71ADD.601@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2008 08:37:06.0169 (UTC) FILETIME=[9577EE90:01C90A7B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Esteemed kernel hackers,
> 
> To follow is my third pass at MIPS watch register support.
> 

I think there will have to be at least one more pass at this.

The current design assumes that all debug registers support an identical
set of the I, R, and W bits and Mask.

However sections 8.23 and 8.24 of my

  MIPS32® Architecture For Programmers
Volume III: The MIPS32® Privileged Resource Architecture

indicate that they do not have to uniform.  I will have to augment the
ptrace structures to report the values for each register instead of a
single global value.

David Daney
