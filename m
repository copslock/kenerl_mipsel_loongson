Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 13:27:44 +0000 (GMT)
Received: from mx02.qsc.de ([213.148.130.14]:17105 "EHLO mx02.qsc.de")
	by ftp.linux-mips.org with ESMTP id S8133589AbVLNN11 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2005 13:27:27 +0000
Received: from port-195-158-169-121.dynamic.qsc.de ([195.158.169.121] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1EmWff-0003CG-00
	for linux-mips@linux-mips.org; Wed, 14 Dec 2005 14:27:51 +0100
Received: from ths by hattusa.textio with local (Exim 4.60)
	(envelope-from <ths@hattusa.textio>)
	id 1EmWfa-000609-I1
	for linux-mips@linux-mips.org; Wed, 14 Dec 2005 14:27:46 +0100
Date:	Wed, 14 Dec 2005 14:27:46 +0100
To:	linux-mips@linux-mips.org
Subject: Re: =?iso-8859-1?B?UulmLiA6IFJlOiBU?=
	=?iso-8859-1?Q?o?= put Linux kernel as closer as possible to 0x80000000
Message-ID: <20051214132746.GE29411@hattusa.textio>
References: <OFCB10026D.F6B473F3-ONC12570D6.0043AA59-C12570D6.00447CD7@sagem.com> <01f101c6005c$1faf2100$106215ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f101c6005c$1faf2100$106215ac@realtek.com.tw>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

colin wrote:
> 
> Hi Florian,
> We use MIPS 4kec.
> Linux runs in Interrupt Compatibility Mode, and it will use 0x80000200 to store the "Jump" instruction.
> Therefore, we can move Linux kernel to 0x80000204. Is it right?

0x80000208, to account for the branch delay slot.


Thiemo
