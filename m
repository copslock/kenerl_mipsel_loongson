Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15626; Tue, 11 Jun 1996 15:55:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA00759 for linux-list; Tue, 11 Jun 1996 22:55:12 GMT
Received: from storm.engr.sgi.com (storm.engr.sgi.com [192.26.79.92]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA00750 for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jun 1996 15:55:10 -0700
Received: by storm.engr.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	for linux id PAA26486; Tue, 11 Jun 1996 15:53:48 -0700
Date: Tue, 11 Jun 1996 15:53:48 -0700
From: yobs@storm.engr.sgi.com (Donna Yobs)
Message-Id: <199606112253.PAA26486@storm.engr.sgi.com>
To: linux@storm.engr.sgi.com
Subject: nt...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hate to muddy the waters, but a customer has asked
about getting some basic tools onto NT so that we
can interop better.  Hoping someone in this group
may have some insight, I'm including the email. Let
me know if you have any ideas.  I'm trying to iron
out a list of what we should do to have a better
PC friendly view of the world, without going to NT.

thanks

-- included text --
        The type of NT tools that I would be looking for is as follows:

        Our company writes glue to tie many of the entertainment type
        applications together.  We have translaters, display tools,
        programs that scan disk directories and verify that all the 
        frames of a shot are present, etc.  For example, we have a small
        program that sircheck (for Solitair Image Recorder Check) that
        opens each frame of a shot and reads the header to make sure
        that all the frames are of the same resolution.  If you have
        been doing a shot at video res and rerender at 2k resolution,
        It is possible that all of the frames are present, but that
        one of them is still the old version.  The most common mistake
        is to copy frames 1-99 and then 101-199 skipping frame 100.

        Customers now have NT workstations -- whether for 3Dstudio, 
        lightwave, Softimage, or whatever.  We are being asked for
        the ability to execute sircheck from an NT workstation so that
        the files can be verified by the animator before he turns the
        tape over to the guy who will be shooting the shot on an SGI
        workstation.  This utility is part of what makes our film
        recorder package more attractive than the competition.  Failure
        to respond to this kind of request would make our company
        appear less responsive in a business that borders on the edge
        of custom consultation.  We have been exclusively SGI based
        since 1984, and have very little NT experience.  Most of our
        utilities have some kind of GL or OpenGL based GUI.  I am
        looking for any help to run this kind of program on NT.  There
        is no high performance graphics involved.  Nor do I wish to
        redesign the interface to match NT style.  I think I can do
        some of what I want with the software GL emulator that was
        presented for Windows 95.  I need some no cost software like 
        that GL package.
        In addition, I need low level stuff like what is in the 
        developers toolbox.  Readers and writers and low level chunks.

        For example, we need the ability to read SGI .rgb format files
        on NT.  The net abounds with utilities for Unix type things on
        NT, such as tar.  I spoke with the toolbox janitors about 
        collecting these type of utilities and seeing which ones support
        the IRIX versions.  For example, finding or adapting a public
        domain NT tar package such that it will easily recognize and
        handle the default SGI tar block sizes and byte order.  Our
        customers are artists and animators, not computer programmers.
        They need the ability to read tapes, translate files, and in
        general, go back and forth between tools and packages without
        typing a 60 character command line.  They need more than an
        NFS mounted partition shared between the SGI and NT.  What good
        is an NFS mounted partition if you can't read the file format?

        The developers toolbox is a wouderful, useful, and esential
        effort.  It contains much public stuff cleansed for use with
        SGI machines.  I believe that if the effort is expanded to
        include tools for NT that would enable SGI machines to better
        fit into a mixed environment, our ability to sell SGI into
        these accounts would be greatly enhanced.  Right now, I am
        under a lot of pressure to port our whole film recorder to
        NT.  This would be a big project, and one I am not wild about.
        If I can not make it easier for SGI's and NT to co-exist, we
        will have to give it serious thought.

        I hope this answers some of your questions.  I see that my
        sticky keyboard has played havok with my spelling.  I can not
        seem to find a decent mail package that can work between my
        PC and the SGI mailhost that we have at RFX.  Another example
        of problems working with NT and SGI.  It is agravating not being
        able to spellcheck or to edit.

                                                        Ray Feeney



 -------------------------------------------------------------------------
 Donna Derby Yobs        Silicon Graphics -  NSD         yobs@engr.sgi.com
			 Product Marketing		 http://storm.engr  
