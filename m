Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 13:46:48 +0000 (GMT)
Received: from t111.niisi.ras.ru ([IPv6:::ffff:193.232.173.111]:42708 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225251AbVBANqd>; Tue, 1 Feb 2005 13:46:33 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.12.11/8.12.11) with ESMTP id j11DfP9w000976
	for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 16:41:25 +0300
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id j11Dh8UN003442
	for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 16:43:08 +0300
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id j11Dh7Sx003440
	for linux-mips@linux-mips.org; Tue, 1 Feb 2005 16:43:07 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id j11DjKkM017309
	for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 16:45:21 +0300
Message-ID: <41FF876B.3070407@niisi.msk.ru>
Date:	Tue, 01 Feb 2005 16:43:07 +0300
From:	andreev <andreev@niisi.msk.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041004
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Strace doesn't work on linux-2.4.28 and later
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Tue, 01 Feb 2005 16:45:21 +0300
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <andreev@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreev@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hi, list.

We are using the latest kernel from mips-linux CVS and there is a 
problem with ptrace.

When syscall with 5 or more arguments are traced, the fifth argument of 
the syscall is overwritten
by tracing code. This error causes problems with strace. For example, 
you can't trace dynamically linked
applications, because ld.so calls mmap which has 6 arguments.
