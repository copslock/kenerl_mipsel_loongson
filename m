Received:  by oss.sgi.com id <S305180AbQADV77>;
	Tue, 4 Jan 2000 13:59:59 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:62520 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305166AbQADV7z>;
	Tue, 4 Jan 2000 13:59:55 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04016; Tue, 4 Jan 2000 14:00:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA94496
	for linux-list;
	Tue, 4 Jan 2000 13:56:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from nodin.corp.sgi.com ([198.29.75.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA64112
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Jan 2000 13:56:33 -0800 (PST)
	mail_from (eak@detroit.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA45226; Tue, 4 Jan 2000 13:56:32 -0800 (PST)
Received: from cygnus.detroit.sgi.com (cygnus.detroit.sgi.com [169.238.130.2]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA15349; Tue, 4 Jan 2000 16:56:31 -0500 (EST)
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA40088; Tue, 4 Jan 2000 16:56:30 -0500 (EST)
Message-ID: <38726C8D.D912DF94@detroit.sgi.com>
Date:   Tue, 04 Jan 2000 16:56:29 -0500
From:   Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Jiri Kastner jr." <indy@arcom.cz>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
References: <00010422480200.01013@pingu.kastner.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

"Jiri Kastner jr." wrote:
> 
> I have installed XFree86-FBDev, but everytime, when I want to start X, I get
> message, that is missing /dev/fb0, and I dont know, how to make it (MAKEDEV
> dont know anything about fb* devices).
> 
> Jiri Kastner.

You have to enable it in your kernel. 
-- 
.--------1---------2---------3---------4---------5---------6---------7.
  Eric Kimminau           eak@sgi.com       SGI Extranet Services
      Vox:650-933-6441  Fax:248-618-9178  VNET:6-933-6441  
              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
