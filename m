Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA02646
	for <pstadt@stud.fh-heilbronn.de>; Fri, 20 Aug 1999 01:11:53 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01327; Thu, 19 Aug 1999 16:08:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA72785
	for linux-list;
	Thu, 19 Aug 1999 15:59:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA24807
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 19 Aug 1999 15:59:56 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from paladin.real-time.com (paladin.real-time.com [206.10.252.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08309
	for <linux@cthulhu.engr.sgi.com>; Thu, 19 Aug 1999 15:59:53 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from real-time.com (mondas.dalekchess.org [206.147.104.202])
	by paladin.real-time.com (8.8.8/8.8.8) with ESMTP id RAA22465;
	Thu, 19 Aug 1999 17:56:07 -0500 (CDT)
Message-ID: <37BC8A94.289936FF@real-time.com>
Date: Thu, 19 Aug 1999 17:52:04 -0500
From: Cory Jon Hollingsworth <cory@real-time.com>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Hard Hat and Tandem.
References: <37B70CDF.D938EA0D@real-time.com> <19990818133932.A8965@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Sun, Aug 15, 1999 at 01:54:24PM -0500, Cory Jon Hollingsworth wrote:
>
> >     I have a Tandem model number CMN B006S that I'm trying to get Hard
> > Hat up and running on.  This is a machine build for Tandem by SGI and,
> > based on the descriptions I have read, I believe it is a close cousin to
> > the Challenge S.
>
> >     For instance an hinv returns:
> > Syestem: IP22
> > Processor: 150 Mhz R4400, with FPU
> > Primary I-cache size: 16 Kbytes
> > Primary D-cache size: 16 Kbytes
> > Secondary cache size: 1024 Kbytes
> > Memory size: 256 Mbytes
> > SCSI Disk: scsi(0)disk(1)
>
> Could you send me a the full hinv output, just to verify that this
> system is really an IP22 with no Tandem specific specials?
>

    Well the above is all that comes from a straight hinv.  I do get more if
I do an 'hinv -t' or 'hinv -t -p' though.  Half of the 'hinv -t -p' scrolls
off the screen and the information seems to be redundant anyway (4 lines to
describe serial port 1 for instance).

    Here is the output of an 'hinv -t'.

system ARC SGI-IP22 key 0
   processor CPU MIPS-R4400 key 0
    processor FPU MIPS-R4400FPC key 0
    cache primary icache 16 Kbytes (block 1 lines, line 16 bytes)
    cache primary dcache 16 Kbytes (block 1 lines, line 16 bytes)
    cache secondary cache 1024 Kbytes (block 1 lines, line 128 bytes)
    memory main 256 Mbytes
  controller network ec0 key 0
    peripheral network key 0
  adapter SCSI WD33C93B key 0
    controller disk SGI SEAGATE ST31230N key 1
      peripheral disk unit 0
  controller serial IP22 tty key 0
    peripheral line key 0
  controller serial IP22 tty key 1
    peripheral line key 0
  controller keyboard pc kbd key 0
  controller pointer pcms key 0
    peripheral pointer key 0

    Now I don't know what it means by keyboard and pointer.  The machine has
no keyboard or mouse port.  It does have two serial ports that look like PS/2
mouse ports though.  I'm running the dumb terminal off one right now.

> Further, what is the product name under which this Tandem was marketed?
> Is it CMN B006S?  I'd like to document the fact that this machine is
> (un?)supported in the Linux/MIPS docs.
>

    I don't know to both questions.  The only identification the outside of
the box is the above model name/number affixed to the bottom panel.  The box
is jet black  and says TANDEM in the lower right corner.  I've opened it up
and it has a copyright 1993 Silicon Graphics on one of the circuit boards,
but the machine is absent of any obvious identification.

<snip, snip>

> >     My question is: Can I get a precompiled vmlinux replacement for the
> > Hard Hat distribution which will allow me to continue with the
> > installation?   Or, since Tandem is not officially supported,  do I
> > spend the next couple of months hand assembling a root partition on the
> > machine from the bits I currently have working via NFS?
>
> There are several kernels in exactly the directory you got the initrd
> image from.
>

    Cool.  Any idea which one I should use?  Or should I try them all until I
find one that works?

>
> I have never heared about these Tandem machine but I assume that it it
> identical to the Indy rsp. Challenge S.
>

    Well I could give you a bastardized history lesson.  Bastardized in the
sense that I think I know the story, but could be wrong since I'm repeating
info that has been passed to me through multiple sources.

    Tandem was a company situated in Texas that was in the business of
selling business servers.  At the time this box was purchased, Tandem was
repackaging SGI hardware and selling them as Tandem servers.  Since then
Tandem has been bought by Compaq, which I believe where more or less bought
Tandem in order to acquire the brand name.  Currently I believe Compaq sells
industrial computers under the Tandem name.  I do not think those machines
have a MIPS chip set though.

    Keep in mind everything or anything I said in the above paragraph may be
wrong. 8-)  I'm just repeating hear say.

    I actually have a second Tandem box which is still a mystery box since it
requires a 220 outlet and the power grid in my apartment needs to be
customized to support it. 8-)  Once I get that monster up and running I'll
have to run an hinv to see what it has for guts.

    Thanks.

    Cory
