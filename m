Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RLulnC017214
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 14:56:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RLulVK017213
	for linux-mips-outgoing; Mon, 27 May 2002 14:56:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RLudnC017209;
	Mon, 27 May 2002 14:56:42 -0700
Received: from sohotower (adsl-66.218.38.74.dslextreme.com [66.218.38.74])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g4RLvsa02522;
	Mon, 27 May 2002 14:57:54 -0700
From: "Robert Rusek" <robru@teknuts.com>
To: <flo@rfc822.org>
Cc: "'Ralf Baechle'" <ralf@oss.sgi.com>, <linux-mips@oss.sgi.com>
Subject: RE: Executing IRIX binary ?
Date: Mon, 27 May 2002 14:58:15 -0700
Message-ID: <001d01c205c9$9d8faf40$0a01a8c0@sohotower>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020527211513.GE32064@paradigm.rfc822.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have IRIX binary support turned on in the kernel.  I can copy over my
IRIX libs from my old IRIX partition (I just do not know which ones).  I
don't think I have the dynamic loader?  How would I check to see if I
have it?  If not where would I get it?  Sorry about all these newbie
questions it is just that I need to be able to run the IRIX version of
fronpage server extensions since MS does not provide the open source.

Thanks,
Robert.

      -----Original Message-----
      From: flo@rfc822.org [mailto:flo@rfc822.org] 
      Sent: Monday, May 27, 2002 2:15 PM
      To: Robert Rusek
      Cc: 'Ralf Baechle'; linux-mips@oss.sgi.com
      Subject: Re: Executing IRIX binary ?
      
      
      On Mon, May 27, 2002 at 01:32:43PM -0700, Robert Rusek wrote:
      > Ralf,
      > 
      > Looks like I have the kernal compiled with the IRIX 
      binary support.  
      > How do I go about executing the binaries?  When I try 
      to execute it 
      > tells me that the file is not found.
      
      Are you shure you have the dynamic loader + libc + other 
      libs of IRIX installed in your system ?
      
      Flo
      -- 
      Florian Lohoff                  flo@rfc822.org            
       +49-5201-669912
                              Heisenberg may have been here.
      
