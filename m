Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 18:15:04 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:34105
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225302AbUAFSPA>; Tue, 6 Jan 2004 18:15:00 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AdvjE-00026I-00; Tue, 06 Jan 2004 19:14:56 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AdvjE-0003cb-00; Tue, 06 Jan 2004 19:14:56 +0100
Date: Tue, 6 Jan 2004 19:14:56 +0100
To: =?iso-8859-1?Q?J=F6?= Fahlke <jorrit@jorrit.de>
Cc: Linux on Mips Mailinglist <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Assembler error in arch/mips/kernel/entry.S
Message-ID: <20040106181456.GH13721@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040106163925.GA7342@fsk.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040106163925.GA7342@fsk.uni-heidelberg.de>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Jö Fahlke wrote:
[snip]
> ======================================================================
>         beqz    restore_all
>         if (in_exception_path)
>                 goto restore_all;
>         li      t0, PREEMPT_ACTIVE
> ======================================================================
> 
> Can someone please fix this?  My very limitet assembler knowledge
> gives me an idea whats wrong, but I don't know how to fix it.

The appended guesswork may help.


Thiemo


Index: entry.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/entry.S,v
retrieving revision 1.58
diff -u -p -r1.58 entry.S
--- entry.S     30 Oct 2003 01:50:28 -0000      1.58
+++ entry.S     6 Jan 2004 18:11:23 -0000
@@ -52,9 +52,7 @@ ENTRY(resume_kernel)
 need_resched:
        LONG_L  t0, TI_FLAGS($28)
        andi    t1, t0, _TIF_NEED_RESCHED
-       beqz    restore_all
-       if (in_exception_path)
-               goto restore_all;
+       beqz    t1, restore_all
        li      t0, PREEMPT_ACTIVE
        sw      t0, TI_PRE_COUNT($28)
        local_irq_enable t0
