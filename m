Received:  by oss.sgi.com id <S553779AbRAIKvY>;
	Tue, 9 Jan 2001 02:51:24 -0800
Received: from mx.mips.com ([206.31.31.226]:46807 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553770AbRAIKvD>;
	Tue, 9 Jan 2001 02:51:03 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA27789
	for <linux-mips@oss.sgi.com>; Tue, 9 Jan 2001 02:50:58 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA25195
	for <linux-mips@oss.sgi.com>; Tue, 9 Jan 2001 02:50:55 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id LAA17080
	for <linux-mips@oss.sgi.com>; Tue, 9 Jan 2001 11:50:21 +0100 (MET)
Message-ID: <3A5AECED.99A9C4A1@mips.com>
Date:   Tue, 09 Jan 2001 11:50:21 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: 64bit TLB refill handler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The XTLB refill handler in the 64bit code is for the R10000, is there
any reason that it shouldn't work on R4000's ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
