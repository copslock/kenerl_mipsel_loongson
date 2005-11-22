Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 08:49:51 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:50428 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8134445AbVKVIte
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 08:49:34 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id jAM8q2sO013138;
	Tue, 22 Nov 2005 00:52:03 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id jAM8q316020211;
	Tue, 22 Nov 2005 00:52:04 -0800 (PST)
Message-ID: <4382DC76.60506@mips.com>
Date:	Tue, 22 Nov 2005 09:53:10 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Knittel, Brian" <Brian.Knittel@powertv.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
In-Reply-To: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Knittel, Brian wrote:
> Hi,
> 
> I'd like to force the compiler to store arguments on the stack with otherwise optimized code.
> 
> I found a refernce in the archives (form 2001) for using -0 (no optimization). Has anyone found another way to do this?

If I recall correctly, if you specify -g to enable debugger support,
the subroutine prologues store the arguments into their stack slots,
even if a higher level of optimization is otherwise specified.

		Regards,

		Kevin K.
