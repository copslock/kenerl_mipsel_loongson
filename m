Received:  by oss.sgi.com id <S553760AbQJRWhp>;
	Wed, 18 Oct 2000 15:37:45 -0700
Received: from u-11.karlsruhe.ipdial.viaginterkom.de ([62.180.19.11]:27918
        "EHLO u-11.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553669AbQJRWhU>; Wed, 18 Oct 2000 15:37:20 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868995AbQJRWhC>;
        Thu, 19 Oct 2000 00:37:02 +0200
Date:   Thu, 19 Oct 2000 00:37:02 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
Message-ID: <20001019003702.B12745@bacchus.dhis.org>
References: <39E7EB73.9206D0DB@mvista.com> <39ED2166.9B5F970@mvista.com> <20001018035719.F7865@bacchus.dhis.org> <20001018143003.C2354@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001018143003.C2354@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Oct 18, 2000 at 02:30:03PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 18, 2000 at 02:30:03PM +0200, Florian Lohoff wrote:

> By thinking about this without any knowledge of the binutils code generation.
> 
> How does this work if loop is only an external symbol ? The distance
> will than be relevant when linking but then the code will already be there
> and one would need to insert an instruction.

Branches to external symbols aren't allowed with MIPS ELF objects.

  Ralf
