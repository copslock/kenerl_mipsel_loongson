Received:  by oss.sgi.com id <S553899AbRAYA6A>;
	Wed, 24 Jan 2001 16:58:00 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:45918 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553854AbRAYA5k>;
	Wed, 24 Jan 2001 16:57:40 -0800
Received: from lappi.waldorf-gmbh.de (dhcp-163-154-5-208.engr.sgi.com [163.154.5.208]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA04843
	for <linux-mips@oss.sgi.com>; Wed, 24 Jan 2001 16:56:42 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870759AbRAYARA>; Wed, 24 Jan 2001 16:17:00 -0800
Date: 	Wed, 24 Jan 2001 16:17:00 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     John Van Horne <JohnVan.Horne@cosinecom.com>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        Paul Lambert <Paul.Lambert@cosinecom.com>
Subject: Re: MIPS platform recommendations
Message-ID: <20010124161700.E863@bacchus.dhis.org>
References: <7EB7C6B62C4FD41196A80090279A29113D7399@exchsrv1.cosinecom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7EB7C6B62C4FD41196A80090279A29113D7399@exchsrv1.cosinecom.com>; from JohnVan.Horne@cosinecom.com on Wed, Jan 24, 2001 at 11:23:00AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 11:23:00AM -0800, John Van Horne wrote:

> Can anyone recommend an R5000/R7000 machine
> which can run Linux 2.4 and would be an appropriate
> platform on which to build the libraries for an R5000/R7000
> embedded Linux application? Which platform has the
> most stable version of Linux 2.4 available?

I'm doing all this work on a SGI's Origin 200/2000 series machines.  They
may be a tad on the expensive side but they're the only thing that avoids
the major pain of having to modify large amounts of software for propper
crosscompilation and also has serious compute power.

  Ralf
