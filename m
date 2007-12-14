Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 20:24:57 +0000 (GMT)
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:29036 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28576271AbXLNUYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2007 20:24:48 +0000
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-3.cisco.com with ESMTP; 14 Dec 2007 12:23:36 -0800
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id lBEKNaAa000615
	for <linux-mips@linux-mips.org>; Fri, 14 Dec 2007 12:23:36 -0800
Received: from xbh-rtp-211.amer.cisco.com (xbh-rtp-211.cisco.com [64.102.31.102])
	by sj-core-5.cisco.com (8.12.10/8.12.6) with ESMTP id lBEKNJ1A000136
	for <linux-mips@linux-mips.org>; Fri, 14 Dec 2007 20:23:36 GMT
Received: from xmb-rtp-204.amer.cisco.com ([64.102.31.25]) by xbh-rtp-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 14 Dec 2007 15:23:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Slow transfer for loopback
Date:	Fri, 14 Dec 2007 15:23:26 -0500
Message-ID: <0590495B8B6352449CE2CE5E8AAE67F15B4588@xmb-rtp-204.amer.cisco.com>
In-Reply-To: <e6480a290706142014jedbe846g5594f2b546d88796@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow transfer for loopback
Thread-Index: Aceu+3eRgrIDbp9+SUKDz1eiP2iVCCPjFmwg
References: <e6480a290706142014jedbe846g5594f2b546d88796@mail.gmail.com>
From:	"Ratin Rahman (mratin)" <mratin@cisco.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 14 Dec 2007 20:23:28.0610 (UTC) FILETIME=[2FF83420:01C83E8F]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=432; t=1197663816; x=1198527816;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=mratin@cisco.com;
	z=From:=20=22Ratin=20Rahman=20(mratin)=22=20<mratin@cisco.co
	m>
	|Subject:=20Slow=20transfer=20for=20loopback
	|Sender:=20;
	bh=lF8M6nJTXWCnUGAsGmNVO7+hjY6HFUd0rpiYtZT2iJg=;
	b=BLKvntRLvkroHDK8oVQUmzXpJaBFhQMpvZFqFbgeRlXFljSYUbArqHPR0e
	6EHTNlG/LcOWXFayAM6rQSeXxQWkX9w5ThCNwYbSL4H12+G9vy2I5KSu3B8G
	TVaEVQ9iQ+;
Authentication-Results:	sj-dkim-2; header.From=mratin@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <mratin@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mratin@cisco.com
Precedence: bulk
X-list: linux-mips

Hello All, I am using Mipsel linux 2.6.10 kernel on IDT 79RC32H434 chip
which has integrated Ethernet MAC (100mbps). I am transfering  UDP/RTP
data (30 kbyte for an I frame, 2/3 kb for a p frame, splitted into 
1480 bytes of RTP packets) over the loopback address from one
application to another application. 
I am seeing accumulated delay in receiving the data. Anybody else
experienced similar problem? 

Ratin  
