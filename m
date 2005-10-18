Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 00:36:10 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:14347
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133620AbVJRXfy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 00:35:54 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 16:35:52 -0700
Message-ID: <435586D8.4040407@avtrex.com>
Date:	Tue, 18 Oct 2005 16:35:52 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	John Levon <levon@movementarian.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018114526.GC2656@linux-mips.org> <20051018232442.GA29235@trollied.org>
In-Reply-To: <20051018232442.GA29235@trollied.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2005 23:35:52.0769 (UTC) FILETIME=[ADB9D310:01C5D43C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

John Levon wrote:
> On Tue, Oct 18, 2005 at 12:45:26PM +0100, Ralf Baechle wrote:
> 
> 
>>>+	    && defined(_MIPSEB))
>>
>>Small nit - please use __MIPSEB__ rsp. __MIPSEL__; I think there are
> 
> 
> I made it so; David, please check.
> 

I just did a cvs update and see no change.  Perhaps I misunderstand. 
Would you like me to make and test a patch?  I could...

David Daney
