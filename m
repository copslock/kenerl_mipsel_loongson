Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jan 2004 14:59:45 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:13820 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225424AbUABO7o>;
	Fri, 2 Jan 2004 14:59:44 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i02ExfQF008258
	for <linux-mips@linux-mips.org>; Fri, 2 Jan 2004 15:59:41 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id PAA13447
	for linux-mips@linux-mips.org; Fri, 2 Jan 2004 15:59:41 +0100 (MET)
Date: Fri, 2 Jan 2004 15:59:41 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: linux-mips@linux-mips.org
Subject: access_ok and CONFIG_MIPS32 for 2.6
Message-ID: <20040102145941.GA13426@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  the mask used in access_ok to check the validity of an address range
  evaluates to -TASK_SIZE for user processes. In case of
  CONFIG_MIPS32, TASK_SIZE is defined as 0x7fff8000UL, so -TASK_SIZE
  evaluates to 0x80008000, making access_ok return false for all
  addresses with bit 15 and 31 set. Surely the mask should be 0x80000000. 

  Does anybody know why TASK_SIZE is set to 0x7fff8000 and not
  0x80000000 ?


  Dimitri 


-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
