Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 04:51:43 +0000 (GMT)
Received: from nwd2mail1.analog.com ([137.71.25.50]:5781 "EHLO
	nwd2mail1.analog.com") by ftp.linux-mips.org with ESMTP
	id S8133437AbWAIEvX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 04:51:23 +0000
Received: from nwd2mhb1.analog.com (nwd2mhb1.analog.com [137.71.5.12])
	by nwd2mail1.analog.com (8.12.10/8.12.10) with ESMTP id k094sSQN008663;
	Sun, 8 Jan 2006 23:54:28 -0500
Received: from lilac.hdcindia.analog.com ([10.121.13.31])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id XAA15620;
	Sun, 8 Jan 2006 23:54:17 -0500 (EST)
Received: from SEdaraL01 ([10.121.13.96])
	by lilac.hdcindia.analog.com (8.12.10+Sun/8.12.10) with ESMTP id k094rfaZ028956;
	Mon, 9 Jan 2006 10:23:42 +0530 (IST)
Message-Id: <200601090453.k094rfaZ028956@lilac.hdcindia.analog.com>
From:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To:	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: LL and SC instruction simulation
Date:	Mon, 9 Jan 2006 10:24:14 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <43BBC85C.4040405@mips.com>
Thread-Index: AcYRL2wEZATk27YPQauJfmdzF9yApgDpTFIA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Scanned-By: MIMEDefang 2.49 on 137.71.25.50
Return-Path: <satheshbabu.edara@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: satheshbabu.edara@analog.com
Precedence: bulk
X-list: linux-mips

 
Hi,
   We have ported linux-2.4.18 and linux-2-6.12 kernel (mips.org)onto MIPS
processor (CPU type lx4189).

 We observed that on 2.4 kernel,ll and sc instruction exception handlers
hitting very often.
Where as on linux-2.6.12 this is not happening.

Can anybody have idea why this instructions are hitting on 2.4.18 kernel and
not on 2-6.12 kernel.

What is the significance of these instructions?.

Note :
   For linux-2.4.18 : We use GCC version -3.3.4 binutils version -2.15 and
uClibc version -0.9.26
For linux-2.6.12 : We use GCC version -3.4.3 binutils version -2.15 and
uClibc version -0.9.28.

Thanks in advance.

Regards,
Sathesh  
