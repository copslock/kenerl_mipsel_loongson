Received:  by oss.sgi.com id <S553650AbQKNPeR>;
	Tue, 14 Nov 2000 07:34:17 -0800
Received: from smtp.algor.co.uk ([62.254.210.199]:50374 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S553645AbQKNPdx>;
	Tue, 14 Nov 2000 07:33:53 -0800
Received: from gladsmuir.algor.co.uk (dom@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id PAA16283;
	Tue, 14 Nov 2000 15:33:48 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.8.5/8.8.5) id PAA00560;
	Tue, 14 Nov 2000 15:44:13 GMT
Date:   Tue, 14 Nov 2000 15:44:13 GMT
Message-Id: <200011141544.PAA00560@gladsmuir.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dMNvDsnJMR"
Content-Transfer-Encoding: 7bit
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: MIPS HOWTO
In-Reply-To: <20001106204426.A23625@bacchus.dhis.org>
References: <20001106204426.A23625@bacchus.dhis.org>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--dMNvDsnJMR
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Ralf Baechle (ralf@oss.sgi.com) writes:

> November 15 is the deadline for a new edition of ``Linux, the Complete
> Reference'' which the MIPS Howto will be part of.  So please everybody
> take a look at the documente at http://oss.sgi.com/mips/mips-howto.html
> and send me updates, preferably as unified diffs for the SGML source
> code.

Here's one patch to your SGML for Algorithmics' boards:


--dMNvDsnJMR
Content-Type: text/plain
Content-Disposition: inline;
	filename="mips-howto.sgml.diff"
Content-Transfer-Encoding: 7bit

*** mips-howto.sgml~    Tue Nov  7 09:45:30 2000
--- mips-howto.sgml     Tue Nov 14 15:28:11 2000
***************
*** 296,308 ****
    This machine is a OEM variant of the SGI Indigo and therefore also still
    unsupported.
  
!   <sect2>Algorithmics P4032<p>
!   The Algorithmics P4032 port is at the time of this writing still running
!   Linux 2.1.36.
  
!   <sect2>Algorithmics P5064<p>
!   The P5064 is basically an R5000-based 64bit variant of the P4032.  A port is
!   ongoing.
  
    <sect2>DECstation series<p>
    During the late 80's and the early 90's Digital (now Compaq) built MIPS based 
--- 296,337 ----
    This machine is a OEM variant of the SGI Indigo and therefore also still
    unsupported.
  
!   <sect2>Algorithmics P-4032, P-5064, P-6032<p>
!   Algorithmics (<url url="http://www.algor.co.uk/">) make a series of
!   single-board computers for MIPS prototyping, and maintain Linux kernels
!   for all of them:
!   <itemize>
!     <item>P-6032 is a new board for CPUs with 32-bit buses (QED
!   RM5231, NEC Vr43x0, NEC Vr5432, IDT 64x74)
!     <item>P-4032 is an older board obsoleted by P-6032.
!     <item>P-5064 is for CPUs with 64-bit buses, notably QED's RM70xx
!   and RM52xx series.
!   </itemize>
  
!   All the boards have common I/O plus ethernet and disk interfaces
!   onboard, with spare PCI slots for adding different controllers.
!   They're highly configurable, so will run with either byte order.
!   All are suitable targets for 64-bit kernels, but (so far) all the
!   Linux work we've done has been using 32-bit code.
! 
!   They're available, supported and documented with PDF manuals
!   available online, like 
!   <url url="http://www.algor.co.uk/ftp/pub/doc/p6032-user.pdf">
!   for the P-6032.
! 
!   At the time of writing (November 2000) we are using a 2.2.x
!   kernel, and we're sharing kernel code with the ports being done by
!   people from MIPS Technologies Inc (<url url="http://www.mips.com">).
!   Algorithmics wrote the floating point trap handler and emulator used
!   in this kernel - essential for MIPS CPUs to run floating point
!   operations reliably and correctly.
! 
!   Algorithmics' kernels and a link to the MIPS userland can be found
!   from a jump page at
!   <url url="http://www.algor.co.uk/algor/info/linux.html">
!   
!   You can contact us at <htmlurl url="mailto:ask@algor.co.uk"
!   name="Algorithmics">.
  
    <sect2>DECstation series<p>
    During the late 80's and the early 90's Digital (now Compaq) built MIPS based 

--dMNvDsnJMR
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk

--dMNvDsnJMR--
