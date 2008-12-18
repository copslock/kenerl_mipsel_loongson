Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 14:06:39 +0000 (GMT)
Received: from wf-out-1314.google.com ([209.85.200.169]:52278 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S24208181AbYLROGh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 14:06:37 +0000
Received: by wf-out-1314.google.com with SMTP id 27so478787wfd.21
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2008 06:06:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=HevR1seW7MjmCk0rEkKloHcZQY6LKxTAc/3U20EybSY=;
        b=k3ysva4RDxxm2gcdN5K78X28BvKPSoi6CVptwdORXrAyoMxzaJzu8jZRJrarXw2mdT
         zV5Ev3hB8WhEveq8lPomQRwoukxq8L5j3FV1TPlzfAAWG7y+69bDqjOaB5IFxitcwNPO
         6MeQm2qdtoNyveMMeNDA+Ofu96ud2fOBl4594=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=WMzf2rfuGbRPB7ZVwM0TqrMjEkR5oDhXZAYjYeYE5Fsb3Qb0dBKruy/1QSPEM3mmao
         gPjitWGSBFyoFq2aMBwYOke0Ie32E+vhh5NQUTN8LAM5+utMc72y4fT2KlQn+8kqRzEH
         /L/BCGOuNJCFiEs7sL11FmJXDexICaGSXhOLk=
Received: by 10.142.134.17 with SMTP id h17mr821012wfd.228.1229609194443;
        Thu, 18 Dec 2008 06:06:34 -0800 (PST)
Received: by 10.143.35.18 with HTTP; Thu, 18 Dec 2008 06:06:34 -0800 (PST)
Message-ID: <f2e0c4580812180606h4699be41x1128c97086ebb902@mail.gmail.com>
Date:	Thu, 18 Dec 2008 19:36:34 +0530
From:	Viswanath <rviswanathreddy@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Gprofiling Missing gcrt1.o Object file
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_35126_12878630.1229609194416"
Return-Path: <rviswanathreddy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rviswanathreddy@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_35126_12878630.1229609194416
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
          I am trying to profile (gprof profiling) my application which is
cross-compiled for the target Mips system [*Linux Mips 2.6.8.1]* and UCLIBC
*uclibc-crosstools_gcc-3.4.2_uclibc-20050502. *As far as i searched in the
google i could see a requirement of gcrt1.o object file for the mips linux
which is not available on the mips-linux.

          I tried linking with crt1.o but i could not get accurate profiling
information. I came to know that gcrt1.o is required to get the accurate
information. Where can i get the so called gcrt1.o for Mips-linux.

Thanks & Regards,
Viswanath.

------=_Part_35126_12878630.1229609194416
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am trying to profile (gprof profiling) my application which is cross-compiled for the target Mips system [<b>Linux Mips 2.6.8.1]</b> and UCLIBC <b>uclibc-crosstools_gcc-3.4.2_uclibc-20050502. </b>As far as i searched in the google i could see a requirement of gcrt1.o object file for the mips linux which is not available on the mips-linux. <br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I tried linking with crt1.o but i could not get accurate profiling information. I came to know that gcrt1.o is required to get the accurate information. Where can i get the so called gcrt1.o for Mips-linux.<br>
<br>Thanks &amp; Regards,<br>Viswanath.<br>

------=_Part_35126_12878630.1229609194416--
