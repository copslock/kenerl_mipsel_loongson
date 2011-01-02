Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 21:06:33 +0100 (CET)
Received: from gateway04.websitewelcome.com ([67.18.21.5]:56234 "HELO
        gateway04.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491056Ab1ABUGa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 21:06:30 +0100
Received: (qmail 21877 invoked from network); 2 Jan 2011 20:06:17 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway04.websitewelcome.com with SMTP; 2 Jan 2011 20:06:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=kevink.net;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=RDQnmuNIBXGBPwwuo8OJoFsSiyG/5DCeZTsLdBan0m1wc+i6ApfwrfjN3IPwrLsKpmnhstnWwFR5JT6MarHUxdi0WbjHbEiVcVX2nRf1vmAGy/n4DY6bQqOKwVY9wCpH;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:3574 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@kevink.net>)
        id 1PZUC2-0007De-8D
        for linux-mips@linux-mips.org; Sun, 02 Jan 2011 14:06:23 -0600
Message-ID: <4D20DABE.5020306@kevink.net>
Date:   Sun, 02 Jan 2011 12:06:22 -0800
From:   "Kevin D. Kissell" <kevink@kevink.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Linux MIPS org <linux-mips@linux-mips.org>
Subject: CygWin Cross-tool Package?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kevink.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@kevink.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@kevink.net
Precedence: bulk
X-list: linux-mips

As the person guilty of inventing the damned thing, I've been trying to
help folks keep the SMTC kernel working, but it's strictly a spare-time
thing - nobody pays me for time or materials.  So I'm not willing to
spend the time and money to set up a Linux box at home that would serve
only to build SMTC kernels.  For better or for worse, my home office
system is a Windows XP machine.   I've got Cygwin installed, and that
gives me git to peruse the sources, but I've got no means of building a
kernel.  I know that, in theory, I could build my own MIPS/Linux cross
tools under Cygwin, but looking at various email archives, it looks like
the procedure is moderately complex and fragile, and, frankly, I just
don't have the spare time to deal with it.  By any chance, could one of
you point me to a functional, pre-built package I could install under
Cygwin to do kernel builds?

            Regards,

            Kevin K.
