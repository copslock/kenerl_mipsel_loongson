Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2002 23:07:56 +0200 (CEST)
Received: from mail.linuxcare.com ([216.88.157.164]:64386 "EHLO
	mail.linuxcare.com") by linux-mips.org with ESMTP
	id <S1123906AbSIZVH4>; Thu, 26 Sep 2002 23:07:56 +0200
Received: from linuxcare.com (dmz-gw.linuxcare.com [216.88.157.161])
	by mail.linuxcare.com (Postfix) with ESMTP
	id B99928FC6F; Thu, 26 Sep 2002 14:02:23 -0700 (PDT)
Message-ID: <3D937609.3010201@linuxcare.com>
Date: Thu, 26 Sep 2002 17:03:05 -0400
From: Alex deVries <adevries@linuxcare.com>
Organization: Linuxcare
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org> <3D935DE6.7020206@linuxcare.com> <20020926225611.A26300@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <adevries@linuxcare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adevries@linuxcare.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Sep 26, 2002 at 03:20:06PM -0400, Alex deVries wrote
>>What open source tools do we have to create such an EFS filesystem?
> 
> None.  The in-kernel EFS filesystem is read-only.

Okay.  Let me look at that.

EFS seems pretty simple, but is there a filesystem described apart from 
the .h files?


- Alex



-- 
Alex deVries
Principal Architect, Linuxcare Canada, Inc.
(613) 562 2759

Linuxcare. Simplifying Server Consolidation.
