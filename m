Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 13:48:24 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:46251 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S8133570AbVJGMsI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 13:48:08 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.12.11) with ESMTP id j97Cm62L004920
	for <linux-mips@linux-mips.org>; Fri, 7 Oct 2005 16:48:07 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id j97Cm6I9004916
	for linux-mips@linux-mips.org; Fri, 7 Oct 2005 16:48:06 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id j97Cl03t008378;
	Fri, 7 Oct 2005 16:47:00 +0400
Message-ID: <43466DCB.7070103@niisi.msk.ru>
Date:	Fri, 07 Oct 2005 16:44:59 +0400
From:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
CC:	linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
References: <43455D2D.1010901@niisi.msk.ru>
In-Reply-To: <43455D2D.1010901@niisi.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hello,

> 4. I know there should be yet another way.

The way is to load a saved register in the delay slot of jalr. The saved 
register shall not be s0, of course, because it's saved by the first 
instruction in save_static_function. So the proposed patch is

arch/mips/kernel/scall32-o32.S:

syscall_trace_entry:
         SAVE_STATIC
-	move	s0, t2
+	move	s1, t2
         move    a0, sp
         li      a1, 0
         jal     do_syscall_trace

         lw      a0, PT_R4(sp)           # Restore argument registers
         lw      a1, PT_R5(sp)
         lw      a2, PT_R6(sp)
         lw      a3, PT_R7(sp)
-        jalr	s0
+	.set push
+	.set noreorder
+	jalr	s1
+	 lw	s1, PT_R17(sp)
+	.set pop

The rest of ABIs shall be implemented in the same way.

Regards,
Gleb.
