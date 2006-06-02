Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 14:58:16 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:15820 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133814AbWFBM6H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2006 14:58:07 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id EC41212A002C;
	Fri,  2 Jun 2006 19:58:04 +0700 (NOVST)
Date:	Fri, 2 Jun 2006 19:58:08 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <2832.060602@sigrand.ru>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re[4]: Problem with TLB mcheck!
In-reply-To: <Pine.LNX.4.64N.0606021324420.23118@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0606021324420.23118@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello Maciej,

Friday, June 02, 2006, 7:27:18 PM, you wrote:

MWR> Hello Art,

>> I was inattentive - you told about not my patch! Now I'am no use this!
>> So DON'T tell me more about this :), sorry for my mistake.
>> 
>> And about latest kernel version:
>> 1. I think this problem is in memory management subsystem (am I
>>    right?)
>> 2. If 1 is right - then now I have latest memory management sybsystem,
>> because I apply all TLB-related patches (only one Ralfs really).

MWR>  Wait, wait!  Please start from the beginning: if you try the kernel as of 
MWR> the top of the tree at www.linux-mips.org, then can you still trigger the 
MWR> machine check or does the kernel work fine?  If the former, then please 
MWR> send the dump of state produced.

MWR>   Maciej

Yes machine check was still occuring with latest kernel (2.6.16 with
patched mm subsystem - how I sed - I've searched gitweb to find all
changes from 20 March (when 2.6.16 was released)).
Then I start watching tlbex.c, because patch which was recomended (but
irrelevant as you say - and you were wright!) make mcheck occuring not
so often. So I make second changes :

--- /home/artpol/router/buildroot/kernels/linux-2.6.16-old/arch/mips/mm/tlbex.c 2006-03-20 11:35:39.000000000 +0000
+++ tlbex.c     2006-05-31 16:57:58.000000000 +0000
@@ -838,6 +838,7 @@
                break;

        case CPU_R4300:
+       case CPU_4KC:
        case CPU_5KC:
        case CPU_TX49XX:
        case CPU_AU1000:
@@ -852,13 +853,12 @@

        case CPU_R10000:
        case CPU_R12000:
-       case CPU_4KC:
        case CPU_SB1:
        case CPU_SB1A:
        case CPU_4KSC:
        case CPU_20KC:
        case CPU_25KF:
-               tlbw(p);
+               tlbw(p);
                break;

        case CPU_NEVADA:
@@ -1260,7 +1260,7 @@
}

Till that I have no machine check at all!

-- 
Best regards,
 art                            mailto:art@sigrand.ru
