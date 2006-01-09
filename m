Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 05:17:10 +0000 (GMT)
Received: from nwd2mail2.analog.com ([137.71.25.51]:57228 "EHLO
	nwd2mail2.analog.com") by ftp.linux-mips.org with ESMTP
	id S8134493AbWAIFQw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 05:16:52 +0000
Received: from nwd2mhb1.analog.com (nwd2mhb1.analog.com [137.71.5.12])
	by nwd2mail2.analog.com (8.12.10/8.12.10) with ESMTP id k095Jtai002350;
	Mon, 9 Jan 2006 00:19:55 -0500
Received: from lilac.hdcindia.analog.com ([10.121.13.31])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id AAA20923;
	Mon, 9 Jan 2006 00:19:46 -0500 (EST)
Received: from SEdaraL01 ([10.121.13.96])
	by lilac.hdcindia.analog.com (8.12.10+Sun/8.12.10) with ESMTP id k095JAaZ000965;
	Mon, 9 Jan 2006 10:49:10 +0530 (IST)
Message-Id: <200601090519.k095JAaZ000965@lilac.hdcindia.analog.com>
From:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To:	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
Subject:  LL and SC instruction simulation
Date:	Mon, 9 Jan 2006 10:49:44 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: 
Thread-Index: AcYRL2wEZATk27YPQauJfmdzF9yApgDpTFIAAAHm3mA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Scanned-By: MIMEDefang 2.49 on 137.71.25.51
Return-Path: <satheshbabu.edara@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9806
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
uClibc version -0.9.26 For linux-2.6.12 : We use GCC version -3.4.3 binutils
version -2.15 and uClibc version -0.9.28.

Thanks in advance.

Regards,
Sathesh  
