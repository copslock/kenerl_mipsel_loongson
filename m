Received:  by oss.sgi.com id <S42187AbQJKT2w>;
	Wed, 11 Oct 2000 12:28:52 -0700
Received: from [206.207.108.63] ([206.207.108.63]:49964 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S42180AbQJKT2R>; Wed, 11 Oct 2000 12:28:17 -0700
Received: (qmail 15014 invoked from network); 11 Oct 2000 13:19:27 -0600
Received: from randys-personal.ridgerun.cxm (HELO randyspersonal) (192.168.1.216)
  by ridgerun-lx.ridgerun.cxm with SMTP; 11 Oct 2000 13:19:27 -0600
From:   "Randy Sartin" <randys@ridgerun.com>
To:     <linux-mips@oss.sgi.com>
Subject: rs_ioctl() in sgiserial.c info/help needed
Date:   Wed, 11 Oct 2000 13:28:05 -0600
Message-ID: <NEBBLGAKILMAGOFHJDNNGEJMCAAA.randys@ridgerun.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Background:
I am trying to get the Indy's serial port to drive a dongle and am having
some trouble getting the dongle to work. The problem seems to be in
rs_ioctl() in sgiserial.c - it doesn't handle the TIOCMSET command. The
TIOCMSET command allows control over the DTR and RTS lines.

The "standard" rs_ioctl() in serial.c does support TIOCMSET. It calls
set_modem_info() to control the UART (I think) to then control DTR and RTS.

So - my question is...
Can I control DTR and RTS on Indy or is this a software feature that hasn't
been implemented yet?

Thanks,
Randy Sartin
