Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4QGXUnC020966
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 26 May 2002 09:33:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4QGXUY1020965
	for linux-mips-outgoing; Sun, 26 May 2002 09:33:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4QGXJnC020962;
	Sun, 26 May 2002 09:33:19 -0700
Received: from sohotower (adsl-66.218.38.74.dslextreme.com [66.218.38.74])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g4QGYYu08567;
	Sun, 26 May 2002 09:34:34 -0700
From: "Robert Rusek" <robru@teknuts.com>
To: "'Ralf Baechle'" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Executing IRIX binary ?
Date: Sun, 26 May 2002 09:34:50 -0700
Message-ID: <000701c204d3$47c94ae0$0a01a8c0@sohotower>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020525154426.A2481@dea.linux-mips.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This may be a stupid question but which IRIX libraries?  All of them?
When I try to execute a IRIX biniary I get the following:

bash: ./owsadm: No such file or directory

Do I need to something special?

Thanks,
Robert.

      -----Original Message-----
      From: owner-linux-mips@oss.sgi.com 
      [mailto:owner-linux-mips@oss.sgi.com] On Behalf Of Ralf Baechle
      Sent: Saturday, May 25, 2002 3:44 PM
      To: robru
      Cc: linux-mips@oss.sgi.com
      Subject: Re: Executing IRIX binary ?
      
      
      On Sat, May 25, 2002 at 12:06:29PM -0700, robru wrote:
      
      > How can I find out if I compiled my kernel with the 
      compatibility 
      > code?
      
      Make sure you have CONFIG_BINFMT_IRIX set in the kernel 
      configuration.
      
      You'll also need to install IRIX libraries.
      
        Ralf
      
