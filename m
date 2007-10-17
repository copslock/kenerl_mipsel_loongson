Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:22:40 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:22726 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20036065AbXJQQWa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 17:22:30 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 385FF30A218;
	Wed, 17 Oct 2007 16:22:03 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 17 Oct 2007 16:22:02 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 Oct 2007 09:21:44 -0700
Message-ID: <47163697.9020904@avtrex.com>
Date:	Wed, 17 Oct 2007 09:21:43 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	veerasena reddy <veerasena_b@yahoo.co.in>
Cc:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Linux-2.6.18.8 compilation errors with GCC-4.2.1 and binutils-2.17
 on MIPS
References: <304090.76321.qm@web8411.mail.in.yahoo.com>
In-Reply-To: <304090.76321.qm@web8411.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2007 16:21:44.0099 (UTC) FILETIME=[CEA5F730:01C810D9]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

veerasena reddy wrote:
> Hi,
> 
> I tried to compile Linux-2.6.18.8 for MIPS24KE
> processor using cross-compiler built from gcc-4.2.1,
> binutils-2.17 and uClibc-0.9.27. But, the compilation
> failed with below error message ("mips-linux-ld: final
> link failed: Bad value"):
> ================================

The likely cause is:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33755

As indicated in the PR, Richard has a patch that he is testing.  I would 
think that by the time gcc-4.2.3 is released that it would be fixed.

I would recommend using a non-4.2.x version of gcc until the problem is 
fixed.

David Daney
