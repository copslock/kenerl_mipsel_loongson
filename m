Received:  by oss.sgi.com id <S42258AbQGSEeT>;
	Tue, 18 Jul 2000 21:34:19 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:34570 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42235AbQGSEdy>;
	Tue, 18 Jul 2000 21:33:54 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id VAA27188;
	Tue, 18 Jul 2000 21:33:16 -0700
Date:   Tue, 18 Jul 2000 21:33:15 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000718213310.A27016@chem.unr.edu>
References: <20000716182428.A972@foobazco.org> <20000717100534.D6424@chem.unr.edu> <20000718051828.A12440@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000718051828.A12440@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jul 18, 2000 at 05:18:28AM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 18, 2000 at 05:18:28AM +0200, Ralf Baechle wrote:

> Indeed, it does.  I've commited a patch for this bug to cvs and would like
> to hear reports.

I am pleased to report that without this fix I observe the
oft-reported problem when using two disks simultaneously on IP22:

  SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 27010000
   I/O error: dev 08:11, sector 1885720

but with this fix I no longer see this. How many more bugs will this
fix I wonder...

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
