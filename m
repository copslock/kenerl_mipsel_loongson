Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 13:42:56 +0000 (GMT)
Received: from masquerade.micron.com ([IPv6:::ffff:137.201.242.130]:56329 "EHLO
	mail-srv1.micron.com") by linux-mips.org with ESMTP
	id <S8225201AbTBUNm4>; Fri, 21 Feb 2003 13:42:56 +0000
Received: from mail-srv1.micron.com (localhost [127.0.0.1])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1LDglhP000581
	for <linux-mips@linux-mips.org>; Fri, 21 Feb 2003 06:42:48 -0700 (MST)
Received: from ntexchangehub.micron.com (ntexchangehub.micron.com [137.201.16.84])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1LDgk4l000576;
	Fri, 21 Feb 2003 06:42:47 -0700 (MST)
Received: by ntexchangehub.micron.com with Internet Mail Service (5.5.2653.19)
	id <FLCLFYBN>; Fri, 21 Feb 2003 06:42:45 -0700
Message-ID: <DD4AFB45E2CCD211B6EE0008C7333BCF02FE6FC4@ntxmel01.micron.com>
From: ncrook <ncrook@micron.com>
To: "'Ashish anand'" <ashish.anand@inspiretech.com>,
	linux-mips@linux-mips.org
Subject: RE: wired tlb entries and global bit..
Date: Fri, 21 Feb 2003 06:42:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ncrook@micron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncrook@micron.com
Precedence: bulk
X-list: linux-mips

>>A small question..
>>
>>1.my understanding of wired tlb entries mean set of address translations
>>that i always want to be present throughout the system is on ,
>>irrespective of asid's/tlb flush , examplesake pci io/mem window ...is
>>this right?
>>
>>2.can i acheive the same by using the global bit from entrylo0 and
>>entrylo1.
>>
>>Best Regards,
>>Ashish Anand

A wired entry can EITHER be irrespective of ASID (if the G bit for the entry
is set) OR can take the current ASID into account (if the G bit for the entry
is clear) -- using wired TLB entries to map things like PCI io/mem window is
an example of a translation that would be fixed regardless of the process and
therefore you would want to set the G bit (which would make the ASID field
"don't care")

Neal.
