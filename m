Received:  by oss.sgi.com id <S42275AbQGSWrr>;
	Wed, 19 Jul 2000 15:47:47 -0700
Received: from u-185.karlsruhe.ipdial.viaginterkom.de ([62.180.21.185]:61702
        "EHLO u-185.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42280AbQGSWrB>; Wed, 19 Jul 2000 15:47:01 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S640294AbQGSOKM>;
        Wed, 19 Jul 2000 16:10:12 +0200
Date:   Wed, 19 Jul 2000 16:10:12 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000719161012.B13006@bacchus.dhis.org>
References: <20000716182428.A972@foobazco.org> <20000717100534.D6424@chem.unr.edu> <20000718051828.A12440@bacchus.dhis.org> <20000718213310.A27016@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000718213310.A27016@chem.unr.edu>; from wesolows@chem.unr.edu on Tue, Jul 18, 2000 at 09:33:15PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 18, 2000 at 09:33:15PM -0700, Keith M Wesolowski wrote:

> > Indeed, it does.  I've commited a patch for this bug to cvs and would like
> > to hear reports.
> 
> I am pleased to report that without this fix I observe the
> oft-reported problem when using two disks simultaneously on IP22:
> 
>   SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 27010000
>    I/O error: dev 08:11, sector 1885720
> 
> but with this fix I no longer see this. How many more bugs will this
> fix I wonder...

Funny.  It's unobvious why this happend but I gratefully accept this
bug being fixed as well.  Now that this cure was so successful I'll have
to research if mips64 is also affected.

  Ralf
