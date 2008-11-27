Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 11:09:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17113 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23948529AbYK0LJi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Nov 2008 11:09:38 +0000
Date:	Thu, 27 Nov 2008 11:09:38 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mark E Mason <mason@broadcom.com>
cc:	Andrew Sharp <andy.sharp@onstor.com>,
	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Subject: RE: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC805C@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <alpine.LFD.1.10.0811271105100.27505@ftp.linux-mips.org>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com> <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org> <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com> <20081126153115.24dda1dc@ripper.onstor.net>
 <BD3F7F1EFBA6D54DB056C4FFA45140080348EC805C@SJEXCHCCR01.corp.ad.broadcom.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2008, Mark E Mason wrote:

> Data bus error, epc == 803ef178, ra == 80017030
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 1000a800 fffd9000 00000001
> $ 4   : 810a6000 fffd9000 810a6f00 fffd9000

 This is a load from 0(a1) which is 0xfffd9000 and which looks suspicious.  
You can investigate code at epc to see why it is happening.

  Maciej
