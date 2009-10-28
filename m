Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 09:36:15 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:33740 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492663AbZJ1IgI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 09:36:08 +0100
Received: by bwz21 with SMTP id 21so638215bwz.24
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 01:35:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Lklh86wFZNHZnYXxZT5UQb4VrFOb2pavYSIEKm4dtcU=;
        b=cxV2EtQrhCOKXvSpO38lpwdLIK/+l4yJJALkC62PadGpL6UO/iIVHIPx7gcPH80PWm
         NUm36eTXK/N0b/yhNAFzfSivcKnaoaKxCdUxp8HLjBQFsPVd856KjGSMBorc2beRuTxX
         ysmyanFFCU+KAPTBJQSK/2Sws/tcCUfsxpYI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=waA70LkxkcQAnjDKZEexB7fdW0fn64BGDuAm1OALqd7q1ybc9Zz9x034kA1SLnBbFH
         7Hs5DqrTLxlpFZcXtZ4ytluFcoje13zmU3D2w8pREmRGlcCi2RCY+J13GYwlMCLiQrXC
         nDaYiShDhSfNqsUjCoLqKP+W60pIa5u/hHiMw=
Received: by 10.103.37.33 with SMTP id p33mr369902muj.132.1256718959070;
        Wed, 28 Oct 2009 01:35:59 -0700 (PDT)
Received: from pixies.home.jungo.com (pptp-il.jungo.com [194.90.113.98])
        by mx.google.com with ESMTPS id j6sm2090591mue.20.2009.10.28.01.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 01:35:58 -0700 (PDT)
Date:	Wed, 28 Oct 2009 10:35:51 +0200
From:	Shmulik Ladkani <jungoshmulik@gmail.com>
To:	myuboot@fastmail.fm
Cc:	"Florian Fainelli" <florian@openwrt.org>,
	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>, shmulik@jungo.com
Subject: Re: serial port 8250 messed up after coverting from little endian
 to big endian on kernel  2.6.31
Message-ID: <20091028103551.0b4052d8@pixies.home.jungo.com>
In-Reply-To: <1256676013.24305.1342273367@webmail.messagingengine.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
	<4AD906D8.3020404@caviumnetworks.com>
	<1255996564.10560.1340920621@webmail.messagingengine.com>
	<200910200817.24018.florian@openwrt.org>
	<1256676013.24305.1342273367@webmail.messagingengine.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jungoshmulik@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jungoshmulik@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 27 Oct 2009 15:40:13 -0500 myuboot@fastmail.fm wrote:
> Thanks, Florian. I found the cause of the problem. My board is 32 bit
> based, so each serial port register is 32bit even only 8 bit is used. So
> when the board is switched endianess, I need to change the address
> offset to access the same registers.
> For example, original RHR register address is 0x8001000 with little
> endian mode. With big endian, I need to access it as 0x8001003.

I assume your uart_port's iotype is defined as UPIO_MEM32.
UPIO_MEM32 makes 8250 access serial registers using readl/writel (which might
be a problem for big-endian), while UPIO_MEM makes 8250 access the registers
using readb/writeb.
Maybe you should try UPIO_MEM (assuming hardware allows byte access).

-- 
Shmulik Ladkani		Jungo Ltd.
