Received:  by oss.sgi.com id <S553996AbRAQB6j>;
	Tue, 16 Jan 2001 17:58:39 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:43261 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553992AbRAQB6b>; Tue, 16 Jan 2001 17:58:31 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870768AbRAQB5X>; Tue, 16 Jan 2001 23:57:23 -0200
Date:	Tue, 16 Jan 2001 23:57:23 -0200
From:	Jun Sun <jsun@mvista.com>
To:	linux-mips@oss.sgi.com
Subject: can kgdb display CP0 registers?
Message-ID: <3A64DC75.1ED33326@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Received: from gateway-1237.mvista.com ([12.44.186.158]:18935 "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP id <S553957AbRAPXnA>; Tue, 16 Jan 2001 15:43:00 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75]) by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0GNe9I15048; Tue, 16 Jan 2001 15:40:09 -0800
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Does anybody if I can use kgdb to display the register values in CP0 (such as
config, status, etc)?  I looked over the help pages but could not find it. 
However I am so sure about my ability of searching help pages. :-)

If not, that sounds like a very useful feature for MIPS targets, eh?

Jun
