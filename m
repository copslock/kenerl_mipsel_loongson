Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 02:23:00 +0000 (GMT)
Received: from imfep02.dion.ne.jp ([IPv6:::ffff:210.174.120.146]:40429 "EHLO
	imfep02.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8225329AbVAFCWz>; Thu, 6 Jan 2005 02:22:55 +0000
Received: from webmail.dion.ne.jp ([210.196.2.172]) by imfep02.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with SMTP
          id <20050106022239.EMDM1125.imfep02.dion.ne.jp@webmail.dion.ne.jp>;
          Thu, 6 Jan 2005 11:22:39 +0900
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Date: Thu, 06 Jan 2005 11:22:39 +0900
Message-Id: <1104978159.27464@157.120.127.3.DIONWebMail>
Subject: Re: problem of cross compile
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Mailer: DION Web mail version 1.03
X-Originating-IP: 157.120.127.3(*)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Thank you for the reply. 

I was using the strip command in REDHAT. 
When I used STRIP for crossing, the file was normally executed. 

>Make shure you used the corss strip (eg. mips-linux-strip) and not the host 
strip.

>Michael

Nyauyama.
