Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 07:47:16 +0000 (GMT)
Received: from nwd2mail2.analog.com ([137.71.25.51]:21405 "EHLO
	nwd2mail2.analog.com") by ftp.linux-mips.org with ESMTP
	id S8133612AbWAIHq7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 07:46:59 +0000
Received: from nwd2mhb1.analog.com (nwd2mhb1.analog.com [137.71.5.12])
	by nwd2mail2.analog.com (8.12.10/8.12.10) with ESMTP id k097o3ai018631;
	Mon, 9 Jan 2006 02:50:03 -0500
Received: from lilac.hdcindia.analog.com ([10.121.13.31])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id CAA08995;
	Mon, 9 Jan 2006 02:49:51 -0500 (EST)
Received: from SEdaraL01 ([10.121.13.96])
	by lilac.hdcindia.analog.com (8.12.10+Sun/8.12.10) with ESMTP id k097nFaZ017891;
	Mon, 9 Jan 2006 13:19:15 +0530 (IST)
Message-Id: <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com>
From:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To:	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
Subject:  LL and SC instruction simulation
Date:	Mon, 9 Jan 2006 13:19:46 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYRL2wEZATk27YPQauJfmdzF9yApgDvyQ4gAACXUrA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com>
X-Scanned-By: MIMEDefang 2.49 on 137.71.25.51
Return-Path: <satheshbabu.edara@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9809
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
