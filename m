Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 08:36:26 +0000 (GMT)
Received: from vsmtp14.tin.it ([IPv6:::ffff:212.216.176.118]:30618 "EHLO
	vsmtp14.tin.it") by linux-mips.org with ESMTP id <S8224829AbVAMIgW>;
	Thu, 13 Jan 2005 08:36:22 +0000
Received: from eppesuigoccas.homedns.org (80.117.81.199) by vsmtp14.tin.it (7.0.027) (authenticated as giuseppe.sacco17@tin.it)
        id 41E4571F000C2230 for linux-mips@linux-mips.org; Thu, 13 Jan 2005 09:36:15 +0100
Received: from eppesuig3wifi ([192.168.2.51] ident=giuseppe)
	by eppesuigoccas.homedns.org with asmtp (Exim 3.35 #1 (Debian))
	id 1Cp0Sk-0005a9-00
	for <linux-mips@linux-mips.org>; Thu, 13 Jan 2005 09:36:14 +0100
Subject: Re: O2 and 128Mb
From: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To: linux-mips@linux-mips.org
In-Reply-To: <41E627F8.3010004@total-knowledge.com>
References: <1105602134.10493.23.camel@localhost>
	 <41E627F8.3010004@total-knowledge.com>
Content-Type: text/plain
Organization: Giuseppe Sacco Consulting
Date: Thu, 13 Jan 2005 09:34:45 +0100
Message-Id: <1105605285.10490.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 12-01-2005 alle 23:49 -0800, Ilya A. Volynets-Evenbakh ha
scritto:
> "Cannot boot" is not very good describtion of the problem.
> 

You are right.
Arcboot is Debian version 0.3.8.4. I select the stanza arcboot should
use, with 'setenv OSLoadFilename <stanza>" and the kernel is loaded.
Then it s ran and the only change I see is the red led blinking. The
screen messages are:

Loading program segment 1 at 0x80004000, offset=0x4000, size = 0x3df086
Zeroing memory at 0x803e3086, size = 0x2bf9a
Starting 32-bit kernel

Bye,
Giuseppe
