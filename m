Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2002 01:33:10 +0200 (CEST)
Received: from nwd2mime2.analog.com ([137.71.25.114]:62985 "EHLO
	nwd2mime2.analog.com") by linux-mips.org with ESMTP
	id <S1123907AbSJUXdJ>; Tue, 22 Oct 2002 01:33:09 +0200
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.10) with SMTP id <T5e14da5972894719720a5@nwd2mime2.analog.com> for <linux-mips@linux-mips.org>;
 Mon, 21 Oct 2002 19:32:59 -0400
Received: from nwd2mhb1 ([137.71.5.12]) by nwd2gtw1; Mon, 21 Oct 2002 19:32:58 -0400 (EDT)
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb1.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id TAA21677 for <linux-mips@linux-mips.org>; Mon, 21 Oct 2002 19:32:57 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id QAA04733
	for <linux-mips@linux-mips.org>; Mon, 21 Oct 2002 16:32:55 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id QAA00677
	for <linux-mips@linux-mips.org>; Mon, 21 Oct 2002 16:32:55 -0700 (PDT)
Message-ID: <3DB48EA7.D74447B4@analog.com>
Date: Mon, 21 Oct 2002 16:32:55 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Will this board run Linux?
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <justin.wojdacki@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justin.wojdacki@analog.com
Precedence: bulk
X-list: linux-mips


Okay, I just scored from work some old gear that isn't in use. One of
the things in question is a SBC based around an NEC Vr5000. The back
of the board has the labels "Smart Modular Tech" and "PCB Jupiter Rev
01". In addition to the CPU, it's got a Dallas Semiconductor RTC,
several Zilog and Altera chips, 2 COM + 1 Parallel Port, Ethernet,
SCSI, a few 72 pin SIMM sockets, and a PCI slot. The ethernet chip is
an Intel 82596DX-25. The SCSI is driven by an LSI 53C810A. 

The obvious question then is, does this board already run linux? I
haven't been able to find any documentation on it yet, so if the
answer is "No", but somebody knows about this board, I'd look into
doing the porting work.

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
