Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 17:52:25 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:9477 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225211AbTDXQwW>; Thu, 24 Apr 2003 17:52:22 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA130;
          Thu, 24 Apr 2003 09:52:14 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Jun Sun'" <jsun@mvista.com>,
	"'Steven Seeger'" <sseeger@stellartec.com>
Cc: <linux-mips@linux-mips.org>
Subject: RE: [patch] wait instruction on vr4181
Date: Thu, 24 Apr 2003 09:58:09 -0700
Message-ID: <078201c30a82$af7989b0$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030424093420.C28275@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

Oops. I guess I'm tired today. We should use "standby" for our wait
instruction.

I will make a new patch.

Steve

>-----Original Message-----
>From: Jun Sun [mailto:jsun@mvista.com]
>Sent: Thursday, April 24, 2003 9:34 AM
>To: Steven Seeger
>Cc: linux-mips@linux-mips.org; jsun@mvista.com
>Subject: Re: [patch] wait instruction on vr4181
>
>
>
>On Thu, Apr 24, 2003 at 07:10:28AM -0700, Steven Seeger wrote:
>> The VR4181 does work with the wait instruction. This is a
>patch for that.
>> (arch/mips/cpu-probe.c)
>>
>> Steve
>>
>
>The CPU mannual (v1.1 draft) I have for Vr4181 does not say
>about "wait"
>instruction.  How do you know it has "wait"?
>
>I will ask NEC for confirmation.
>
>
>Jun
>
