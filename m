Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 08:15:05 +0100 (BST)
Received: from semigate.zarlink.com ([IPv6:::ffff:209.226.172.94]:24228 "EHLO
	semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S8225296AbTJVHOd> convert rfc822-to-8bit; Wed, 22 Oct 2003 08:14:33 +0100
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.11.6+Sun/8.10.2) with ESMTP id h9M7EQC24505
	for <linux-mips@linux-mips.org>; Wed, 22 Oct 2003 03:14:26 -0400 (EDT)
Subject: Re: module dependency files
To: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF86FA85AC.EA0A3B86-ON80256DC7.00270886@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Wed, 22 Oct 2003 08:14:18 +0100
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.12  |February 13, 2003) at
 10/22/2003 03:14:26 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips


You'd need to do a MIPS cross-compile of modutils, I guess. As an
alternative there is a perl script (depmod.pl) out there that can handle
'foreign' binaries. I haven't had cause to use it on MIPS yet, but have
used it ok PPC. I think it comes with the busybox package.

Col





                                                                                                                                           
                      Jan-Benedict Glaw                                                                                                    
                      <jbglaw@lug-owl.de>          To:       linux-mips@linux-mips.org                                                     
                      Sent by:                     cc:                                                                                     
                      linux-mips-bounce@lin        Subject:  Re: module dependency files                                                   
                      ux-mips.org                                                                                                          
                                                                                                                                           
                                                                                                                                           
                      10/22/03 07:57 AM                                                                                                    
                                                                                                                                           
                                                                                                                                           




On Tue, 2003-10-21 18:15:56 -0400, David Kesselring
<dkesselr@mmc.atmel.com>
wrote in message
<Pine.GSO.4.44.0310211814340.14473-100000@ares.mmc.atmel.com>:
> That's what I did. I defined INSTALL_MOD_PATH as $(TOPDIR)/modules. The
> modules get put there but depmod fails.

depmod works on it's own architecture and I don't recall a way that
would make it work on cross-compiled modules. Maybe you should just copy
over the modules (INSTALL_MOD_PATH is a good start here) and execute
depmod on the target system...

Apart from that, insmod (instead of modprobe) should always work,
though...

MfG, JBG

--
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen
Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM |
TCPA));


<< Attachment removed : attxmd4r.dat >>
