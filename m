Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:13:10 +0200 (CEST)
Received: from mail.linuxcare.com ([216.88.157.164]:18903 "EHLO
	mail.linuxcare.com") by linux-mips.org with ESMTP
	id <S1122961AbSI0VNJ>; Fri, 27 Sep 2002 23:13:09 +0200
Received: from linuxcare.com (dmz-gw.linuxcare.com [216.88.157.161])
	by mail.linuxcare.com (Postfix) with ESMTP
	id 0A60D8FC18; Fri, 27 Sep 2002 14:07:32 -0700 (PDT)
Message-ID: <3D94C8BF.5090902@linuxcare.com>
Date: Fri, 27 Sep 2002 17:08:15 -0400
From: Alex deVries <adevries@linuxcare.com>
Organization: Linuxcare
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
References: <3D92B80A.3080802@linuxcare.com> <20020927160000.GB622@paradigm.rfc822.org> <20020927160643.GA6960@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <adevries@linuxcare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adevries@linuxcare.com
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> BTW: I was not able to boot from a cd-rom drive which was not able to 
> read 512 byte blocked. Burning on a 2048 byte blocked burner is no
> problem though.

I have a cdrom connected to my Indy which has been configured to 512.  I 
think this hw is good, but will double check when I find an IRIX CD. 
When I boot, it complains "invalid partition".

I wrote the ISO you posted on an i386 box with cdrecord.  I suspect my 
problem I didn't use set the blocksize to 512; exactly how did you burn 
this CD?


- Alex

-- 
Alex deVries
Principal Architect, Linuxcare Canada, Inc.
(613) 562 2759

Linuxcare. Simplifying Server Consolidation.
