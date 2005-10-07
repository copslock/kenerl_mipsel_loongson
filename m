Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 23:27:59 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:49677
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133589AbVJGW1n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 23:27:43 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Oct 2005 15:27:40 -0700
Message-ID: <4346F65B.6050800@avtrex.com>
Date:	Fri, 07 Oct 2005 15:27:39 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kyle Unice <unixe@comcast.net>
CC:	ppopov@embeddedalley.com, 'Brett Foster' <fosterb@uoguelph.ca>,
	linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem
References: <002d01c5cb89$a4f1b830$0400a8c0@buzz>
In-Reply-To: <002d01c5cb89$a4f1b830$0400a8c0@buzz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2005 22:27:40.0152 (UTC) FILETIME=[53CAC780:01C5CB8E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Kyle Unice wrote:
> I am using gcc-3.4.4 and the cvs checkout of linux-mips.org tree.
> Kyle

Not withstanding Maciej's comment about the real problem being the 
broken header file, I give you a quote from 
http://www.linux-mips.org/wiki/Git : "At this time only the linux.git 
repository is in production use.... all other archives are only historical."

You might consider getting your code from the git repository as the CVS 
repository is no longer being maintained.

David Daney
