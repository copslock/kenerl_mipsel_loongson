Received:  by oss.sgi.com id <S305167AbQDETDv>;
	Wed, 5 Apr 2000 12:03:51 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23302 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQDETDe>; Wed, 5 Apr 2000 12:03:34 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA08201; Wed, 5 Apr 2000 12:07:19 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA38331
	for linux-list;
	Wed, 5 Apr 2000 11:52:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA73707
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Apr 2000 11:52:49 -0700 (PDT)
	mail_from (richardh@penguin.nl)
Received: from smtpf.casema.net (smtpf.casema.net [195.96.96.173]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA01718
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Apr 2000 11:52:42 -0700 (PDT)
	mail_from (richardh@penguin.nl)
Received: (qmail 6880 invoked by uid 0); 5 Apr 2000 18:52:37 -0000
Received: from unknown (HELO penguin.nl) (195.96.116.71)
  by smtpf.casema.net with SMTP; 5 Apr 2000 18:52:37 -0000
Message-ID: <38EB8BD1.8BB0AEB5@penguin.nl>
Date:   Wed, 05 Apr 2000 20:54:09 +0200
From:   Richard <richardh@penguin.nl>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Mike Hill <mikehill@hgeng.com>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
References: <E138DB347D10D3119C630008C79F5DEC2B9D7C@BART>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Hard Hat Linux Hard Hat release 5.1 (Manhattan)
> Kernel 2.3.21 on a mips
>
> login:
>
> My attempted root login is then declared invalid.  For my next trick I'll
> try pre-loading installfs/etc/passwd with a valid account, then re-running
> the installer.  Is there any reason this shouldn't work?

The reason your root login is not validated, is because Redhat doesn't allow
root logins over a tellnet session by default, and because of some stupid
decission  made once, it doesn't allow you to make a user account during
installation.

That's why you've had to change the setup-noarch.rpm to add a secure tty, to
login as root over a telnet session.

your /etc/passwd trick would also work

Richard
