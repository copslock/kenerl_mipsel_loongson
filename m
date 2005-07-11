Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 19:57:20 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.193]:57604 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226534AbVGKS5E> convert rfc822-to-8bit;
	Mon, 11 Jul 2005 19:57:04 +0100
Received: by wproxy.gmail.com with SMTP id i32so892442wra
        for <linux-mips@linux-mips.org>; Mon, 11 Jul 2005 11:57:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OUdwODkjc9h5bqgSiXb+ctoYn4OEWDRcWetokhuqnboft00qOarlKHf4yxZTL0zLg5V6g4ukyfP/ggnCgAM83gRkfYXzIecizKl2KwDCUY074cqNCRppv9OHJHSCEFptnUe6TwtRY6334hIsSd6btN7JyNanCY+dfN98MABkx/w=
Received: by 10.54.26.9 with SMTP id 9mr4254840wrz;
        Mon, 11 Jul 2005 11:57:31 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Mon, 11 Jul 2005 11:57:31 -0700 (PDT)
Message-ID: <2db32b7205071111574ed8c4da@mail.gmail.com>
Date:	Mon, 11 Jul 2005 11:57:31 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Help needed on db1550 for pcmcia support
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I compiled linux 2.6.12-mipscvs with the pcmcia support and got the three files:

pcmcia_core.ko, pcmcia.ko, and au1x00_ss.ko.

I use "insmod pcmcia_core.ko; insmod pcmcia.ko; insmod au1x00_ss.ko"
to install the three modules.

Because I want to use the Compact Flash through the PCMCIA, I compiled
ide_cs.ko and use "insmod ide_cs.ko" to install it.

When I type "lspci -v", there is no information about the pcmcia.
Also, cardctl showed "open_sock(): no such device".

I googled around the wedsite, got no luck for this problem.

thanks
