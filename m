Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 12:12:23 +0000 (GMT)
Received: from relay4.aport.ru ([194.67.18.135]:2720 "HELO relay4.aport.ru")
	by ftp.linux-mips.org with SMTP id S8133821AbWASMMF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 12:12:05 +0000
Received: (qmail 11433 invoked from network); 19 Jan 2006 12:15:53 -0000
Received: from webmail.aport.ru ([194.67.18.2]) (envelope-sender <olegol@aport.ru>)
          by relay4.aport.ru
          for <linux-mips@linux-mips.org>; 19 Jan 2006 12:15:53 -0000
Content-Type: text/plain; charset="koi8-r"
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Message-Id: <FU-CvJRDLOVoZrY@aport2000.ru>
X-Originating-Ip: [175.37.2.205, 217.147.104.220]
Subject: GTK/GLIB port for mipsel
From:	olegol@aport.ru
X-Mailer: Aport Webmail 2.2
Date:	Thu, 19 Jan 2006 15:15:53 +0300
To:	linux-mips@linux-mips.org
Return-Path: <olegol@aport.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olegol@aport.ru
Precedence: bulk
X-list: linux-mips

Hello,

I'm working on building (cross-compiling) GTK for mipsel.
Currently I'm in the process of installing GLIB. I could 
manage to successfully pass its configure script, but 
when running make I get an error on the gatomic.c 
(unsupported asm instructions). Looking there I've found 
out that there is no port for mipsel (neither mips) for 
that functionality. I checked in the glib CVS, and there 
is nothing about that there either.
Anyway, I suspect that porting of glib is more than just 
writing these 50 lines of asm code, so probably I need a 
mipsel port.
Unfortunately, I could not find the port in the internet -
 the only reference I've found is the Debian mipsel port, 
but it contains only binaries in libraries' packets. 
Supposedly there are source packages available from this 
page: http://packages.debian.org/stable/libs/libglib2.0-0
but trying to download it I constantly see the 
message "packages.debian.org is down at the moment due to 
performance issues."

Can anybody here point me to a source where I can 
download a glib and gtk ports for mipsel, or at least get 
more info on this.

With respect,
Oleg Kruzhkov
