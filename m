Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 00:44:45 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:57997 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20024603AbXITXog (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 00:44:36 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 9C277309DD4;
	Thu, 20 Sep 2007 23:44:47 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 20 Sep 2007 23:44:47 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Sep 2007 16:44:28 -0700
Message-ID: <46F305DC.7080106@avtrex.com>
Date:	Thu, 20 Sep 2007 16:44:28 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Winson Yung <winson.yung@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS assembly question
References: <48413e3e0709201614pd8fc58dga6354d5d2330f288@mail.gmail.com>
In-Reply-To: <48413e3e0709201614pd8fc58dga6354d5d2330f288@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2007 23:44:28.0955 (UTC) FILETIME=[2F620EB0:01C7FBE0]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Winson Yung wrote:
> Hi there, I have some general mips inline assembly question regards to
> 32 bit atomic operation, here a section of its assembly
> implementation:
> 
>                 "       .set    mips3                                   \n"
>                 "1:     ll      %0, %2                  # __cmpxchg_u32 \n"
>                 "       bne     %0, %z3, 2f                             \n"
>                 "       .set    mips0                                   \n"
>                 "       move    $1, %z4                                 \n"
>                 "       .set    mips3                                   \n"
>                 "       sc      $1, %1                                  \n"
>                 "       beqzl   $1, 1b                                  \n"
> 
> Questions:
> 
> 1) what does 'z' mean in the line of 'bne %0, %z3, 2f'?

I think this 'z' comes from print_operand() in gcc/config/mips/mips.c in 
  GCC:

    'z'	if the operand is 0, use $0 instead of normal operand.

This is an optimization so that if you are comparing against the value 
of zero, you can use $0 instead of loading up another register with the 
value of zero first.

> 2) Is $1 suppose to be use as an constant 1, I don't understand the
> line 'sc  $1, %1'

$1 is register 1.  AKA $at.

So that line is Store Conditional Word from register 1 into the memory 
location indicated by operand 1.

> 
> Will appreciate if someone can point out to me a good tutorial on
> explaining these little things.
> 

If it is not in the GCC documentation, then you have to look at the GCC 
source code.  I don't know of any better way.

David Daney
