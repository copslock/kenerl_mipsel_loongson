Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2002 21:24:59 +0200 (CEST)
Received: from mail.linuxcare.com ([216.88.157.164]:5857 "EHLO
	mail.linuxcare.com") by linux-mips.org with ESMTP
	id <S1123905AbSIZTY6>; Thu, 26 Sep 2002 21:24:58 +0200
Received: from linuxcare.com (dmz-gw.linuxcare.com [216.88.157.161])
	by mail.linuxcare.com (Postfix) with ESMTP
	id 569C78FBD0; Thu, 26 Sep 2002 12:19:25 -0700 (PDT)
Message-ID: <3D935DE6.7020206@linuxcare.com>
Date: Thu, 26 Sep 2002 15:20:06 -0400
From: Alex deVries <adevries@linuxcare.com>
Organization: Linuxcare
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <adevries@linuxcare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adevries@linuxcare.com
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> The firmware loads an ecoff file from a volume header - The volume
> header is a special partition with a "minimalistic" filesystem
> in it - This can be modified by "dvhtool". 

Okay.  I see an example of that mentioned in your mail in
http://lists.debian.org/debian-mips/2002/debian-mips-200204/msg00056.html
.  That seems to match with an EFS volume header.

So making a tool that writes the 8k volume header is easy.  If I 
understand properly, that points to a filename on the EFS filesystem 
that follows it.

What open source tools do we have to create such an EFS filesystem?

> If you plan to work on this - Feel free to come around in
> Oldenburg this weekend - We will have a Kernel Hacker meeting
> in the University Oldenburg. I'll bring a Burner and CD-RW's 
> with me to test this.

Sadly, I have other plans this weekend.


- Alex



-- 
Alex deVries
Principal Architect, Linuxcare Canada, Inc.
(613) 562 2759

Linuxcare. Simplifying Server Consolidation.
