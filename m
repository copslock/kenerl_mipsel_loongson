Received:  by oss.sgi.com id <S553793AbQJYN0a>;
	Wed, 25 Oct 2000 06:26:30 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:64076 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553788AbQJYN0N>;
	Wed, 25 Oct 2000 06:26:13 -0700
Received: from conejo.engr.sgi.com (conejo.engr.sgi.com [130.62.50.34]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA27727
	for <linux-mips@oss.sgi.com>; Wed, 25 Oct 2000 06:18:25 -0700 (PDT)
	mail_from (rsanders@conejo.engr.sgi.com)
Received: (from rsanders@localhost)
	by conejo.engr.sgi.com (SGI-8.9.3/8.9.3) id GAA01942
	for linux-mips@oss.sgi.com; Wed, 25 Oct 2000 06:24:56 -0700 (PDT)
Date:   Wed, 25 Oct 2000 06:24:56 -0700 (PDT)
From:   "Robert M. Sanders" <rsanders@conejo.engr.sgi.com>
Message-Id: <200010251324.GAA01942@conejo.engr.sgi.com>
To:     linux-mips@oss.sgi.com
Subject: Re: RE: putting together an Indy
In-Reply-To: <0A5319EEAF65D411825E00805FBBD8A1209A65@exchange.clt.ixl.com>
X-Status: N
X-Mailer: Applixware 4.41 (1021.286.3)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> http://cgi.ebay.com/aw-cgi/eBayISAPI.dll?ViewItem&item=474141593
> 
> will this work in an Indy?
> 

No an Indy uses standard SIMMS, ECC style and requires them in groups of 4.  
However, due to timing considerations the SIMMS need to be of good quality 70 ns 
or better and must be ECC, ie. 72 bit.

Bob
