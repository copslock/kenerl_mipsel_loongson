Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 19:33:27 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:40409 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20026469AbXJDSdT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 19:33:19 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id DFB4D30C9D3;
	Thu,  4 Oct 2007 18:33:22 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu,  4 Oct 2007 18:33:21 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 4 Oct 2007 11:32:59 -0700
Message-ID: <470531DB.6090507@avtrex.com>
Date:	Thu, 04 Oct 2007 11:32:59 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: unresoved symbol _gp_disp
References: <230962.51223.qm@web8408.mail.in.yahoo.com> <20071004173928.GA32033@real.realitydiluted.com> <4705272D.7050801@avtrex.com> <20071004175305.GB32033@real.realitydiluted.com>
In-Reply-To: <20071004175305.GB32033@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2007 18:32:59.0539 (UTC) FILETIME=[FD67FE30:01C806B4]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
>> Unless you compile your code with -msoft-float *and* also have a version 
>> of libgcc compiled with -mlong-calls -mno-abicalls -G0.  If you do it 
>> that way, floating point works fine in the kernel (as long as you don't 
>> try to call sprintf with floating point parameters).
>>
> I won't even concede that solution. It's bad practice and design to have
> floating point in the kernel.

I agree that floating point in the kernel is bad practice.  However 
under some circumstances, the most expedient solution does not conform 
to best practice.

David Daney
