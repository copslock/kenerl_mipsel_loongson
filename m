Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 15:45:27 +0100 (BST)
Received: from mail57.messagelabs.com ([IPv6:::ffff:195.245.230.115]:14522
	"HELO mail57.messagelabs.com") by linux-mips.org with SMTP
	id <S8225219AbUGTOpX>; Tue, 20 Jul 2004 15:45:23 +0100
X-VirusChecked: Checked
X-Env-Sender: martin.nichols@oxinst.co.uk
X-Msg-Ref: server-6.tower-57.messagelabs.com!1090334713!10747510
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [194.200.52.193]
Received: (qmail 18160 invoked from network); 20 Jul 2004 14:45:13 -0000
Received: from smtp1.oxinst.co.uk (HELO ukhontx01.oxinst.co.uk) (194.200.52.193)
  by server-6.tower-57.messagelabs.com with SMTP; 20 Jul 2004 14:45:13 -0000
Received: by UKHONTX01 with Internet Mail Service (5.5.2653.19)
	id <PGQJPK8L>; Tue, 20 Jul 2004 15:44:59 +0100
Message-ID: <DEF431FFDB15C1488464F0E57D5506642AA53A@MEDNT02>
From: martin.nichols@oxinst.co.uk
To: ddaney@avtrex.com
Cc: linux-mips@linux-mips.org
Subject: RE: Link errors
Date: Tue, 20 Jul 2004 15:47:58 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <martin.nichols@oxinst.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.nichols@oxinst.co.uk
Precedence: bulk
X-list: linux-mips

David,

Many thanks.
I should have Googled first ;)

Best regards,

Martin Nichols.

> -----Original Message-----
> From:	David Daney [SMTP:ddaney@avtrex.com]
> Sent:	19 July 2004 17:44
> To:	martin.nichols@oxinst.co.uk
> Cc:	linux-mips@linux-mips.org
> Subject:	Re: Link errors
> 
> martin.nichols@oxinst.co.uk wrote:
> > Hi All,
> > 
> > I'm new to MIPs architecture and Linux so apologies in advance!
> > 
> > I'm trying to build an application to run on the Au1100.
> > I have a crosscompiler setup (gcc 3.2) and can build a 'hello world'
> that
> > runs on the target.
> > When I try building a more serious application using Kdevelop - with the
> > appropriate settings
> > for the crosstools - I get lots of errors like this:
> > assert.o(.text+0x1cc): relocation truncated to fit: R_MIPS_GOT16
> > __assert_program_name
> >
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/mipsel-unkno
> wn
> > -linux-gnu/lib/libc.a(dcigettext.o): In function `_nl_find_msg':
> > dcigettext.o(.text+0x153c): relocation truncated to fit: R_MIPS_CALL16
> > _nl_load_domain
> >
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/mipsel-unkno
> wn
> > -linux-gnu/lib/libc.a(finddomain.o): In function `_nl_find_domain':
> > 
> > Could someone tell me what I'm doing wrong please.
> > 
> This is the got overflow problem.
> 
> Later versions of binutils have multi-got support (2.15 for example),
> which under most circumstances will fix the problem.
> 
> If you have extreamly large compilation units you might have to use a
> 32bit got index.  In GCC3.4 and later this is done with the -mxgot
> option.  With eariler versions of GCC you have to pass -xgot to the
> assembler (-Wa,-xgot IIRC).
> 
> David Daney.
> 
> 
> +++ Virus-scanned by Messagelabs for Oxford Instruments +++
> 
 ###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ### 

Unless stated above to be non-confidential, this E-mail and any 
attachments are private and confidential and are for the addressee 
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt 
and delete it from your records. Internet communications are not secure 
and Oxford Instruments is not responsible for their abuse by third 
parties nor for any alteration or corruption in transmission. 
