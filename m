Received:  by oss.sgi.com id <S42282AbQGSXlS>;
	Wed, 19 Jul 2000 16:41:18 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:12 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42280AbQGSXks>;
	Wed, 19 Jul 2000 16:40:48 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id QAA22325;
	Wed, 19 Jul 2000 16:40:15 -0700
Date:   Wed, 19 Jul 2000 16:40:15 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000719164012.B21310@chem.unr.edu>
References: <20000716182428.A972@foobazco.org> <20000717100534.D6424@chem.unr.edu> <20000718051828.A12440@bacchus.dhis.org> <20000718213310.A27016@chem.unr.edu> <20000719161012.B13006@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000719161012.B13006@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Jul 19, 2000 at 04:10:12PM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 04:10:12PM +0200, Ralf Baechle wrote:

> Funny.  It's unobvious why this happend but I gratefully accept this
> bug being fixed as well.  Now that this cure was so successful I'll have
> to research if mips64 is also affected.

Klaus and I have investiagated further. Apparently the problem does
not manifest itself with cp -rd or similar, but using tar cf - | tar
xf - does trigger it. It's not clear why this is.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
