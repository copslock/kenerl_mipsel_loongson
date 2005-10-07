Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 19:13:40 +0100 (BST)
Received: from ns1.pioneer-pra.com ([65.205.244.70]:19409 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by ftp.linux-mips.org with ESMTP
	id S8133575AbVJGSNR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 19:13:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail1.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id B35DB39002D;
	Fri,  7 Oct 2005 11:13:10 -0700 (PDT)
Received: from mail1.dmz.sj.pioneer-pra.com ([127.0.0.1])
 by localhost (neo1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26197-07; Fri,  7 Oct 2005 11:13:09 -0700 (PDT)
Received: from eo (unknown [65.244.224.162])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail1.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id 2F5D0390028;
	Fri,  7 Oct 2005 11:13:09 -0700 (PDT)
From:	"Mike C. Ward" <mward@pioneer-pra.com>
To:	"'David Daney'" <ddaney@avtrex.com>, <linux-mips@linux-mips.org>
Subject: RE: Where is op_model_mipsxx.c ?
Date:	Fri, 7 Oct 2005 11:13:02 -0700
Message-ID: <020b01c5cb6a$c2251830$5502020a@eo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4343525A.6080605@avtrex.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
Return-Path: <mward@pioneer-pra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mward@pioneer-pra.com
Precedence: bulk
X-list: linux-mips

I created an op_model file for the r5K core in a MIPS32 kernel.
details are at
http://oss.pioneer-pra.com/oprofile/

I have not had a chance to test it on a real 2.6 kernel yet, it
was back-ported from 2.6.11 into 2.4.25.

Mike

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of David Daney
> Sent: Tuesday, October 04, 2005 9:11 PM
> To: linux-mips@linux-mips.org
> Subject: Where is op_model_mipsxx.c ?
> 
> 
> I noticed this in the Makefile for the OProfile directory for mips:
> 
> oprofile-$(CONFIG_CPU_MIPS32_R1)                += op_model_mipsxx.o
> 
> The file op_model_mipsxx.c does not seem to exist.  Which 
> implies to me 
> that someone was working on making it work for MIPS32, but 
> didn't quite 
> finish.
> 
> I want to start hacking on OProfile for a MIPS32 based system and 
> thought it might make a nice starting point.
> 
> If the missing file exists would its author mind making it 
> available to me?
> 
> Thanks,
> David Daney
> 
> 
