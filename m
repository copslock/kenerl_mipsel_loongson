Received:  by oss.sgi.com id <S42297AbQFMSe7>;
	Tue, 13 Jun 2000 11:34:59 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:47425 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42289AbQFMSeh>; Tue, 13 Jun 2000 11:34:37 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA05790
	for <linux-mips@oss.sgi.com>; Tue, 13 Jun 2000 12:39:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA29077
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Jun 2000 12:34:12 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-76.karlsruhe.ipdial.viaginterkom.de (u-76.karlsruhe.ipdial.viaginterkom.de [62.180.19.76]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA05280
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jun 2000 12:34:10 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1406584AbQFMTeA>;
        Tue, 13 Jun 2000 21:34:00 +0200
Date:   Tue, 13 Jun 2000 21:34:00 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Huseyin Sasmaz <Huseyin@sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Problem on booting linux on Indy
Message-ID: <20000613213400.C19633@uni-koblenz.de>
References: <9496A27F9004D411AF890090278610F3017001@nt-emea-trbdc.istanbul.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9496A27F9004D411AF890090278610F3017001@nt-emea-trbdc.istanbul.sgi.com>; from Huseyin@sgi.com on Tue, Jun 13, 2000 at 02:15:38PM +0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 13, 2000 at 02:15:38PM +0300, Huseyin Sasmaz wrote:

> I would like to install the redhat 5.1 to my indy. I am getting the
> following error messages after the vmlinux is booted ;
> 
> Looking up port of RPC 100003/2 on 144.253.232.3  <----- This my bootp
> server and nfs server which is O2.
> sendmsg returned error 128
> ..
> ..
> ..
> portmap server 144.253.232.3 not responding, timed out.

Error 128 is ENETUNREACH, network unreachable.  Some network configuration
problem?

  Ralf
