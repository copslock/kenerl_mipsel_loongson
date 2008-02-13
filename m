Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2008 16:21:39 +0000 (GMT)
Received: from [85.33.2.28] ([85.33.2.28]:52235 "EHLO smtp-out28.alice.it")
	by ftp.linux-mips.org with ESMTP id S20024522AbYBMQVa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2008 16:21:30 +0000
Received: from FBCMMO03.fbc.local ([192.168.68.197]) by smtp-out28.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 17:21:14 +0100
Received: from FBCMCL01B08.fbc.local ([192.168.171.46]) by FBCMMO03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 17:21:12 +0100
Received: from [192.168.0.3] ([79.19.188.10]) by FBCMCL01B08.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 17:21:04 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	David Daney <ddaney@avtrex.com>
Subject: Re: Can't execute any MIPS  binary
Date:	Wed, 13 Feb 2008 17:21:11 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20080118.763038)
References: <200802130034.25052.rootkit85@yahoo.it> <47B231AD.5050809@avtrex.com>
In-Reply-To: <47B231AD.5050809@avtrex.com>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802131721.11392.technoboy85@gmail.com>
X-OriginalArrivalTime: 13 Feb 2008 16:21:05.0109 (UTC) FILETIME=[6E90D050:01C86E5C]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Wednesday 13 February 2008 00:54:21 hai scritto:
> You should be able to run the binary if run a binary editor on it and 
> clear the mips32 flag (i.e. change the flags from 0x50001007 to just 
> 0x1007).

Solved by changing flags from 0x50001007 to 0x5, thanks :)
