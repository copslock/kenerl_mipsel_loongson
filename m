Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 13:16:04 +0100 (BST)
Received: from smtp-out114.alice.it ([85.37.17.114]:32772 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S20022266AbXICMPz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 13:15:55 +0100
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Sep 2007 14:15:10 +0200
Received: from FBCMCL01B06.fbc.local ([192.168.69.87]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Sep 2007 14:15:48 +0200
Received: from raver.cocorico ([87.11.114.203]) by FBCMCL01B06.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Sep 2007 14:15:10 +0200
Received: by 10.82.154.20 with SMTP id b20cs876037bue;
        Wed, 22 Aug 2007 01:11:04 -0700 (PDT)
Received: by 10.82.112.3 with SMTP id k3mr943124buc.1187770261340;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
        by mx.google.com with ESMTP id j9si1357887mue.2007.08.22.01.10.56;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received-SPF: neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) client-ip=157.159.10.44;
Authentication-Results:	mx.google.com; spf=neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) smtp.mail=florian.fainelli@telecomint.eu
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Matteo Croce <technoboy85@gmail.com>
Subject: [PATCH 0/7] AR7 port 2nd round
Date:	Mon, 3 Sep 2007 14:15:47 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org
References: <200708201704.11529.technoboy85@gmail.com>
In-Reply-To: <200708201704.11529.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709031415.47499.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-OriginalArrivalTime: 03 Sep 2007 12:15:10.0494 (UTC) FILETIME=[12CBFBE0:01C7EE24]
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

I have followed Florian's instructions, and that are the patches for the AR7
