Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 14:53:51 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:2291 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133472AbVJDNxf
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 14:53:35 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j94DrOLM029928;
	Tue, 4 Oct 2005 06:53:24 -0700 (PDT)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j94DrO17000018;
	Tue, 4 Oct 2005 06:53:25 -0700 (PDT)
Message-ID: <434289A7.50007@mips.com>
Date:	Tue, 04 Oct 2005 15:54:47 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Franck <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
References: <cda58cb80510040149p690397afo@mail.gmail.com> <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl> <434277D5.1090603@mips.com> <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 4 Oct 2005, Kevin D. Kissell wrote:
> 
> 
>>FWIW, the 4KSc is a strict superset of the 4Kc (anticipating
>>*some* of the Release 2 features, but not requiring them to be
>>used) and the 4KSd is a strict superset of the 4KE.  I would
>>not recommend configuring CPU_MIPS32_R2 for the 4KSc.
> 
> 
>  Well, the patch asked GCC to use the instruction set of the "4kec" CPU 
> for both (and also the "mips32r2" ISA, but that's overridden by the 
> former), so it must have been incorrect in the first place

Which was sort-of why I replied.  In particular, the MIPS32R2 bitfield
instructions will probably cause a reserved instruction fault on a 4KSc.

	Regards,

	Kevin K.
