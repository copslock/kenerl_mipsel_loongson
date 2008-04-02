Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 15:57:47 +0200 (CEST)
Received: from smtp-out113.alice.it ([85.37.17.113]:24591 "EHLO
	smtp-out113.alice.it") by lappi.linux-mips.net with ESMTP
	id S525206AbYDBN5k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 15:57:40 +0200
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out113.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Apr 2008 15:57:17 +0200
Received: from FBCMCL01B02.fbc.local ([192.168.69.83]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Apr 2008 15:57:17 +0200
Received: from [192.168.1.3] ([87.7.112.40]) by FBCMCL01B02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Apr 2008 15:57:14 +0200
From:	Matteo Croce <technoboy85@gmail.com>
To:	Florian Lohoff <flo@rfc822.org>
Subject: Re: [PATCH][MIPS][3/6]: AR7: VLYNQ bus
Date:	Wed, 2 Apr 2008 15:57:08 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803120226.42795.technoboy85@gmail.com> <20080329095914.GA18263@paradigm.rfc822.org>
In-Reply-To: <20080329095914.GA18263@paradigm.rfc822.org>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804021557.08605.technoboy85@gmail.com>
X-OriginalArrivalTime: 02 Apr 2008 13:57:17.0162 (UTC) FILETIME=[762654A0:01C894C9]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Saturday 29 March 2008 10:59:14 Florian Lohoff ha scritto:
> What i found in the TI code is that FIRST the local->control needs to
> get set before issueing a remote access so shouldnd the 
> 
> 	vlynq_reg_write(dev->remote ... )
> 
> move behind the dev->local ? I mean the logic is to set a local clock
> divisor - try to access something on the remote end and see if the link
> got up ?!?
> 
> Flo


dunno about the order, maybe "vlynq_reg_write(dev->remote->control, 0);"
and other NULL writes works as a reset...
