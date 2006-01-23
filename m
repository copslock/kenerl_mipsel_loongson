Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:01:35 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:37813 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S3465584AbWAWQAJ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 16:00:09 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0NG4DHH001352;
	Mon, 23 Jan 2006 08:04:13 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0NG45Yr003083;
	Mon, 23 Jan 2006 08:04:06 -0800 (PST)
Received: from [172.20.192.98] (helo=[172.20.192.98])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F14An-0001md-00; Mon, 23 Jan 2006 16:04:05 +0000
Message-ID: <43D4FE75.8060709@mips.com>
Date:	Mon, 23 Jan 2006 16:04:05 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kurt Schwemmer <kurts@vitesse.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	sde@mips.com
Subject: Re: Build errors
References: <1137793865.15788.26.camel@lx-kurts>	 <20060122030341.GB11131@linux-mips.org>  <43D4F1E0.1050602@mips.com> <1138031829.6572.2.camel@lx-kurts>
In-Reply-To: <1138031829.6572.2.camel@lx-kurts>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.824,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Kurt Schwemmer wrote:

>
>arch/mips/lib/uncached.c: In function `run_uncached':
>arch/mips/lib/uncached.c:47: warning: comparison is always true due to
>limited range of data type
>
>Is that normal?
>  
>

I'll let a kernel expert answer that.

>Anyway, is there a particular person who maintains the wiki
>( http://www.linux-mips.org/wiki/MIPS_SDE_Installation ) or should I
>give it a shot? 
>
>  
>

Usually me, thanks for reminding me :)

Nigel
