Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 15:18:58 +0000 (GMT)
Received: from nz-out-0102.google.com ([64.233.162.201]:64530 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20038702AbWKNPSu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 15:18:50 +0000
Received: by nz-out-0102.google.com with SMTP id m7so1092425nzf
        for <linux-mips@linux-mips.org>; Tue, 14 Nov 2006 07:18:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FpZt3VTpjjsKkNVCFGuZk3cdPT6pRx2QyHnrqD4h9OY1sL5RWEMSHBJeA5M4FbsHCZX1biA1AEubNiFgj71Tsct+bAod+D3JjWYjIVpUJBF+FHZi5IS8K0zO66smD3vhKtlJ0FKqnW6PDitO/fpyheu0zdzkivV2YiPwcbNBLVM=
Received: by 10.65.213.4 with SMTP id p4mr1280486qbq.1163517520941;
        Tue, 14 Nov 2006 07:18:40 -0800 (PST)
Received: by 10.65.150.16 with HTTP; Tue, 14 Nov 2006 07:18:40 -0800 (PST)
Message-ID: <44c63dc40611140718q4e8bc417w15438b2e0222ef15@mail.gmail.com>
Date:	Wed, 15 Nov 2006 00:18:40 +0900
From:	barrios <barrioskmc@gmail.com>
To:	linux-mips@linux-mips.org
Subject: timing measure in dynamic linker
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <barrioskmc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: barrioskmc@gmail.com
Precedence: bulk
X-list: linux-mips

I want to measure relocation and symbol look up time for startup program.
So, I looked following code at glibc/elf/rtld.c.

#ifndef HP_TIMING_NONAVAIL
   print_statistics (&rtld_total_time);
#else
   print_statistics (NULL);
#endif

I think that glibc can't support time stamp counter register in mips
architecture. So not implemented HP_TIMING_XXX functions.

How can I measure relocation and symbol lookup time in dynamic linker ?
Welcome to any answers.
Best Regards.
