Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 May 2009 10:41:03 +0100 (BST)
Received: from ugmailsb.ugent.be ([157.193.71.46]:56537 "EHLO
	ugmailsb.ugent.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024393AbZE3Jk5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 30 May 2009 10:40:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by ugmailsb.ugent.be (Postfix) with ESMTP id CE3C62AB9BA
	for <linux-mips@linux-mips.org>; Sat, 30 May 2009 11:40:56 +0200 (CEST)
X-Virus-Scanned: by UGent DICT
Received: from ugmailsb.ugent.be ([127.0.0.1])
	by localhost (ugmailsb.ugent.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5pH-zI8nUJJ for <linux-mips@linux-mips.org>;
	Sat, 30 May 2009 11:40:56 +0200 (CEST)
Received: from cedar.ugent.be (cedar.ugent.be [157.193.49.14])
	by ugmailsb.ugent.be (Postfix) with ESMTP id 93EB72AB9B5
	for <linux-mips@linux-mips.org>; Sat, 30 May 2009 11:40:56 +0200 (CEST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnMCAM6bIEpOIAnR/2dsb2JhbAAI0BOEDAU
Received: from lump.einval.com (HELO [10.13.0.125]) ([78.32.9.209])
  by smtps9.UGent.be with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 May 2009 11:40:55 +0200
Message-ID: <4A20FF40.6010008@debian.org>
Date:	Sat, 30 May 2009 11:41:20 +0200
From:	Luk Claes <luk@debian.org>
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
MIME-Version: 1.0
To:	debian-mips@lists.debian.org
CC:	linux-mips@linux-mips.org
Subject: ld: non-dynamic relocations refer to dynamic symbol
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <luk@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luk@debian.org
Precedence: bulk
X-list: linux-mips

Hi

There appears to be a mips specific bug in binutils which make some 
packages fail to build when linking. More details can be found in debian 
bug #519006 [0] and binutils upstream bug #10144 [1].

Can someone please look into it?

Thanks already

Luk

Debian Release Manager

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=519006
[1] http://sourceware.org/bugzilla/show_bug.cgi?id=10144
