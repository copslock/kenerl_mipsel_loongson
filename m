Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 07:54:37 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.187]:46870 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023693AbYEIGyf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 07:54:35 +0100
Received: by ti-out-0910.google.com with SMTP id i7so417092tid.20
        for <linux-mips@linux-mips.org>; Thu, 08 May 2008 23:54:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=IldOvj1Zno9+nqgRD3YU0CaROgbIIhfNRnj0IOnvv90=;
        b=lxONG9tKbS91iYCId1egijeSj8iXnua903X2hi+S8zznZQEEepv/52miiF6fPHttrwcSgAiAzTGX5ppU12nETLym2zTDt9/NDqBpbqXYVYvNO+zYVuEOHf9rNWOKCY/hs0sRH2TyqK5oIXfXdtJRShOUsMXL/wqBvBNsrjfacsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=w6itR6IfQIoJCV721KXFkmaL352vasDehQgfLj9YZYs7FA869ASRfsoPlr5YXj+6W0+GHf6LWLln5MtqET6tDtiStd8CXDQu/Nigk+8KZt05PODJE7MUFm5dGCQ7yszpXhzDA9p3MArgtUSQaS83YFBHHZbUqSyWtOqdNvIVTQI=
Received: by 10.110.15.9 with SMTP id 9mr399784tio.44.1210316069127;
        Thu, 08 May 2008 23:54:29 -0700 (PDT)
Received: by 10.110.42.3 with HTTP; Thu, 8 May 2008 23:54:29 -0700 (PDT)
Message-ID: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
Date:	Fri, 9 May 2008 14:54:29 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: is remap_pfn_range should align to 2(n) * (page size) ?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3407_14612540.1210316069190"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_3407_14612540.1210316069190
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello all
           i have a sensor driver want to malloc 2.xM SDRAM to capture
data(using DMA),  so i used  remap_pfn_range to malloc 3M.
But in /proc/meminfo, it showes free memory reduce 4M. i also check the
/proc/buddyinfo, it seemes too.
(i am looking inside kernel code, but not get clear at now).

 is remap_pfn_range should align to  2(n) * (page size) ?

thanks for any hints

zzh

------=_Part_3407_14612540.1210316069190
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello all<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i have a sensor driver want to malloc 2.xM SDRAM to capture data(using DMA),&nbsp; so i used&nbsp; remap_pfn_range to malloc 3M.<br>But in /proc/meminfo, it showes free memory reduce 4M. i also check the /proc/buddyinfo, it seemes too.<br>
(i am looking inside kernel code, but not get clear at now).<br><br>&nbsp;is remap_pfn_range should align to&nbsp; 2(n) * (page size) ?&nbsp; <br><br>thanks for any hints<br><br>zzh<br>

------=_Part_3407_14612540.1210316069190--
