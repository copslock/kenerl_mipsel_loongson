Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 00:42:14 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:31628 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8126965AbWGaXmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2006 00:42:00 +0100
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-6.cisco.com with ESMTP; 31 Jul 2006 16:41:52 -0700
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11.20060308/8.12.11) with ESMTP id k6VNfp2A015217
	for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 16:41:51 -0700
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k6VNfp2D001857
	for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 16:41:51 -0700 (PDT)
Received: from xmb-sjc-237.amer.cisco.com ([128.107.191.123]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 31 Jul 2006 16:41:50 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: gdb
Date:	Mon, 31 Jul 2006 16:41:50 -0700
Message-ID: <27801B4D04E7CA45825B0E0CE60FE10A023EE440@xmb-sjc-237.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gdb
thread-index: Aca0LvH2tOHteam8RhSZFHORKmWgVwAy4dmg
From:	"Ratin Rahman \(mratin\)" <mratin@cisco.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 31 Jul 2006 23:41:50.0929 (UTC) FILETIME=[E5593410:01C6B4FA]
DKIM-Signature:	a=rsa-sha1; q=dns; l=151; t=1154389311; x=1155253311;
	c=relaxed/simple; s=sjdkim3002; h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=mratin@cisco.com; z=From:=22Ratin=20Rahman=20\(mratin\)=22=20<mratin@cisco.com>
	|Subject:gdb;
	X=v=3Dcisco.com=3B=20h=3DT4qBgmrSGp6447ZE6xNr+sPSHMU=3D; b=G0OvayJ0MKQ3/B8YQvo27eDAsqQC8MPBoySugAlCwDrtSwG8h8PGvxgYWK+x1SN7Hr0Jt3oZ
	gLd6Uil5thvoH1L4lFsc9k5MrWw/GapT6KRD1J2AFtEhhlgseL6YwT8X;
Authentication-Results:	sj-dkim-3.cisco.com; header.From=mratin@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Return-Path: <mratin@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mratin@cisco.com
Precedence: bulk
X-list: linux-mips

Anybody use gdb with mipsel? Is there something I need to know how to
compile gdb for mipsel
before I get my hands dirty with it :)

Ratin Rahman
