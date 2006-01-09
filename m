Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 22:59:03 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:3288 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133508AbWAIW6n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 22:58:43 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C9DD170467;
	Tue, 10 Jan 2006 00:01:42 +0100 (CET)
X-Auth-Info: /dHVD3Y4gS4wvlw+cdjISgOenRl4Gd81VHHP7i1LL9A=
X-Auth-Info: /dHVD3Y4gS4wvlw+cdjISgOenRl4Gd81VHHP7i1LL9A=
X-Auth-Info: /dHVD3Y4gS4wvlw+cdjISgOenRl4Gd81VHHP7i1LL9A=
Received: from mail.denx.de (p54966F34.dip.t-dialin.net [84.150.111.52])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id B3C56B8F14;
	Tue, 10 Jan 2006 00:01:42 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 5E9466D00A8;
	Tue, 10 Jan 2006 00:01:42 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 51979354115;
	Tue, 10 Jan 2006 00:01:42 +0100 (MET)
To:	"Kevin D. Kissell" <kevink@mips.com>
cc:	Sathesh Babu Edara <satheshbabu.edara@analog.com>,
	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: [processor frequency] 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 09 Jan 2006 22:53:37 +0100."
             <43C2DB61.7090704@mips.com> 
Date:	Tue, 10 Jan 2006 00:01:42 +0100
Message-Id: <20060109230142.51979354115@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <43C2DB61.7090704@mips.com> you wrote:
>
> BTW, I'm puzzled by the "context switch" benchmark test results.  By what
> mechanism - or by what definition of "context switch" - can having more
> frequent interrupts make context switches happen more quickly?  It seems
> to me that those results must be due to a systematic measurement error
> being added/removed.

I have to admit that I don't have a good explanation for this either.
It's what I got with (repeated) measurements.  Cache  (flush)  issues
might  play  a  role  here - but without closer analysis this is just
speculation.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you can't beat it or corrupt it, you pretend it was your  idea  in
the first place.                 - Terry Pratchett, _Guards! Guards!_
