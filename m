Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 13:47:12 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:32148 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133831AbWCTNrD
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 13:47:03 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2KDuXDl017009;
	Mon, 20 Mar 2006 05:56:34 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k2KDuXHI028072;
	Mon, 20 Mar 2006 05:56:33 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FLJlD-0002h2-00; Mon, 20 Mar 2006 12:45:23 +0000
Message-ID: <441EA3E3.7050906@mips.com>
Date:	Mon, 20 Mar 2006 12:45:23 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does any gnu toolchain support mips udi instruction?
References: <50c9a2250603191846g42ed20e4r87aa14e5bef1efe2@mail.gmail.com>
In-Reply-To: <50c9a2250603191846g42ed20e4r87aa14e5bef1efe2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.747,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



zhuzhenhua wrote:

>for now, i can use the sde toolchain to compile for udi instruction,
>but it can not compile application for linux, did someone generate a
>gnu toolchain to compile the udi instruction?
>
>  
>

You could install SDE as a native toolchain running on Linux/MIPS, in 
which case you can build applications with it.

Alternatively you could consider using the TimeSys cross development 
tools. Their MIPS-24KEc repository is based on the SDE toolchain, and in 
this form is usable as a full cross toolchain, capable of cross-building 
applications as well as the kernel. See 
http://www.timesys.com/processor/mips.htm

Nigel
