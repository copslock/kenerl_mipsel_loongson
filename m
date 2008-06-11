Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 11:53:28 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.243]:12242 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025437AbYFKKxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 11:53:25 +0100
Received: by an-out-0708.google.com with SMTP id d11so709092and.64
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2008 03:53:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=tK16nDURX+fBdd2iwvK12p+XVtEhh2WYxSYGULRFdp0=;
        b=Ece54CN2J31SOmCLvn/FYh3bIZIilt7Fp/kGgL4yoCZblF/CbOHxDlxZWkFmtneUK4
         fBYywPQGW6K62K0IUOU1L1jtKEfEe3XrNsIMTI4d5Akr7QvdGF2jOeiF+7Re5tdgELgP
         tvQLUPFMjOXVHMxIsG7A1ocIC51sU0qDaqbIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BHE9+AAmUga40wu+rcLfF50o5NLDqxlLJC4ircB0z8B4R/QZzknQF+A/hEwwlpCG4x
         PNvYrAi+D7WhIwqXfJ4Z8amgupsCYsW+Zdm8rT9H2TWvApjhQs3pI8ZhnX/LMcV/gIrT
         S1tm0LiS93+HR3YRgh1l+rVE5n0CQDHcLBI5U=
Received: by 10.100.229.12 with SMTP id b12mr7336275anh.60.1213181604106;
        Wed, 11 Jun 2008 03:53:24 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Wed, 11 Jun 2008 03:53:24 -0700 (PDT)
Message-ID: <64660ef00806110353p66608c43ta1e1995aef8b8f6f@mail.gmail.com>
Date:	Wed, 11 Jun 2008 11:53:24 +0100
From:	"Daniel Laird" <daniel.j.laird@googlemail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux kernel
Cc:	"Florian Fainelli" <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@googlemail.com
Precedence: bulk
X-list: linux-mips

On the second patch I submitted I changed platform.c as requested so
it registers all resources without the #ifdefs.
I also found that cpu_relax was not quite what i wanted so left the
while(1) loop for halt.

I have left printk kernel messages in as well (can remove if preferred).

If you require me to re-submit this second patch let me know (either
as attachment or inline).

I also split the ip3902, ip0105 and submitted to the i2c, netdev
mailing list and am awaiting feedback.

Daniel Laird
