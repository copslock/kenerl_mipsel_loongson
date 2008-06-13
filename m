Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 18:10:04 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:42416 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20036100AbYFMRKC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 18:10:02 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id A312331EA7B;
	Fri, 13 Jun 2008 17:10:03 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 13 Jun 2008 17:10:03 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Jun 2008 10:09:50 -0700
Message-ID: <4852A9DD.6000602@avtrex.com>
Date:	Fri, 13 Jun 2008 10:09:49 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Horsten <thomas@horsten.com>, linux-mips@linux-mips.org
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
 has been there for a while?
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk> <4852A5EF.5080703@avtrex.com> <20080613165607.GB29015@linux-mips.org>
In-Reply-To: <20080613165607.GB29015@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2008 17:09:50.0893 (UTC) FILETIME=[4A73C5D0:01C8CD78]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jun 13, 2008 at 09:53:03AM -0700, David Daney wrote:
>>>
>> I will try said patch on my O2/R5000 and the sigma8634.
> 
> The patch is total bullshit.  It doesn't even try to fix the issues but
> rather disables the alias-avoidance mechanism.
> 

Upon further consideration of the patch, I tend to agree.  It would be nice to fix the bug though.

David Daney 
