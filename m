Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 01:31:05 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:1426 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225442AbTISAbD>;
	Fri, 19 Sep 2003 01:31:03 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 18 Sep 2003 17:30:58 -0700
Message-ID: <3F6A4E41.1090100@avtrex.com>
Date: Thu, 18 Sep 2003 17:30:57 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Will ll/sc work from user space?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2003 00:30:58.0148 (UTC) FILETIME=[4B86E240:01C37E45]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Q:  Will ll/sc instructions work from a linux user process ?

If so What happens if there is a context switch between the two?

What happens if the memory location is paged out and then back into a 
different physical page?

Thanks in advance for any insight into this.

David Daney.
