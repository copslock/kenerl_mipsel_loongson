Received:  by oss.sgi.com id <S553815AbQJ0PZL>;
	Fri, 27 Oct 2000 08:25:11 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36378 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553756AbQJ0PYw>; Fri, 27 Oct 2000 08:24:52 -0700
Received: from conejo.engr.sgi.com (conejo.engr.sgi.com [130.62.50.34]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA04623
	for <linux-mips@oss.sgi.com>; Fri, 27 Oct 2000 08:29:31 -0700 (PDT)
	mail_from (rsanders@conejo.engr.sgi.com)
Received: (from rsanders@localhost)
	by conejo.engr.sgi.com (SGI-8.9.3/8.9.3) id IAA02554
	for linux-mips@oss.sgi.com; Fri, 27 Oct 2000 08:18:00 -0700 (PDT)
Date:   Fri, 27 Oct 2000 08:18:00 -0700 (PDT)
From:   "Robert M. Sanders" <rsanders@conejo.engr.sgi.com>
Message-Id: <200010271518.IAA02554@conejo.engr.sgi.com>
To:     linux-mips@oss.sgi.com
Subject: Re: http://cgi.ebay.com/aw-cgi/eBayISAPI.dll?ViewItem&item=480274822
In-Reply-To: <0A5319EEAF65D411825E00805FBBD8A1209AB8@exchange.clt.ixl.com>
X-Status: N
X-Mailer: Applixware 4.41 (1021.286.3)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> http://cgi.ebay.com/aw-cgi/eBayISAPI.dll?ViewItem&item=480274822
> 
> do these seem ok for use in an Indy?
> 

Nope.  they must have Gold pins, otherwise there will be metal migration.  Use 
for a short time might be ok.  Also, there is no statement of their speed they 
must be 70 ns or faster.

Best bet is to go to Crucial's or Dataram's website and at least get the spec's 
for their replacement SIMMs.  Then use those to compare against the stuff on 
E'bay.

Also, consider that unless you're going to run IRIX 6.5.x, 32 Mb or 64 MB is fine 
for Linux and 2D graphics.  Under IRIX 6.5.x, 64MB is the starting point but the 
system will be slow.  128MB or 192MB is much better - 128Mb allows Netscape to 
fire up with swapping.

Also, flakey memory will cause all sorts of problems and kernel panics.  And not 
just on SGI hardware, but on a common PC.  Do not use junk memory, you'll be 
debugging lots of problems that do not appear to be memory related and transient 
in nature.

Bob
