Received:  by oss.sgi.com id <S553792AbQJZXjy>;
	Thu, 26 Oct 2000 16:39:54 -0700
Received: from u-208.karlsruhe.ipdial.viaginterkom.de ([62.180.19.208]:29958
        "EHLO u-208.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553785AbQJZXja>; Thu, 26 Oct 2000 16:39:30 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870673AbQJZXip>;
        Fri, 27 Oct 2000 01:38:45 +0200
Date:   Fri, 27 Oct 2000 01:38:45 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: a REALLY, REALLY nasty bug
Message-ID: <20001027013845.C1056@bacchus.dhis.org>
References: <39F79EF8.9029AE6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F79EF8.9029AE6@mvista.com>; from jsun@mvista.com on Wed, Oct 25, 2000 at 08:03:20PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 08:03:20PM -0700, Jun Sun wrote:

> I am sure Ralf will have something to say about it.  :-)  In any case, I
> attached a patch for 1) fix.

A fix that is less easily affected by compiler overoptmizations is contained
in 2.2; I'll merge it forward into 2.4.  Dunno how that didn't make it
into 2.4.

Time for a brown paper bag.

  Ralf
