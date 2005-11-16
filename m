Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 15:16:18 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:37386 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134058AbVKPPQA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 15:16:00 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAGFHxts013294;
	Wed, 16 Nov 2005 15:17:59 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAGFHxH1013293;
	Wed, 16 Nov 2005 15:17:59 GMT
Date:	Wed, 16 Nov 2005 15:17:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: What are the criteria for adding a port to linux-mips...
Message-ID: <20051116151758.GF3229@linux-mips.org>
References: <437A5287.9030506@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A5287.9030506@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 15, 2005 at 01:26:31PM -0800, David Daney wrote:

> As you probably know I posted patches for my ATI Xilleon port to this 
> list several weeks ago.  I am in the process of incorporating changes 
> based on the feedback I received.
> 
> I guess my question is fairly simple:
> 
> What hurdles must I overcome in order to get the port added to linux-mips?

I'm trying to handle this no different than Linus or the other subsystem
maintainers.  So, basically:

 - Code should comply to Documentation/CodingStyle
 - Code must be maintainable.
 - There probably will be issues raised when posting patches.  Fix them ...
 - In general I won't consider patches for "one of" ports.
   (You asked a general question, so this is a general answer.  Obviously
   this point isn't a problem for a SOC such as the Xilleon.)
 - A platform is worthless without drivers, so I want to see drivers in a
   shape where they're at least reasonably close to acceptable by the
   respective subsystem maintainers.
 - In the past it happened several times that people sent me their patches,
   I applied them and that's about the last I ever heared and so without
   no hardware, not hardware documentation and as always not enough time
   code starts bitrotting away.  I would realliy appreciate if in the
   future submitters would make an attempt to invest a little work it takes
   to keep their submitted code alive ...

  Ralf
