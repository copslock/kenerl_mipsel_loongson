Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 18:18:16 +0000 (GMT)
Received: from mailout03.sul.t-online.com ([IPv6:::ffff:194.25.134.81]:16359
	"EHLO mailout03.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225389AbTJ0SRd>; Mon, 27 Oct 2003 18:17:33 +0000
Received: from fwd03.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1AEBvn-00012H-00; Mon, 27 Oct 2003 19:17:31 +0100
Received: from denx.de (bNXLnUZAgeUjDyOHZpl2Ll3uOjRm-cy+g9+CTNOu4lR9YWBjHzdmQ9@[217.235.255.254]) by fmrl03.sul.t-online.com
	with esmtp id 1AEBva-1Qptc80; Mon, 27 Oct 2003 19:17:18 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 3845D42C67; Mon, 27 Oct 2003 19:17:17 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 1A2E1C59E4; Mon, 27 Oct 2003 19:17:17 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 16DCFC545E; Mon, 27 Oct 2003 19:17:17 +0100 (MET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Teresa Tao <TERESAT@TTI-DM.COM>, linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: question regarding bss section 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 27 Oct 2003 19:09:57 +0100."
             <20031027180957.GA25797@linux-mips.org> 
Date: Mon, 27 Oct 2003 19:17:12 +0100
Message-Id: <20031027181717.1A2E1C59E4@atlas.denx.de>
X-Seen: false
X-ID: bNXLnUZAgeUjDyOHZpl2Ll3uOjRm-cy+g9+CTNOu4lR9YWBjHzdmQ9@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20031027180957.GA25797@linux-mips.org> you wrote:
> 
> .bss is uninitialized.  Initialized data can't be in .bss.

No. BSS is initialized as zero.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life is a game. Money is how we keep score.              - Ted Turner
