Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 18:04:13 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:45579
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133546AbVJURDj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 18:03:39 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Oct 2005 10:03:37 -0700
Message-ID: <43591F69.60203@avtrex.com>
Date:	Fri, 21 Oct 2005 10:03:37 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 10/11 Xilleon IDE controller support
References: <17239.48184.340986.463557@dl2.hq2.avtrex.com> <58cb370e0510210858k7fccc00fqd6fccffed441aae3@mail.gmail.com>
In-Reply-To: <58cb370e0510210858k7fccc00fqd6fccffed441aae3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 17:03:37.0946 (UTC) FILETIME=[611E13A0:01C5D661]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Patch basically looks fine but needs some extra work.
> Detailed comments below...
> 
> On 10/20/05, David Daney <ddaney@avtrex.com> wrote:
> 
>>This is the tenth part of my Xilleon port.
>>
>>I am sending the full set of patches to linux-mips@linux-mips.org
>>which is archived at: http://www.linux-mips.org/archives/
>>
>>Only the patches that touch generic parts of the kernel are coming
>>here.
>>
>>This patch adds the Xilleon's IDE driver.
>>
>>Patch against 2.6.14-rc2 from linux-mips.org
>>
>>Signed-off-by: David Daney <ddaney@avtrex.com>
>>

Thanks for reviewing this.  I am working on addressing the issues you 
raised.

David Daney.
