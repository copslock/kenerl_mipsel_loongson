Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 10:23:12 +0100 (BST)
Received: from p549F5CB2.dip.t-dialin.net ([84.159.92.178]:63403 "EHLO
	p549F5CB2.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133598AbVJZJWv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 10:22:51 +0100
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:20399 "HELO
	deliver-1.mx.triera.net") by linux-mips.net with SMTP
	id <S872529AbVJZGfQ>; Wed, 26 Oct 2005 08:35:16 +0200
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id C289EC071;
	Wed, 26 Oct 2005 08:35:10 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 558791BC094;
	Wed, 26 Oct 2005 08:35:11 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id C586D1A18AC;
	Wed, 26 Oct 2005 08:35:10 +0200 (CEST)
Subject: Re: Where is op_model_mipsxx.c ?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <435E48CB.6040607@avtrex.com>
References: <4343525A.6080605@avtrex.com>
	 <20051005104437.GG2699@linux-mips.org>
	 <1130239559.25742.19.camel@localhost.localdomain>
	 <435E48CB.6040607@avtrex.com>
Content-Type: multipart/mixed; boundary="=-0LGbkFfgz1/AX9sRmAE9"
Date:	Wed, 26 Oct 2005 08:35:02 +0200
Message-Id: <1130308502.4656.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-0LGbkFfgz1/AX9sRmAE9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

> If there are no performance counters, OProfile can still use the system 
> timer to take samples each clock tick.  This is the way I am using it.

Thanks for the info.

> To use it in this manner you have to hack up the code a bit so that the 
> return value of oprofile_arch_init() (in oprofile/common.c) is -ENODEV.

I'll try that and let you know the results.

I want to use the profiler, because the network performance of dbau1200
is very poor (with 2.6.14-rc2 and smc91x driver I get around 12Mbit/s!).

I check the traffic of netperf with ethereal and I see quite a lot
of duplicated packets (see the attached file with a few packets).
I think think this is also the reason that NFS is so slow.

BR,
Matej



--=-0LGbkFfgz1/AX9sRmAE9
Content-Disposition: attachment; filename=netperf_dump.txt
Content-Type: text/plain; name=netperf_dump.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

No.     Time        Source                Destination           Protocol Info
     50 5.759336    172.18.1.53           172.18.1.57           TCP      37994 > 32772 [ACK] Seq=28961 Ack=1 Win=5840 Len=1448 TSV=111254184 TSER=2217426
     51 5.759342    172.18.1.53           172.18.1.57           TCP      37994 > 32772 [ACK] Seq=30409 Ack=1 Win=5840 Len=1448 TSV=111254184 TSER=2217426
     52 5.761884    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#1] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217427 TSER=111254176 SLE=17377 SRE=18825
     53 5.761894    172.18.1.53           172.18.1.57           TCP      37994 > 32772 [ACK] Seq=31857 Ack=1 Win=5840 Len=1448 TSV=111254186 TSER=2217427
     54 5.762052    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#2] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217429 TSER=111254176 SLE=17377 SRE=20273
     55 5.762063    172.18.1.53           172.18.1.57           TCP      [TCP Retransmission] 37994 > 32772 [ACK] Seq=14481 Ack=1 Win=5840 Len=1448 TSV=111254186 TSER=2217429
     56 5.762214    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#3] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217429 TSER=111254176 SLE=17377 SRE=21721
     57 5.762223    172.18.1.53           172.18.1.57           TCP      [TCP Retransmission] 37994 > 32772 [ACK] Seq=15929 Ack=1 Win=5840 Len=1448 TSV=111254187 TSER=2217429
     58 5.764745    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#4] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217432 TSER=111254176 SLE=17377 SRE=23169
     59 5.764754    172.18.1.53           172.18.1.57           TCP      37994 > 32772 [ACK] Seq=33305 Ack=1 Win=5840 Len=1448 TSV=111254189 TSER=2217432
     60 5.764911    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#5] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217432 TSER=111254176 SLE=26065 SRE=27513 SLE=17377 SRE=23169
     61 5.765074    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#6] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217432 TSER=111254176 SLE=26065 SRE=28961 SLE=17377 SRE=23169
     62 5.765083    172.18.1.53           172.18.1.57           TCP      [TCP Retransmission] 37994 > 32772 [PSH, ACK] Seq=23169 Ack=1 Win=5840 Len=1448 TSV=111254189 TSER=2217432
     63 5.766842    172.18.1.57           172.18.1.53           TCP      [TCP Dup ACK 49#7] 32772 > 37994 [ACK] Seq=1 Ack=14481 Win=34752 Len=0 TSV=2217434 TSER=111254176 SLE=26065 SRE=30409 SLE=17377 SRE=23169

--=-0LGbkFfgz1/AX9sRmAE9--
