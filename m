Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 07:24:46 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.198]:54477 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133367AbVLNHY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Dec 2005 07:24:26 +0000
Received: by wproxy.gmail.com with SMTP id i7so321449wra
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2005 23:24:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gGPbfGn+AXONdLoViV/y8sUXQBJaueRkRRBZbsSiCkBmAYaEgIkGS+WZPlX6Zoa47w9x59NfuPNqa8A5Nu+E7r9DvYM0VkCAcASQZ2R0+DSsR8GElSch5S2WoSSJCVzyWA6viWZpaqL61V3EGqljKCJ7Qwa9W31D0bHqkMC/6c0=
Received: by 10.54.132.16 with SMTP id f16mr325158wrd;
        Tue, 13 Dec 2005 23:24:51 -0800 (PST)
Received: by 10.54.146.1 with HTTP; Tue, 13 Dec 2005 23:24:51 -0800 (PST)
Message-ID: <f69849430512132324y31598c2bma2e2666a2347ec2d@mail.gmail.com>
Date:	Tue, 13 Dec 2005 23:24:51 -0800
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: ENDEC ports and MII interface
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
    I'm trying to write ethernet driver.I need some explaination on
ENDEC port and MII interface.By googling i've come to know that MII is
used for phy communication by modern ethernet cards,but i haven't
found much info on  ENDEC ports.

Actually mine card has option to select ENDEC port or MII interface
for transmit and recieve.

Please tell me  which one should i choose and why.

lhrkernelcode
