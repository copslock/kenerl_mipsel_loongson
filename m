Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 18:54:59 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:27054 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133495AbWBNSyu
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 18:54:50 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1EJ12Ns015196;
	Tue, 14 Feb 2006 11:01:03 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k1EJ1189020181;
	Tue, 14 Feb 2006 11:01:01 -0800 (PST)
Received: from officemobile.mips-dk.mips.com ([192.168.192.20] helo=[127.0.0.1])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F95Px-0006BW-00; Tue, 14 Feb 2006 19:00:53 +0000
Message-ID: <43F228E4.40200@mips.com>
Date:	Tue, 14 Feb 2006 19:00:52 +0000
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does any other cross-tool support UID instruction?
References: <50c9a2250602121738r59f5fed0s800e43f9d232c6eb@mail.gmail.com>
In-Reply-To: <50c9a2250602121738r59f5fed0s800e43f9d232c6eb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.809,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> i want to use the UID instruction in my application or library, but
> the sde toolchain on support to compile bootloader or kernel.
> how to use it to compile a application or library?
> or does any other cross-tool support UID instruction?
> thanks for any hints
>
>   

I assume that you mean the UDI instruction. You could consider the 
TimeSys Linuxlink MIPS distribution see 
http://www.timesys.com/releases/home_bdy_news.php?show_article=1265 
which will include MIPS SDE configured as a full Linux MIPS cross-toolchain.

Nigel
