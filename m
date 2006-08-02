Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 11:22:16 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:27954 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133417AbWHBKWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 11:22:03 +0100
Received: by nf-out-0910.google.com with SMTP id q29so603147nfc
        for <linux-mips@linux-mips.org>; Wed, 02 Aug 2006 03:22:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=XsAcJHQED6JBztLobYbYiQhfxRVFG2cDUWnh3vPU71Ub8ljJMem+A+LSqv1za06LHyip/jxQDQo0Ax5BtPlSnq1ZwAXVj5GGDujb+dgvSeMWU1XNPvUp3v80eJHyq3lmN4PPKGKUcdm78xH6V4XSIHBb43qFCeVBfUEFOZfQ7+U=
Received: by 10.49.8.10 with SMTP id l10mr2000218nfi;
        Wed, 02 Aug 2006 03:22:03 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id n23sm1333361nfc.2006.08.02.03.22.01;
        Wed, 02 Aug 2006 03:22:02 -0700 (PDT)
Message-ID: <44D07C97.2040008@innova-card.com>
Date:	Wed, 02 Aug 2006 12:21:11 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
References: <1154424439969-git-send-email-vagabon.xyz@gmail.com>	<20060802.004848.97296551.anemo@mba.ocn.ne.jp>	<cda58cb80608011238q5b0e0eacje28f921d6e1c7700@mail.gmail.com> <20060802.105126.88700874.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060802.105126.88700874.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 1 Aug 2006 21:38:18 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
>> Considering (wrongly) a nested function as a leaf one is not a big
>> issue. "ra" reg should _always_ store a valid address (nested or not).
>> The only (small) impact would be to skip an entry when showing the
>> backtrace.
> 
> The unwind_stack() uses regs->regs[31] for a leaf, and regs->regs[31]
> always holds RA value of _top_ of the stack, not at that level.
> 

does something like this on top of this patch make you feel better ?

-- >8 --

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 4ceddfa..8a9db45 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -480,7 +480,13 @@ unsigned long unwind_stack(struct task_s
 		return 0;
 
 	if (leaf)
-		pc = regs->regs[31];
+		/*
+		 * For some extreme cases, get_frame_info() can
+		 * consider wrongly a nested function as a leaf
+		 * one. In that cases avoid to return always the
+		 * same value.
+		 */
+		pc = pc != regs->regs[31] ? regs->regs[31] : 0;
 	else
 		pc = (*sp)[info.pc_offset];
 
