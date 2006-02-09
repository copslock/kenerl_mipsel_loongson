Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 09:56:20 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:59778 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133437AbWBIJ4K
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Feb 2006 09:56:10 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k19A1mfA014582;
	Thu, 9 Feb 2006 02:01:53 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k19A1l89023000;
	Thu, 9 Feb 2006 02:01:47 -0800 (PST)
Received: from olympia.mips.com ([192.168.192.128] helo=[127.0.0.1])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F78cM-0004Ru-00; Thu, 09 Feb 2006 10:01:38 +0000
Message-ID: <43EB1302.9090907@mips.com>
Date:	Thu, 09 Feb 2006 10:01:38 +0000
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to use sde toolchain to compile a hello world?
References: <50c9a2250602082235k1add529ctff120d0184425048@mail.gmail.com>
In-Reply-To: <50c9a2250602082235k1add529ctff120d0184425048@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.801,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> some toolchain can use as "xxx-gcc -o hello hello.c" to compile, but
> sde toolchain can't find the printf function, does it means sde is not
> a complete toolchain to compile applications?
>
>   

The SDE GNU toolchain is configured to build "bare-iron" embedded 
applications, not Linux applications. Using it to build Linux apps would 
be hard. You need a compiler configured as a Linux native or cross 
compiler. See http://www.linux-mips.org/wiki/Toolchains fpr more 
information.
