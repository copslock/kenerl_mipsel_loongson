Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 21:20:58 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:2758 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133646AbWAIVUi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 21:20:38 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 5F5A9708CE;
	Mon,  9 Jan 2006 22:23:40 +0100 (CET)
X-Auth-Info: 9rjmi9LVaZAfXEmq1oWowzyjKRYS8/8gJ+kKZWZYKBM=
X-Auth-Info: 9rjmi9LVaZAfXEmq1oWowzyjKRYS8/8gJ+kKZWZYKBM=
X-Auth-Info: 9rjmi9LVaZAfXEmq1oWowzyjKRYS8/8gJ+kKZWZYKBM=
Received: from mail.denx.de (p54966F34.dip.t-dialin.net [84.150.111.52])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 46146B96D9;
	Mon,  9 Jan 2006 22:23:40 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id D7A556D00A8;
	Mon,  9 Jan 2006 22:23:39 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id C8289353A66;
	Mon,  9 Jan 2006 22:23:39 +0100 (MET)
To:	"Kevin D. Kissell" <kevink@mips.com>
cc:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>,
	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: [processor frequency]
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 09 Jan 2006 10:00:48 +0100."
             <005a01c614fb$2fe76b00$10eca8c0@grendel> 
Date:	Mon, 09 Jan 2006 22:23:39 +0100
Message-Id: <20060109212339.C8289353A66@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <005a01c614fb$2fe76b00$10eca8c0@grendel> you wrote:
> There is no "ideal" value for a given processor frequency.
> The lower the value, the less interrupt processing overhead,
> but the slower the response time to events that are detected
> or serviced during clock interrupts. 1000 HZ *may* be a sensible
> value (I have my doubts, personally) for 2+ GHz PC processors, 
> but it's excessive (IMHO) for a 200MHz processor and unworkable 
> for a 20MHz CPU. I think that 100HZ is still a reasonable value
> for an embedded RISC CPU, but the "ideal" value is going to
> be a function of the application.

We did some tests of the performance impact of 100 vs. 1000 Hz  clock
frequency on low end systems (50 MHz PowerPC); for details please see
http://www.denx.de/wiki/view/Know/Clock100vs1000Hz

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Our missions are peaceful -- not for conquest.  When we do battle, it
is only because we have no choice.
	-- Kirk, "The Squire of Gothos", stardate 2124.5
