Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 12:03:28 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:47567 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225223AbULIMDX>;
	Thu, 9 Dec 2004 12:03:23 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id iB9C3HaB000171
	for <linux-mips@linux-mips.org>; Thu, 9 Dec 2004 06:03:17 -0600 (CST)
Received: from DILE2K01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id iB9C3Fwx010678
	for <linux-mips@linux-mips.org>; Thu, 9 Dec 2004 06:03:16 -0600 (CST)
Received: from [137.167.5.34] ([137.167.5.34]) by DILE2K01.ent.ti.com with Microsoft SMTPSVC(5.0.2195.6747);
	 Thu, 9 Dec 2004 14:03:15 +0200
Message-ID: <41B83F02.1060003@ti.com>
Date: Thu, 09 Dec 2004 14:03:14 +0200
From: Alexander Sirotkin <demiurg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: o32_ret_from_sys_call
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 12:03:15.0053 (UTC) FILETIME=[1019D9D0:01C4DDE7]
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

I have noticed that somewhere around 2.4.17 sys_sysmips() function from 
sysmips.c
was rewritten and call to o32_ret_from_sys_call disappear. This function 
(o32_ret_from_sys_call)
was responsible for calling do_softirq() after each system call. I'm 
curious, what is the
current mechanism in mips 2.4.x that ensures that do_softirq is called 
after system call ?

10x.

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 
