Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 07:58:58 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:15271 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8225393AbVIAG6k>; Thu, 1 Sep 2005 07:58:40 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id F2E48C019
	for <linux-mips@linux-mips.org>; Thu,  1 Sep 2005 09:04:45 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id EEB571BC07B
	for <linux-mips@linux-mips.org>; Thu,  1 Sep 2005 09:04:46 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.168])
	by smtp.triera.net (Postfix) with ESMTP id A2A7C1A18AD
	for <linux-mips@linux-mips.org>; Thu,  1 Sep 2005 09:04:46 +0200 (CEST)
Subject: DBAU1200 network performacne
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 01 Sep 2005 09:03:11 +0200
Message-Id: <1125558191.6063.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

I am working on DBAu1200 platform and I am testing network
performance with the smc91111 driver from AMD and smc91x
driver, which should be preferred (right?).

Tests are done on kernel 2.6.11-rc5 with the netperf,
running netserver on target and netperf on host.
If I run netserver on host and netperf on target, I get:
------------------------------------------------------------------------
recv_response: partial response received: 0 bytes

What does that mean?

OK, the results:

1) With the smc91111 I get:
------------------------------------------------------------------------
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to xxx.xxx.xxx.xxx
(xxx.xxx.xxx.xxx) port 0 AF_INET
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

 43689  16384  16384    30.02      20.95   


2) With the smc91x I get:
------------------------------------------------------------------------
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to xxx.xxx.xxx.xxx
(xxx.xxx.xxx.xxx) port 0 AF_INET
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

 43689  16384  16384    30.01      27.61   


Is this expected trough-put?
Can somebody else test it, please?

Oh, when using smc91x I get:
eth0: link down
Sending BOOTP requests .<6>eth0: link up, 100Mbps, full-duplex, lpa
0x4DE1

So, link should be 100Mbps.

BR,
Matej
