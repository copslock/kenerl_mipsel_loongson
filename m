Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 21:34:07 +0100 (CET)
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:33947 "EHLO
	sj-msg-core-4.cisco.com") by linux-mips.org with ESMTP
	id <S1121743AbSKGUeG>; Thu, 7 Nov 2002 21:34:06 +0100
Received: from bbozarth-lnx.cisco.com (bbozarth-lnx.cisco.com [128.107.165.13])
	by sj-msg-core-4.cisco.com (8.12.2/8.12.2) with ESMTP id gA7KXuot004359;
	Thu, 7 Nov 2002 12:33:56 -0800 (PST)
Received: from localhost (bbozarth@localhost)
	by bbozarth-lnx.cisco.com (8.11.6/8.11.6) with ESMTP id gA7KXul10479;
	Thu, 7 Nov 2002 12:33:56 -0800
Date: Thu, 7 Nov 2002 12:33:55 -0800 (PST)
From: Bradley Bozarth <bbozarth@cisco.com>
To: linux-mips@linux-mips.org
cc: george@mvista.com
Subject: SEGEV defines
In-Reply-To: <Pine.GSO.3.96.1021107201241.5894L-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0211071229340.7794-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bbozarth@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbozarth@cisco.com
Precedence: bulk
X-list: linux-mips

Can these be changed?

> Now a question, why does mips use these values:                               
>  #define SIGEV_SIGNAL   129     /* notify via signal */                       
>  #define SIGEV_CALLBACK 130     /* ??? */                                     
>  #define SIGEV_THREAD   131     /* deliver via thread                         
> creation */                                                                   
>                                                                               
> It is the only platform that adds anything to the simple                      
> 1,2,3 values used on other platforms.  The reason I ask, is                   
> that I would like to change them to conform to all the                        
> others.
