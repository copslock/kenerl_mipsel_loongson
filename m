Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PJ5HnC004287
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 12:05:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PJ5Gqb004286
	for linux-mips-outgoing; Sat, 25 May 2002 12:05:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PJ59nC004283;
	Sat, 25 May 2002 12:05:09 -0700
Received: from sohotower (adsl-66.218.38.74.dslextreme.com [66.218.38.74])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g4PJ6Kv02117;
	Sat, 25 May 2002 12:06:20 -0700
From: "robru" <robru@teknuts.com>
To: "'Ralf Baechle'" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Executing IRIX binary ?
Date: Sat, 25 May 2002 12:06:29 -0700
Message-ID: <000701c2041f$4d2ae7f0$0a01a8c0@sohotower>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020525002723.A27302@dea.linux-mips.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

How can I find out if I compiled my kernel with the compatibility code?

Thanks,
Robert.

      -----Original Message-----
      From: owner-linux-mips@oss.sgi.com 
      [mailto:owner-linux-mips@oss.sgi.com] On Behalf Of Ralf Baechle
      Sent: Saturday, May 25, 2002 12:27 AM
      To: Robert Rusek
      Cc: linux-mips@oss.sgi.com
      Subject: Re: Executing IRIX binary ?
      
      
      On Wed, May 22, 2002 at 04:01:07PM -0700, Robert Rusek wrote:
      
      > Is there anyway to run/execute irix 5/6 binaries in 
      linux mips on an 
      > Indy?  Good old Microsoft does not provide the source for it's 
      > frontpage extensions, but they do provide a binary for IRIX.
      
      We have IRIX5 binary compatibility code in the kernel but 
      I don't have any reports about it's status ever since I 
      integrated those patch in about May '97.
      
        Ralf
      
