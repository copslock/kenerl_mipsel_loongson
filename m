Received:  by oss.sgi.com id <S553903AbQKDDDz>;
	Fri, 3 Nov 2000 19:03:55 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:1551 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553899AbQKDDDf>;
	Fri, 3 Nov 2000 19:03:35 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id TAA15781;
	Fri, 3 Nov 2000 19:03:01 -0800
Date:   Fri, 3 Nov 2000 19:03:01 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Kernel compiler
Message-ID: <20001103190301.A15760@chem.unr.edu>
References: <20001103221926.A26082@bacchus.dhis.org> <5029.973305862@ocs3.ocs-net> <20001104035326.A29005@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001104035326.A29005@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Nov 04, 2000 at 03:53:26AM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 04, 2000 at 03:53:26AM +0100, Ralf Baechle wrote:

> The reports regarding egcs 2.96 and newer misscompiling the kernel only
> affect x86 or are other architecture affected as well?  I don't have any
> pending compiler >= 2.96 related bug reports.

Somewhere between 1019 and 1023, a bug was introduced which causes
miscompilation. Symptom is oops on boot during RPC port lookups. I
don't know if this is still present, nor the exact nature of the
bug. It appears that some address offsets changed in the compiled code
from gcc 1019 to gcc 1023.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
