Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 20:53:09 +0100 (BST)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:15824 "EHLO
	smtp.voda.cz") by linux-mips.org with ESMTP id <S8224902AbVDGTwy>;
	Thu, 7 Apr 2005 20:52:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by smtp.voda.cz (Postfix) with ESMTP id 655C51380B;
	Thu,  7 Apr 2005 21:52:44 +0200 (CEST)
Received: from smtp.voda.cz ([127.0.0.1])
 by localhost (gw [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09982-01; Thu,  7 Apr 2005 21:52:29 +0200 (CEST)
Received: from [10.1.1.77] (unknown [10.1.1.77])
	by smtp.voda.cz (Postfix) with ESMTP id DDECC14729;
	Thu,  7 Apr 2005 21:52:24 +0200 (CEST)
Message-ID: <42558F78.7060407@voda.cz>
Date:	Thu, 07 Apr 2005 21:52:24 +0200
From:	=?ISO-8859-1?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Pratik Patel <pratikgpatel@gmail.com>, linux-mips@linux-mips.org
Subject: Re: need libpcap.a for mipsel platform
References: <fda764b0504071230516cde06@mail.gmail.com> <20050407194109.GA27344@linux-mips.org>
In-Reply-To: <20050407194109.GA27344@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> <>On Thu, Apr 07, 2005 at 12:30:26PM -0700, Pratik Patel wrote:
>
>
> If anyone has the pre-compiled libpcap.a file for MIPSEL platform,
> please mail it to me.
>
>
>I suggest you get that from your favorite Linux distribution.
>
>As a guess on a small system like the WRT54G you're using uclibc and I'd
>expect some problem when building libpcap against uclibc.
>
>  Ralf
>  
>
AFAIK there is no major problem with compiling recent libpcap using 
uclibc for the mipsel platform. Just get you favorite cross-compiler, 
sources and you're done...

       Tom

-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
