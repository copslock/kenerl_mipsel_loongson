Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 19:14:49 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:39430 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225604AbUBVTOe>;
	Sun, 22 Feb 2004 19:14:34 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i1MImgi01698;
	Sun, 22 Feb 2004 13:48:42 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1MJDUM10909;
	Sun, 22 Feb 2004 14:13:30 -0500
Received: from [192.168.123.101] (vpn26-9.sfbay.redhat.com [172.16.26.9])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i1MJDTX10744;
	Sun, 22 Feb 2004 11:13:29 -0800
Subject: Re: r3000 instruction set
From:	Eric Christopher <echristo@redhat.com>
To:	Mark and Janice Juszczec <juszczec@hotmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
Content-Type: text/plain
Message-Id: <1077477186.3636.34.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date:	Sun, 22 Feb 2004 11:13:06 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> So, can someone recommend a definitive list of r3000 assembler instructions?

Other than the responses you've already gotten, likely you'll need to
compile with -march=r3900(or -mcpu=r3900 if it's an old toolchain) since
the 3900 is missing a couple of r3000 instructions iirc.

If it's the 3912 I remember it also doesn't have an fpu, but I could be
wrong there. If it is, then you need -msoft-float as well.

-eric

-- 
Eric Christopher <echristo@redhat.com>
