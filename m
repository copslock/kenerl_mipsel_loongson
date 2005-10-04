Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 13:37:50 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:44786 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133467AbVJDMhd
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 13:37:33 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j94CbMSQ029661;
	Tue, 4 Oct 2005 05:37:23 -0700 (PDT)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j94CbK17028946;
	Tue, 4 Oct 2005 05:37:21 -0700 (PDT)
Message-ID: <434277D5.1090603@mips.com>
Date:	Tue, 04 Oct 2005 14:38:45 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Franck <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
References: <cda58cb80510040149p690397afo@mail.gmail.com> <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

FWIW, the 4KSc is a strict superset of the 4Kc (anticipating
*some* of the Release 2 features, but not requiring them to be
used) and the 4KSd is a strict superset of the 4KE.  I would
not recommend configuring CPU_MIPS32_R2 for the 4KSc.

Both of these cores have "SmartMIPS" MMUs, which allow for
orthogonal control of Read/Write/Execute permissions on pages,
using a couple of additional bits at the top of the EntryLo
registers - which in turn limit the maximum usable physical
address space. They also allow for variable granularity of
the PageMask register, to support 1K pages.  But these features
are all done in a way that's backward-compatible with MIPS32,
and the default reset behavior makes them look like 4Kc/4KEc.

They also have some physical security and cryptography accelleration
features, some of which use extended CPU state that would
require some kernel context management support if anyone wanted
to actually use them in Linux applications. The real point of
having a CPU_4KSC config flag would be to enable building-in
such support.

I'm being a teeny bit vague about this, because I'm not 100%
certain that all the details of "SmartMIPS" have been published.

		Regards,

		Kevin K.

Maciej W. Rozycki wrote:
> On Tue, 4 Oct 2005, Franck wrote:
> 
> 
>>This patch adds support for both 4ksc and 4ksd cpus. These cpu are
>>mainly used in embedded system such as smartcard or point of sell
>>devices as they provide some extra security features.
> 
> 
>  Please send patches inline.
> 
>  Apart from the change to "arch/mips/kernel/cpu-probe.c", which is useful, 
> what's the benefit of the changes?  Specifically how is selecting e.g. 
> "CPU_4KSC" meant to be different from "CPU_MIPS32_R2"?  Do you want to 
> make GCC tune your code according to a specific's CPU pipeline 
> description?  If so, then it should probably be done a bit differently and 
> there is actually no need to differentiate between specific members of the 
> 4K family.
> 
> 
>>Signed-off-by: Franck <vagabon.xyz@gmail.com>
> 
> 
>  You should rather use your real name here.  [Hmm, why am I responding to 
> an anonym in the first place?...]
> 
>   Maciej
> 
