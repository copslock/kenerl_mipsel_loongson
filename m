Received:  by oss.sgi.com id <S305171AbQCZA0L>;
	Sat, 25 Mar 2000 16:26:11 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34369 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQCZAZy>;
	Sat, 25 Mar 2000 16:25:54 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA25439; Sat, 25 Mar 2000 16:21:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA39297
	for linux-list;
	Sat, 25 Mar 2000 16:16:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA38992
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Mar 2000 16:16:09 -0800 (PST)
	mail_from (miod@Montlucon-5-183.club-internet.fr)
Received: from Montlucon-5-183.club-internet.fr (Montlucon-5-183.club-internet.fr [195.36.176.183]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08857
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Mar 2000 16:16:06 -0800 (PST)
	mail_from (miod@Montlucon-5-183.club-internet.fr)
Received: (from miod@localhost)
	by Montlucon-5-183.club-internet.fr (8.8.7/8.8.7) id AAA01678;
	Sun, 26 Mar 2000 00:26:07 GMT
Date:   Sun, 26 Mar 2000 00:26:06 +0000
From:   Miod Vallat <miodrag@ifrance.com>
To:     =?iso-8859-1?Q?Carlos_Ernesto_L=F3pez_Natar=E9n?= 
        <natorro@themis.fciencias.unam.mx>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: How can I know my hardware address for my ethernet card???
Message-ID: <20000326002606.J1332@localhost.localdomain>
References: <38D04A3F.42E3029A@themis.fciencias.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <38D04A3F.42E3029A@themis.fciencias.unam.mx>; from natorro@themis.fciencias.unam.mx on Wed, Mar 15, 2000 at 08:43:11PM -0600
X-Mailer-Holy-War: Get Mutt, it bites!
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> how can I know the hardware address for my ethernet card????
> I just can't figure it out... :-(
Start your machine, choose ``Stop for maintainance'' during aerly boot, then
``enter command monitor'' and type ``printenv eaddr''.

Miod
