Received:  by oss.sgi.com id <S42371AbQFVGxw>;
	Wed, 21 Jun 2000 23:53:52 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:43288 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42190AbQFVGxe>;
	Wed, 21 Jun 2000 23:53:34 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id XAA12420
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 23:48:37 -0700 (PDT)
	mail_from (roald@stavanger.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id XAA31939 for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 23:53:03 -0700 (PDT)
Received: from sgstv.stavanger.sgi.com (sgstv.stavanger.sgi.com [144.253.219.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA53946
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 23:51:15 -0700 (PDT)
	mail_from (roald@stavanger.sgi.com)
Received: by sgstv.stavanger.sgi.com (980427.SGI.8.8.8/940406.SGI)
	 id IAA32492; Thu, 22 Jun 2000 08:51:16 +0200 (MEST)
From:   "Roald Lygre" <roald@stavanger.sgi.com>
Message-Id: <10006220851.ZM533158@sgstv.stavanger.sgi.com>
Date:   Thu, 22 Jun 2000 08:51:15 +0200
In-Reply-To: Paul Jakma <paul@clubi.ie>
        "RE: Problems with multiple harddisks on my Indigo2" (Jun 21, 10:38pm)
References: <Pine.LNX.4.21.0006212234190.5050-100000@fogarty.jakma.org>
Reply_To: roald@stavanger.sgi.com
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To:     Paul Jakma <paul@clubi.ie>,
        Ian Chilton <mailinglist@ichilton.co.uk>
Subject: Re: Problems with multiple harddisks on my Indigo2
Cc:     spock@mgnet.de, Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Jun 21, 10:38pm, Paul Jakma wrote:
> Subject: RE: Problems with multiple harddisks on my Indigo2
> On Wed, 21 Jun 2000, Ian Chilton wrote:
>
>
> 3. Perhaps cause the outboard SCSI port is not terminated. (least not
> on my indy)
>

The SCSI port should be terminated with an active terminator on the Indy,
regardless of if you have 1 or 2 drives installed.

-Roald



-- 
    
---------------------------------------------------------------
| Company: SGI Norge A/S                                      |
| Email:   roald@sgi.com          Tlf:          +47 5163 4183 |
| Addr:    Luramyrveien 79        Mobil:        +47 909 33 903|
|          N-4313 Sandnes         VMail (SGI):  870-4679      |
|          NORWAY                 VMail(ext):   +47 6711 4679 |
---------------------------------------------------------------
Essential SGI Websites:
http://www.sgi.com/             SGI
http://www.sgi.no/              SGI Norge
http://support-europe.sgi.com/  Log calls, patches+overlays, ++
http://freeware.sgi.com/        Freeware - "ready-to-eat"
http://oss.sgi.com/mips/        Linux for SGI (Mips/Intel)
http://www.sgi.com/developers/  Developer Central
http://www.sgi.com/Products/Evaluation/   Evaluation Software
