Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 14:58:02 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:12495 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133762AbWC2N5y
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 14:57:54 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2TE8Ia4021044;
	Wed, 29 Mar 2006 06:08:18 -0800 (PST)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k2TE8IUd017353;
	Wed, 29 Mar 2006 06:08:18 -0800 (PST)
Received: from alg-test22.mips.com ([192.168.192.22] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FObLJ-0000y9-00; Wed, 29 Mar 2006 15:08:13 +0100
Message-ID: <442A94D0.1020106@mips.com>
Date:	Wed, 29 Mar 2006 15:08:16 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: Using hardware watchpoint for applications debugging
References: <024c01c65337$63931c90$106215ac@realtek.com.tw>
In-Reply-To: <024c01c65337$63931c90$106215ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



colin wrote:.
>     2. When an exception happens and we find that it's not touching the righ
> address, we will discard it. However, exception will happen again because
> the former instruction will be re-executed when the exception is finished.
>
>   

You'll need to single-step over the instruction which generated the
unwanted watchpoint exception, with the watchpoint disabled. Then after
handling the single step reenable the watchpoint and resume normal
execution.

It would be best if you added watchpoint support to the kernel ptrace
code: since that would make the watchpoints usable by GDB also.

Nigel
