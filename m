Received:  by oss.sgi.com id <S553783AbQKNS4u>;
	Tue, 14 Nov 2000 10:56:50 -0800
Received: from u-177.karlsruhe.ipdial.viaginterkom.de ([62.180.10.177]:32516
        "EHLO u-177.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553655AbQKNS4f>; Tue, 14 Nov 2000 10:56:35 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870065AbQKNQQq>;
        Tue, 14 Nov 2000 17:16:46 +0100
Date:   Tue, 14 Nov 2000 17:16:46 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: Cross_compiler!
Message-ID: <20001114171646.B1117@bacchus.dhis.org>
References: <3A09DE18.E55FA70F@isratech.ro> <3A09ADDB.EA2A6246@mvista.com> <20001112211057.E15594@bacchus.dhis.org> <3A103DAE.463492A4@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A103DAE.463492A4@mvista.com>; from jsun@mvista.com on Mon, Nov 13, 2000 at 11:14:54AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Nov 13, 2000 at 11:14:54AM -0800, Jun Sun wrote:

> My weekend was just fine - without reading this bothersome email. :-)
> 
> I thought egcs-1.1.2 had some problems with binutil 2.8.1 and glibc
> 2.0.6.  Was the problem solved?  

Kindof.  I just dumped the multilib support.  I don't know of anybody who
was actually using it, so away with it ...

  Ralf
