Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 02:56:20 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:11510 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225461AbTJ2C4R>;
	Wed, 29 Oct 2003 02:56:17 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 28 Oct 2003 18:56:14 -0800
Message-ID: <3F9F2C4E.70302@avtrex.com>
Date: Tue, 28 Oct 2003 18:56:14 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: linux-mips@linux-mips.org, gdb@sources.redhat.com
Subject: Re: Help needed WRT GDB and multithreaded programs.
References: <3F9EFFDF.7070205@avtrex.com> <20031029.113746.108765170.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20031029.113746.108765170.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2003 02:56:14.0202 (UTC) FILETIME=[37392DA0:01C39DC8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

>>>>>>On Tue, 28 Oct 2003 15:46:39 -0800, David Daney <ddaney@avtrex.com> said:
>>>>>>            
>>>>>>
>ddaney> When using GDB 5.3 I get strange errors and am basically not
>ddaney> able to debug multi-threaded programs.  For example any java
>ddaney> program compiled with GCC/GCJ runs in multiple threads and
>ddaney> does something like this:
>
>Maybe these will help you:
>
>http://www.linux-mips.org/archives/linux-mips/2002-09/msg00127.html
>http://lists.debian.org/debian-mips/2003/debian-mips-200303/msg00116.html
>
>---
>Atsushi Nemoto
>  
>
Hey, thanks a lot!

That was the problem.

David Daney.
