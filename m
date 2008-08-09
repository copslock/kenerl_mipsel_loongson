Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Aug 2008 17:26:20 +0100 (BST)
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:34717 "HELO
	web25805.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28584559AbYHIQ0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Aug 2008 17:26:09 +0100
Received: (qmail 65598 invoked by uid 60001); 9 Aug 2008 16:26:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=FbLi83cMXvdSsavLvgMzFbQ92z5vqlEGqtPX3hP/JRv23+wSGAsz8dfWE4ikfJfejAAQwBQFjBm7oBFlX0IVgYD+QCqDEvaeXvnMtwdHHJkYDIX2aMaYTzJJ2cft1/a4/m6lJnx2Ky86iiomeQ0HN8RK/l2m7/tib6HDWOoUuPc=;
Received: from [87.114.137.160] by web25805.mail.ukl.yahoo.com via HTTP; Sat, 09 Aug 2008 16:26:01 GMT
X-Mailer: YahooMailWebService/0.7.218
Date:	Sat, 9 Aug 2008 16:26:01 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Reply-To: glynastill@yahoo.co.uk
Subject: debian binutils package
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <715357.65421.qm@web25805.mail.ukl.yahoo.com>
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips

Running debian etch on a cobalt qube, having trouble compiling postgres.

It appears my issue is something to do with the as or ld commands from binutils.

Switching from the latest postgres release to the latest cvs head which links differently works.

The chaps on the netbsd list seem to have observed similar too.


      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
