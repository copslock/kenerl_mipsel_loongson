Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 09:34:59 +0200 (CEST)
Received: from mail-px0-f188.google.com ([209.85.216.188]:58617 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491999AbZFZHew (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 09:34:52 +0200
Received: by pxi26 with SMTP id 26so1275165pxi.22
        for <linux-mips@linux-mips.org>; Fri, 26 Jun 2009 00:30:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+0C2Bt1Y8v0ZC6EVdNNSRso3y0wzOt/mh9QlvkJ+s5k=;
        b=xodMVG4fapg3/eR9ZtitSbXo6FAPvy+g+LhRcerMxzLYJjrRdj/1Xt2zOjhYRk9x6d
         Jj0nEp3qFEfkwG+VZxZ2YKlbCsopGqCChV6obmgBz5yf51OQZDAHElWjG8xlCpcpFKoy
         Djt0+U9/lKrOUOxYaUSSNthTF48E5z8TL0R+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nayYtSJjzh3dzsYH49F/7MjhATXcvRZu24rc6rquWEt5Zlo3j4Au+LKyINIi9hJgMt
         XxbfVTMRmIEL1GGnPPPb15uOuTk5EDIMdQo0pTR1smUUA9e4Nn5VTb3OHOTqrIPEkHWx
         HDWh260NpTE8VJXFGmoieHbmK9sqiO615MYzk=
MIME-Version: 1.0
Received: by 10.114.113.16 with SMTP id l16mr5400660wac.21.1246001450900; Fri, 
	26 Jun 2009 00:30:50 -0700 (PDT)
Date:	Fri, 26 Jun 2009 13:00:50 +0530
Message-ID: <4f9abdc70906260030q3cefba63tb2fd30245a7015df@mail.gmail.com>
Subject: linux porting - doubts
From:	joe seb <joe.seb8@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016364178fddedeaa046d3b5115
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--0016364178fddedeaa046d3b5115
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

We are trying to port linux to our new platform based on MIPS32 24Kc.

In our platform we have physical RAM of 256M mapped from 0x90000000
to 0xa0000000( KSEG0 - cached) and 0xb0000000 to 0xc0000000(KSEG1-
uncached).

We made the following changes for our platform,

CAC_BASE to  0x90000000 in spaces.h
KSEG0 to 0x90000000 and KSEG1 to 0xb0000000 in addrspace.h
CKSEG0 to 0x90000000 and CKSEG1 to 0xb0000000 in addrspace.h
loadaddr to 0x90000000 in the Makefile under arch/mips folder.

Are these changes sufficient??
Is there any other platform port with such variations which we can refer to
make sure about the changes made.

Thanks and Regards,
Joe

--0016364178fddedeaa046d3b5115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
<br>
<br>We are trying to port linux to our new platform based on MIPS32 24Kc.
<br>
<br>In our platform we have physical RAM of 256M mapped from 0x90000000
<br>to 0xa0000000( KSEG0 - cached) and 0xb0000000 to 0xc0000000(KSEG1-=20
uncached).
<br>
<br>We made the following changes for our platform,
<br>
<br>CAC_BASE to=A0 0x90000000 in spaces.h
<br>KSEG0 to 0x90000000 and KSEG1 to 0xb0000000 in addrspace.h
<br>CKSEG0 to 0x90000000 and CKSEG1 to 0xb0000000 in addrspace.h
<br>loadaddr to 0x90000000 in the Makefile under arch/mips folder.
<br>
<br>Are these changes sufficient??
<br>Is there any other platform port with such variations which we can refe=
r to
<br>make sure about the changes made.
<br>
<br>Thanks and Regards,<br>Joe<br>

--0016364178fddedeaa046d3b5115--
