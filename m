Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 18:17:24 +0000 (GMT)
Received: from mailout07.sul.t-online.com ([IPv6:::ffff:194.25.134.83]:16317
	"EHLO mailout07.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225344AbTJ0SQw>; Mon, 27 Oct 2003 18:16:52 +0000
Received: from fwd08.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1AEBv6-0008Dy-02; Mon, 27 Oct 2003 19:16:48 +0100
Received: from denx.de (Gh9zDoZvYebC6C2rgcyyIl7dt1A6UB7GL16p1a4UJ+l3GWaxl7naEG@[217.235.255.254]) by fmrl08.sul.t-online.com
	with esmtp id 1AEBur-1Qsv9U0; Mon, 27 Oct 2003 19:16:33 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 64F3D42C67; Mon, 27 Oct 2003 19:16:31 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 199CEC59E4; Mon, 27 Oct 2003 19:16:30 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 0CAA9C545E; Mon, 27 Oct 2003 19:16:30 +0100 (MET)
To: "Teresa Tao" <TERESAT@TTI-DM.COM>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: question regarding bss section 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 27 Oct 2003 09:44:05 PST."
             <92F2591F460F684C9C309EB0D33256FA01B750B3@trid-mail1.tridentmicro.com> 
Date: Mon, 27 Oct 2003 19:16:24 +0100
Message-Id: <20031027181630.199CEC59E4@atlas.denx.de>
X-Seen: false
X-ID: Gh9zDoZvYebC6C2rgcyyIl7dt1A6UB7GL16p1a4UJ+l3GWaxl7naEG@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

Dear Teresa,

in message <92F2591F460F684C9C309EB0D33256FA01B750B3@trid-mail1.tridentmicro.com> you wrote:
> 
> I have several questions and hope somebody could help me with the answers:
> 1. how to use gcc to compile the user mode program with larger stack size?

You don't. The Linux kernel will autyomagically grow the stack as needed.

> 2. Inside the user mode program, I have declared some gloabal data
> which is being put on the bss section and I would like to know whom
> initialize the bss section? How big is the bss section? Under what
> kind of situation, the bss section data could be corrupted?

The kernel resp. the C runtime environment will  initialize  the  BSS
for you. The BSS will be initialized with zero values.

The BSS section is as big as needed to put all  objects  of  matching
type into it (this is determined at link time).

The BSS may get corrupted in exactly the  same  situations  when  any
other memroy corruption can happen, i. e. typically writing through a
rogue  pointer,  writing  beyound  the valid index range of an array,
errors using malloc() and free(0, etc.

> 3. What's the difference to compile the program with -G  0  option?
> That  menas  I  don't  use  the  $gp register, will there be any side
> effect?

Quoting the GCC info pages:

`-G NUM'
     Put global and static objects less than or equal to NUM bytes into
     the small data or bss sections instead of the normal data or bss
     sections.  The default value of NUM is 8.  The `-msdata' option
     must be set to one of `sdata' or `use' for this option to have any
     effect.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I dislike companies that have a we-are-the-high-priests-of-hardware-
so-you'll-like-what-we-give-you attitude. I like commodity markets in
which iron-and-silicon hawkers know that they exist to  provide  fast
toys for software types like me to play with..."    - Eric S. Raymond
