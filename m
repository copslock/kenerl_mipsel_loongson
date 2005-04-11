Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 21:24:48 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:42955
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8226136AbVDKUYd>; Mon, 11 Apr 2005 21:24:33 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j3BKOOcH013610;
	Mon, 11 Apr 2005 13:24:24 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id j3BKOLGl000873;
	Mon, 11 Apr 2005 13:24:22 -0700 (PDT)
Message-ID: <004a01c53ed4$dab12b00$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Greg Weeks" <greg.weeks@timesys.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com>
Subject: Re: another 4kc machine check.
Date:	Mon, 11 Apr 2005 22:27:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

If the 4KC and 4KEC need it, so does the 4KSC (and 4KSD).

----- Original Message ----- 
From: "Greg Weeks" <greg.weeks@timesys.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Sent: Monday, April 11, 2005 21:47
Subject: Re: another 4kc machine check.


> This patch appears to fix my machine check problem on the 4kc. The 4kc 
> shouldn't need an ssnop here, but this appears to fix it.
> 
> Greg Weeks
> 


--------------------------------------------------------------------------------


> --- mips-malta4kcle-basic/arch/mips/mm/tlbex.c-orig
> +++ mips-malta4kcle-basic/arch/mips/mm/tlbex.c
> @@ -847,7 +847,6 @@
>  
>   case CPU_R10000:
>   case CPU_R12000:
> - case CPU_4KC:
>   case CPU_SB1:
>   case CPU_4KSC:
>   case CPU_20KC:
> @@ -874,6 +873,7 @@
>   tlbw(p);
>   break;
>  
> + case CPU_4KC:
>   case CPU_4KEC:
>   case CPU_24K:
>   i_ehb(p);
> 
