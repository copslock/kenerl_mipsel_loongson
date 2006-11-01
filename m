Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 22:42:41 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:65506 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S20038932AbWKAWmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 22:42:35 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id kA1MgNlP014361;
	Wed, 1 Nov 2006 22:42:23 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id kA1MgMDL013205;
	Wed, 1 Nov 2006 22:42:22 GMT
Message-ID: <45492407.7090606@am.sony.com>
Date:	Wed, 01 Nov 2006 14:47:35 -0800
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
	linux-mips@linux-mips.org
Subject: MIPS processors gain GNU/Linux binary prelinker
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

FYI - For those interested in bootup time improvements on MIPS
processors, here is some information about the recently
developed MIPS prelinking feature, done by CodeSourcery
and MIPS Technologies.

http://www.linuxdevices.com/news/NS6220941326.html

This press release does not mention CELF, but it should
be noted that the first public demonstration of this
technology was performed (I believe) at the recent CELF technical
jamboree, in Tokyo Japan, held just last Friday (Oct 27).

See http://tree.celinuxforum.org/CelfPubWiki/JapanTechnicalJamboree11
for information about the jamboree.  The presentation about
this technology which was delivered at the meeting is at:

http://tree.celinuxforum.org/CelfPubWiki/JapanTechnicalJamboree11?action=AttachFile&do=get&target=MIPS-Prelinker.pdf

MIPS and CodeSourcery brought a demo so we got to do
some actual speed comparisons live at the event.  It was fun!

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
