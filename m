Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 10:31:06 +0000 (GMT)
Received: from moutvdom.kundenserver.de ([IPv6:::ffff:212.227.126.252]:5848
	"EHLO moutvdom.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225199AbTCKKbF>; Tue, 11 Mar 2003 10:31:05 +0000
Received: from [212.227.126.220] (helo=mrvdomng.kundenserver.de)
	by moutvdom.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18sh2C-0002uX-00; Tue, 11 Mar 2003 11:31:00 +0100
Received: from [62.109.119.183] (helo=192.168.202.41)
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18sh2B-0004J2-00; Tue, 11 Mar 2003 11:30:59 +0100
From: Bruno Randolf <br1@4g-systems.de>
Organization: 4G Mobile Systeme
To: Dan Malek <dan@embeddededge.com>, Jun Sun <jsun@mvista.com>
Subject: Re: Mycable XXS board
Date: Tue, 11 Mar 2003 11:30:57 +0100
User-Agent: KMail/1.5
Cc: linux-mips@linux-mips.org
References: <3E689267.3070509@prosyst.bg> <20030307133919.P26071@mvista.com> <3E691514.7000907@embeddededge.com>
In-Reply-To: <3E691514.7000907@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303111130.57387.br1@4g-systems.de>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips

On Friday 07 March 2003 22:54, Dan Malek wrote:

> That's what I wanted to clarify.  Are we discussing one of the on-chip
> peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
> that was plugged into the Au1500.  In the case of the on-chip controller,
> there aren't any interrupt routing problems, it's identical (and the same
> code) on all Au1xxx boards.

we are discussing the on-chip USB controller for the mycable board. and its 
little endian...

any ideas where the assignment errors could come from in this case?

thanks,
bruno
