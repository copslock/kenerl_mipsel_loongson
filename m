Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2008 05:47:54 +0100 (BST)
Received: from smtp167.iad.emailsrvr.com ([207.97.245.167]:51162 "EHLO
	smtp167.iad.emailsrvr.com") by ftp.linux-mips.org with ESMTP
	id S20679958AbYJFErs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Oct 2008 05:47:48 +0100
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 8A9B1797AB2;
	Mon,  6 Oct 2008 00:47:36 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: vitpl.adm-AT-vaultinfo.com) with ESMTP id 316AE797211;
	Mon,  6 Oct 2008 00:47:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by vaultgate.VAULTNET (Postfix) with ESMTP id 754E67DC003;
	Mon,  6 Oct 2008 10:17:33 +0530 (IST)
X-Virus-Scanned: by Endian Firewall
Received: from [192.168.2.144] (unknown [192.168.2.144])
	by vaultgate.VAULTNET (Postfix) with ESMTP id BBBB97DC002;
	Mon,  6 Oct 2008 10:17:32 +0530 (IST)
Subject: mips : how to make java binary to run on the board
From:	Abhiruchi Gupta <abhiruchi.g@vaultinfo.com>
To:	kernel-testers <kernel-testers@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: VITPL
Date:	Mon, 06 Oct 2008 10:17:29 +0530
Message-Id: <1223268449.5895.7.camel@abhiruchi>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

Hi,

I built kernel 2.6 and ext2 file system for PB1200 board.
X server is also there.
>From sun java, I downloaded java run time for mips.


But I am getting Headless Exception. 

if the output is simple to print a message , its working.

What to do?



Thanks,
Abhi
