Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 08:59:57 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:52629 "HELO krt.neobee.net")
	by ftp.linux-mips.org with SMTP id S20021350AbXCFI7x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 08:59:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (Postfix) with ESMTP id E19C7278040
	for <linux-mips@linux-mips.org>; Tue,  6 Mar 2007 09:59:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at krt.neobee.net
Received: from krt.neobee.net ([127.0.0.1])
	by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hNFLOumUtyZn for <linux-mips@linux-mips.org>;
	Tue,  6 Mar 2007 09:59:22 +0100 (CET)
Received: from had (unknown [192.168.193.90])
	by krt.neobee.net (Postfix) with ESMTP id CAE52278031
	for <linux-mips@linux-mips.org>; Tue,  6 Mar 2007 09:59:21 +0100 (CET)
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
References: <20070305162826.GC786@linux-mips.org>
In-Reply-To: <20070305162826.GC786@linux-mips.org>
Subject: RE: Encrypt user file system
Date:	Tue, 6 Mar 2007 10:02:13 +0100
Message-ID: <023501c75fce$21c37db0$654a7910$@Davidovic@micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcdfQ6udbicM6h1fR36sutkqSTaAdAAiRUJw
Content-Language: sr
x-cr-hashedpuzzle: ASXg Axsp C2ol DPT5 DRKr E08S FM9F FlPs GAii GPAt GQqv G68Y HeOJ H/1w IVER IiXz;1;bABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA=;Sosha1_v1;7;{2D5F0227-1C15-44F8-95FF-AE49686C1945};bQBpAGwAZQAuAGQAYQB2AGkAZABvAHYAaQBjAEAAbQBpAGMAcgBvAG4AYQBzAG4AaQB0AC4AYwBvAG0A;Tue, 06 Mar 2007 09:02:06 GMT;UgBFADoAIABFAG4AYwByAHkAcAB0ACAAdQBzAGUAcgAgAGYAaQBsAGUAIABzAHkAcwB0AGUAbQA=
x-cr-puzzleid: {2D5F0227-1C15-44F8-95FF-AE49686C1945}
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Thanks a lot, it make sense. But my question is not precise, 
I am wonder if MTD block device could be encrypted with dm-crypt.
But this is questions for MTD mailing list.

Best regards Mile


But if I want to crypt MTD device 
> 
> > What is mips way for encrypting user file system?
> > On intel we can use combination dm-crypt and we could crypt complete user
> FS I
> > suppose that should work on MIPS too?
> 
> Yes, of course.
> 
>   Ralf
