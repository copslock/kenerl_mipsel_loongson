Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2008 18:57:06 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13903 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21161825AbYJJR5D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Oct 2008 18:57:03 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ef975e0000>; Fri, 10 Oct 2008 13:56:46 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 10:56:45 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 10:56:45 -0700
Message-ID: <48EF975C.7090407@caviumnetworks.com>
Date:	Fri, 10 Oct 2008 10:56:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Report all watch register masks in /proc/cpuinfo.
References: <48EF8A69.9070307@caviumnetworks.com>
In-Reply-To: <48EF8A69.9070307@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2008 17:56:45.0218 (UTC) FILETIME=[8F13F020:01C92B01]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Report all watch register masks in /proc/cpuinfo.
> 
> Some CPUs have heterogeneous watch register properties.  Let's show
> them all.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---

Drat!, That version has trailing white space.  I will send a corrected
patch.

David Daney
