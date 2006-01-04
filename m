Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 12:48:41 +0000 (GMT)
Received: from nwd2mail3.analog.com ([137.71.25.52]:39598 "EHLO
	nwd2mail3.analog.com") by ftp.linux-mips.org with ESMTP
	id S8133488AbWADMsX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 12:48:23 +0000
Received: from nwd2mhb2.analog.com (nwd2mhb2.analog.com [137.71.6.12])
	by nwd2mail3.analog.com (8.12.10/8.12.10) with ESMTP id k04CoxHU017592;
	Wed, 4 Jan 2006 07:50:59 -0500
Received: from lilac.hdcindia.analog.com ([10.121.13.31])
	by nwd2mhb2.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id HAA15593;
	Wed, 4 Jan 2006 07:50:51 -0500 (EST)
Received: from SEdaraL01 ([10.121.13.96])
	by lilac.hdcindia.analog.com (8.12.10+Sun/8.12.10) with ESMTP id k04CoGaZ025481;
	Wed, 4 Jan 2006 18:20:17 +0530 (IST)
Message-Id: <200601041250.k04CoGaZ025481@lilac.hdcindia.analog.com>
From:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To:	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: 
Date:	Wed, 4 Jan 2006 18:20:45 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <1136324722.12175.20.camel@orionlinux.starfleet.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcYQpiusjPo1a8yfR1inJpoGQLVGMgAgcRZA
X-Scanned-By: MIMEDefang 2.49 on 137.71.25.52
Return-Path: <satheshbabu.edara@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: satheshbabu.edara@analog.com
Precedence: bulk
X-list: linux-mips

 

Hi,
   We have ported linux-2.6.12 kernel onto MIPS processor (LX4189) and the
processor speed is 200Mhz.
By default Linux-2.6.12 kernel comes with HZ value 1000.Will this HZ value
cause an overhead on the 200MHZ CPU.Can someone advise me on whether going
back to HZ vaule of 100 like Linux-2.4 will reduce the overhead on this
CPU.What are the side effects this change can cause?.

Regards,
Sathesh 
