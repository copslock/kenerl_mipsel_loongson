Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 19:19:00 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:28510 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225852AbVD1SSo>;
	Thu, 28 Apr 2005 19:18:44 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Thu, 28 Apr 2005 11:18:43 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <JWPMNWXK>; Thu, 28 Apr 2005 11:18:41 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB590165465D@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	'JP' <jaypee@hotpop.com>, ppopov@embeddedalley.com
Cc:	Prashant Viswanathan <vprashant@echelon.com>,
	'Manish Lachwani' <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: RE: Big Endian au1550
Date:	Thu, 28 Apr 2005 11:18:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

> I can confirm that BE works fine on the db1550 board. Just add line
> 
> select SYS_SUPPORTS_BIG_ENDIAN
> 
> to the db1550 section of arch/mips/Kconfig. That allows you to choose
> BE.
> 
> I guess all the alchemy boards will work LE and BE. At least allowing
> the setting will mean they get tested rather than folk getting put off
> by the fact they can't select it.
> 
> JP

Thanks.

Actually I had BE working many months ago. I just did an update to get the
latest and greatest stuff. It would be good if Kconfig was "fixed" to allow
BE selection.

Prashant
