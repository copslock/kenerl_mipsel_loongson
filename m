Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 18:47:52 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:33227 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20026398AbXJDRro (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 18:47:44 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id C265630C7E0;
	Thu,  4 Oct 2007 17:47:47 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu,  4 Oct 2007 17:47:46 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 4 Oct 2007 10:47:26 -0700
Message-ID: <4705272D.7050801@avtrex.com>
Date:	Thu, 04 Oct 2007 10:47:25 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: unresoved symbol _gp_disp
References: <230962.51223.qm@web8408.mail.in.yahoo.com> <20071004173928.GA32033@real.realitydiluted.com>
In-Reply-To: <20071004173928.GA32033@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2007 17:47:26.0092 (UTC) FILETIME=[A02514C0:01C806AE]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
>> I have written a loadble module ( which gets complied
>> along with kernel) which does some floating point
>> operation.
>>  
> NO FLOATING POINT in the kernel PERIOD.

Unless you compile your code with -msoft-float *and* also have a version 
of libgcc compiled with -mlong-calls -mno-abicalls -G0.  If you do it 
that way, floating point works fine in the kernel (as long as you don't 
try to call sprintf with floating point parameters).


> Either use integer
> operations, or redo your software architecture and do the
> floating point in userspace.
> 
> -Steve
> 
