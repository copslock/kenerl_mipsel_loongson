Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 23:12:14 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33434 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493597AbZKXWMI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Nov 2009 23:12:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOMCAEr020624;
        Tue, 24 Nov 2009 22:12:11 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOMC6Qn020621;
        Tue, 24 Nov 2009 22:12:06 GMT
Date:   Tue, 24 Nov 2009 22:12:06 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mikael Starvik <mikael.starvik@axis.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: SV: COP2 unaligned -> SIGBUS
Message-ID: <20091124221206.GA18693@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com> <20091123113820.GA4217@linux-mips.org> <20091123115619.GB4217@linux-mips.org> <20091124181704.GA14412@linux-mips.org> <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5B5E889@xmail3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5B5E889@xmail3.se.axis.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 07:40:38PM +0100, Mikael Starvik wrote:
> From: Mikael Starvik <mikael.starvik@axis.com>
> Date:   Tue, 24 Nov 2009 19:40:38 +0100
> To: Ralf Baechle <ralf@linux-mips.org>
> CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
> 	David Daney <ddaney@caviumnetworks.com>
> Subject: SV: COP2 unaligned -> SIGBUS
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Looks good! An alternative would of course be to add a COP2 kernel config that are selected by some MIPS machines.

And folks, please stop replying with a full patch quoted.  Full quote at
the end was always bloody annoying but if it's a even a patch it results
in a bogus entry in patchwork being created.
