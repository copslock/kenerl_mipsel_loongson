Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 14:49:10 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:43496 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225228AbTL3OtH>;
	Tue, 30 Dec 2003 14:49:07 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBUEn4QF007485
	for <linux-mips@linux-mips.org>; Tue, 30 Dec 2003 15:49:04 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id PAA10378
	for linux-mips@linux-mips.org; Tue, 30 Dec 2003 15:49:04 +0100 (MET)
Date: Tue, 30 Dec 2003 15:49:04 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: linux-mips@linux-mips.org
Subject: supported systems running on 2.6 ?
Message-ID: <20031230144904.GA10358@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

Hi,

  are there already MIPS systems running on 2.6.0 ? If so, which ones
  ? I'm currently porting a VR41xx based configuration from 2.4.24 to
  2.6.0: boot sequence seems to be OK, but the init process doesn't
  come up (it looks like its not properly laid out in memory, thus
  continuously generating exceptions (do_signal()) ...). Is it too
  soon to expect it to work ?

  Dimitri

-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
