Received:  by oss.sgi.com id <S305161AbQCWUHw>;
	Thu, 23 Mar 2000 12:07:52 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25470 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQCWUHb>; Thu, 23 Mar 2000 12:07:31 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04847; Thu, 23 Mar 2000 12:11:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA17082
	for linux-list;
	Thu, 23 Mar 2000 11:48:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA72863
	for <linux@engr.sgi.com>;
	Thu, 23 Mar 2000 11:48:38 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sirio.tecmor.mx (sirio.tecmor.mx [200.33.171.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02070
	for <linux@engr.sgi.com>; Thu, 23 Mar 2000 11:48:30 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from localhost (gnava@localhost)
	by sirio.tecmor.mx (8.9.3/8.9.3) with ESMTP id NAA07325
	for <linux@engr.sgi.com>; Thu, 23 Mar 2000 13:52:42 -0600
Date:   Thu, 23 Mar 2000 13:52:42 -0600 (CST)
From:   Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
To:     linux@cthulhu.engr.sgi.com
Subject: sendmail
Message-ID: <Pine.LNX.4.10.10003231348490.7267-100000@sirio.tecmor.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi

i installed sendmail.8.8.7 in my linux/indy box and when i try to
send some message, i got the error:

hash map "Alias0": unsafe map file /etc/aliases: No such file
hash map "junk": unsafe map file /etc/mail/deny: No such file    

but the files does exist

what can i do? 
is this the reason pine crashes before send a message?

thanks

Gabriel Nava Vazquez
Instituto Tecnologico de Morelia, Mexico
