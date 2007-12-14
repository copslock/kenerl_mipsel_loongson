Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 03:06:00 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:59435 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S28576108AbXLNDFw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 03:05:52 +0000
Received: from rocktron ([10.18.28.237]) by zeugmasystems.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 13 Dec 2007 19:05:23 -0800
Message-ID: <559073B2DA784D4BABF7618D6D8CA89C@rocktron>
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590D6B@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5590D6B@exchange.ZeugmaSystems.local>
Subject: GCC bug affecting MIPS (was Re: SiByte 1480 & Branch Likely instructions?)
Date:	Thu, 13 Dec 2007 19:05:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
X-OriginalArrivalTime: 14 Dec 2007 03:05:23.0768 (UTC) FILETIME=[2B4F8B80:01C83DFE]
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

"Kaz Kylheku" <kaz@zeugmasystems.com> wrote on December 07, 2007:
> Kaz wrote:
>> Hi All,
>>
>> Not really a kernel-related question. I've discovered that GCC 4.1.1
>> (which I'm not using for kernel compiling, but user space) generates
>> branch likely instructions by default, even though the documentation
>> says that their use is off by default for MIPS32 and MIPS64, because
>
> That's because the compiler is not configured correctly. The default CPU
> string "from-abi" ends up being used, and so the target ISA is MIPS III.

I managed to root-cause the original problem, and moments ago filed this bug 
report:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=34456

GCC can screw up when doing branch delay slot filling, because in computing 
register liveness, it makes an incorrectly computed assumption about what 
registers are clobbered by a CALL_INSN. By unfortunate coincidence, it's 
possible for an instruction which restores the caller's GP to be wrongly 
moved into a non-annulled delay slot, wreaking havoc on the fall-through 
path where GP is in fact used. Jumps and data accesses are then attempted 
using what is possibly the wrong global offset table.
