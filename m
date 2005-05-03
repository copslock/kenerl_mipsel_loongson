Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 22:50:32 +0100 (BST)
Received: from mailout11.sul.t-online.com ([IPv6:::ffff:194.25.134.85]:31878
	"EHLO mailout11.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225609AbVECVuQ>; Tue, 3 May 2005 22:50:16 +0100
Received: from fwd35.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1DT5HO-0001pD-02; Tue, 03 May 2005 23:50:10 +0200
Received: from denx.de (XGXamoZCQeduNOMVZIU1dUBr-jaHbwzaHeoEWF05yBM-1zkUScBg6f@[84.150.93.86]) by fwd35.sul.t-online.de
	with esmtp id 1DT5HF-0Jg6080; Tue, 3 May 2005 23:50:01 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id CC9EB42A78; Tue,  3 May 2005 23:50:00 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 6A861C108D; Tue,  3 May 2005 23:50:00 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 5E5FF13CA70; Tue,  3 May 2005 23:50:00 +0200 (MEST)
To:	Sergio Ruiz <quekio@gmail.com>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: How to the the physical addresses under linux (au1500) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 03 May 2005 23:04:41 +0200."
             <e02bc6610505031404eda9738@mail.gmail.com> 
Date:	Tue, 03 May 2005 23:49:55 +0200
Message-Id: <20050503215000.6A861C108D@atlas.denx.de>
X-ID:	XGXamoZCQeduNOMVZIU1dUBr-jaHbwzaHeoEWF05yBM-1zkUScBg6f@t-dialin.net
X-TOI-MSGID: 481a6eb4-f06e-4d41-8079-a8032b8e8e9b
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <e02bc6610505031404eda9738@mail.gmail.com> you wrote:
> 
> Well, in fact we are two the students, the teacher gave us a xxs1500
> and invited us to go as far as we could. It is a computer arquitecture
> subject, so we wanted to use some periferic under linux and
> assembler(requiered) to promote GNU stuff with other students.
> 
> The other alternative was to use YAMON, but we like linux and look
> around YOUR source code ;-)

If you want to do something else:  port  U-Boot  to  this  board  and
replace YAMON. I would _really_ appreciate that :-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A committee is a group that keeps the minutes and loses hours.
                                                      -- Milton Berle
