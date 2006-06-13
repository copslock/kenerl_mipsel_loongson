Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 23:58:06 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:163 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133835AbWFMW55
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jun 2006 23:57:57 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k5DMvWNr011609;
	Tue, 13 Jun 2006 15:57:33 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k5DMvX4p027741;
	Tue, 13 Jun 2006 15:57:33 -0700 (PDT)
Received: from bank.mips.com ([192.168.192.132] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FqHpA-0000el-00; Tue, 13 Jun 2006 23:57:28 +0100
Message-ID: <448F42D7.5060401@mips.com>
Date:	Tue, 13 Jun 2006 23:57:27 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies Inc
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	Prasad Boddupalli <bprasad@cs.arizona.edu>
CC:	Jonathan Day <imipak@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: Performance counters and profiling on MIPS
References: <20060612225848.GA7163@linux-mips.org>	 <20060613212743.64709.qmail@web31506.mail.mud.yahoo.com> <e8180c7f0606131444g2b9f1703s2ef21f1ff1fb0880@mail.gmail.com>
In-Reply-To: <e8180c7f0606131444g2b9f1703s2ef21f1ff1fb0880@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Prasad Boddupalli wrote:
> Perfctr (http://user.it.uu.se/~mikpe/linux/perfctr/) and PAPI
> (http://icl.cs.utk.edu/papi/) are precisely such attempts. Except that
> MIPS ports of them do not seem to be available.

There's also perfmon2, for which a MIPS patch is available - though no 
idea how up-to-date it is. See http://www.linux-mips.org/wiki/Perfmon2

Nigel
