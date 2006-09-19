Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 18:18:58 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:61324 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038626AbWISRS4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 18:18:56 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 340B2B8115;
	Tue, 19 Sep 2006 13:18:48 -0400 (EDT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 19 Sep 2006 13:18:48 -0400 (EDT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 19 Sep 2006 10:18:46 -0700
Message-ID: <45102676.6040800@avtrex.com>
Date:	Tue, 19 Sep 2006 10:18:46 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Eric DeVolder <edevolder@razamicroelectronics.com>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers
References: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2006 17:18:46.0735 (UTC) FILETIME=[AA5B05F0:01C6DC0F]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Eric DeVolder wrote:
> Yes, it appears to me that the compiler (cc1) and assembler (as) invocations are the same. I've included the "-v" output of each below for reference. Furthermore, the -save-temps output .i files are effectively the same (differences due to cross vs. native paths, but that is it). Nonetheless, the output assembly source still contains differences!
>  
> I'm curious if anybody examined the output of a cross and native toolchain of the same (recent) version?
>  

Some of the code generation options of the compiler are set to default 
values which are controlled by options passed to the compiler's 
configure program.

Unless identical configure options are used in the native and cross 
builds, you might different default code generation options.

David Daney
